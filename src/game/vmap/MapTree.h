/*
 * This file is part of the CMaNGOS Project. See AUTHORS file for Copyright information
 *
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

#pragma once

#include "Platform/Define.h"
#include <unordered_map>
#include "BIH.h"

namespace VMAP
{
    class ModelInstance;
    class GroupModel;
    class VMapManager2;

    struct LocationInfo
    {
        LocationInfo() : hitInstance(nullptr), hitModel(nullptr), ground_Z(-G3D::inf()) {};
        const ModelInstance* hitInstance;
        GroupModel const* hitModel;
        float ground_Z;
    };

    class StaticMapTree
    {
            typedef std::unordered_map<uint32, bool> loadedTileMap;
            typedef std::unordered_map<uint32, uint32> loadedSpawnMap;
        private:
            uint32 iMapID;
            bool iIsTiled;
            BIH iTree;
            ModelInstance* iTreeValues; // the tree entries
            uint32 iNTreeValues;

            // Store all the map tile idents that are loaded for that map
            // some maps are not splitted into tiles and we have to make sure, not removing the map before all tiles are removed
            // empty tiles have no tile file, hence map with bool instead of just a set (consistency check)
            loadedTileMap iLoadedTiles;
            // stores <tree_index, reference_count> to invalidate tree values, unload map, and to be able to report errors
            loadedSpawnMap iLoadedSpawns;
            std::string iBasePath;

        private:
            bool getIntersectionTime(G3D::Ray const& pRay, float& pMaxDist, bool pStopAtFirstHit = false, bool ignoreM2Model = false) const;
            // bool containsLoadedMapTile(unsigned int pTileIdent) const { return(iLoadedMapTiles.containsKey(pTileIdent)); }
        public:
            static std::string getTileFileName(uint32 mapID, uint32 tileX, uint32 tileY);
            static uint32 packTileID(uint32 tileX, uint32 tileY) { return tileX << 16 | tileY; }
            static void unpackTileID(uint32 ID, uint32& tileX, uint32& tileY) { tileX = ID >> 16; tileY = ID & 0xFF; }
            static bool CanLoadMap(std::string const& vmapPath, uint32 mapID, uint32 tileX, uint32 tileY);

            StaticMapTree(uint32 mapID, std::string const& basePath);
            ~StaticMapTree();

            bool isInLineOfSight(G3D::Vector3 const& pos1, G3D::Vector3 const& pos2, bool ignoreM2Model) const;
            ModelInstance* FindCollisionModel(G3D::Vector3 const& pos1, G3D::Vector3 const& pos2);
            bool getObjectHitPos(G3D::Vector3 const& pos1, G3D::Vector3 const& pos2, G3D::Vector3& pResultHitPos, float pModifyDist) const;
            float getHeight(G3D::Vector3 const& pPos, float maxSearchDist) const;
            bool getAreaInfo(G3D::Vector3& pos, uint32& flags, int32& adtId, int32& rootId, int32& groupId) const;
            bool isUnderModel(G3D::Vector3& pos, float* outDist = nullptr, float* inDist = nullptr) const;
            bool GetLocationInfo(Vector3 const& pos, LocationInfo& info) const;

            bool InitMap(std::string const& fname, VMapManager2* vm);
            void UnloadMap(VMapManager2* vm);
            bool LoadMapTile(uint32 tileX, uint32 tileY, VMapManager2* vm);
            void UnloadMapTile(uint32 tileX, uint32 tileY, VMapManager2* vm);
            bool isTiled() const { return iIsTiled; }
            uint32 numLoadedTiles() const { return iLoadedTiles.size(); }

#ifdef MMAP_GENERATOR
        public:
            void getModelInstances(ModelInstance*& models, uint32& count);
#endif
    };

    struct AreaInfo
    {
        AreaInfo() : result(false), ground_Z(-G3D::inf()), flags(0), adtId(0), rootId(0), groupId(0) {};
        bool result;
        float ground_Z;
        uint32 flags;
        int32 adtId;
        int32 rootId;
        int32 groupId;
    };
}                                                           // VMAP
