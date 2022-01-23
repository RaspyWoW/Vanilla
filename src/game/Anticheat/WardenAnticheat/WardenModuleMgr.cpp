/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

 /*
  *
  * This code was written by namreeb (legal@namreeb.org) and is released with
  * permission as part of vmangos (https://github.com/vmangos/core)
  *
  */

#include "WardenModuleMgr.hpp"
#include "WardenModule.hpp"

#include "Platform/Define.h"
#include "Policies/SingletonImp.h"
#include "Util.h"
#include "World.h"

#include <ace/OS_NS_dirent.h>

#include <vector>
#include <string>
#include <fstream>

INSTANTIATE_SINGLETON_1(WardenModuleMgr);

namespace
{
    std::vector<std::string> GetModuleNames(const std::string& moduleDir)
    {
        ACE_DIR* dirp = ACE_OS::opendir(ACE_TEXT(moduleDir.c_str()));

        std::vector<std::string> results;

        if (dirp)
        {
            ACE_DIRENT* dp;

            // look only for .bin files, and assume (for now) that the corresponding .key and .cr files exist
            while (!!(dp = ACE_OS::readdir(dirp)))
                if (!memcmp(&dp->d_name[strlen(dp->d_name) - 4], ".bin", 4))
                    results.emplace_back(moduleDir + "/" + dp->d_name);

#ifndef _WIN32
            // this causes a crash on Windows, so just accept a minor memory leak for now
            ACE_OS::closedir(dirp);
#endif
        }

        return results;
    }
}

WardenModuleMgr::WardenModuleMgr()
{
    const std::string& moduleDir = sWorld.GetWardenModuleDirectory();
    const std::vector<std::string>& modules = GetModuleNames(moduleDir);

    for (auto const& mod : modules)
    {
        const auto key = mod.substr(0, mod.length() - 3) + "key";
        const auto cr = mod.substr(0, mod.length() - 3) + "cr";

        try
        {
            auto newMod = WardenModule(mod, key, cr);

            if (newMod.Windows())
                _winModules.emplace_back(std::move(newMod));
            else
                _macModules.emplace_back(std::move(newMod));
        }
        catch (const std::runtime_error& e)
        {
            sLog.outError("Failed to load %s - %s\n", mod.c_str(), e.what());
            continue;
        }
    }
}

const WardenModule* WardenModuleMgr::GetWindowsModule() const
{
    MANGOS_ASSERT(!_winModules.empty());

    return &_winModules[urand(0, static_cast<std::vector<WardenModule, std::allocator<WardenModule>>::size_type>(_winModules.size()) - 1)];
}

const WardenModule* WardenModuleMgr::GetMacModule() const
{
    MANGOS_ASSERT(!_macModules.empty());

    return &_macModules[urand(0, static_cast<std::vector<WardenModule, std::allocator<WardenModule>>::size_type>(_macModules.size()) - 1)];
}
