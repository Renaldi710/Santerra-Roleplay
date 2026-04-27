#define MAX_ARRESTPOINTS			10

enum arrestInfo
{
	arrestSQLId,
	arrestType,
	Float: arrestPosX,
	Float: arrestPosY,
	Float: arrestPosZ,
	arrestVW,
	arrestInt,
	Text3D: arrestTextID,
	arrestPickupID
}
new ArrestPoints[MAX_ARRESTPOINTS][arrestInfo],
     Iterator:ARESST<MAX_ARRESTPOINTS>;

function LoadARR()
{
	new rows;
	cache_get_row_count(rows);
	if(rows)
  	{
 		new id, i = 0, str[55];
		while(i < rows)
		{
		    cache_get_value_name_int(i, "id", id);
			cache_get_value_name_float(i, "PosX", ArrestPoints[id][arrestPosX]);
			cache_get_value_name_float(i, "PosY", ArrestPoints[id][arrestPosY]);
			cache_get_value_name_float(i, "PosZ", ArrestPoints[id][arrestPosZ]);
			cache_get_value_name_int(i, "Int", ArrestPoints[id][arrestInt]);
			cache_get_value_name_int(i, "VW", ArrestPoints[id][arrestVW]);
			format(str, sizeof(str), "[ID: %d]\n{FF0000}/arrest {FFFFFF}to arrest suspect and /release to release suspect", id);
			ArrestPoints[id][arrestTextID] = CreateDynamic3DTextLabel(str, COLOR_LBLUE, ArrestPoints[id][arrestPosX], ArrestPoints[id][arrestPosY], ArrestPoints[id][arrestPosZ]+0.3, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, ArrestPoints[id][arrestVW], ArrestPoints[id][arrestInt], -1, 10.0);
			Iter_Add(ARESST, id);
	    	i++;
		}
		printf("[MySQL ARREST] ARREST Loaded Number: %d.", i);
	}
}

SaveArrestPoints(id)
{
	new cQuery[512];
	format(cQuery, sizeof(cQuery), "UPDATE arrestpoints SET PosX='%f', PosY='%f', PosZ='%f', VW='%d', Int='%d, Type='%d WHERE id='%d'",
	ArrestPoints[id][arrestPosX],
	ArrestPoints[id][arrestPosY],
	ArrestPoints[id][arrestPosZ],
	ArrestPoints[id][arrestVW],
	ArrestPoints[id][arrestInt],
	ArrestPoints[id][arrestType],
	id
	);
	return mysql_tquery(g_SQL, cQuery);
}

CMD:createarrest(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new id = Iter_Free(ARESST), query[512];
	if(id == -1) return Error(playerid, "Can't add any more arrest.");
 	new Float: x, Float: y, Float: z;
 	GetPlayerPos(playerid, x, y, z);

	ArrestPoints[id][arrestPosX] = x;
	ArrestPoints[id][arrestPosY] = y;
	ArrestPoints[id][arrestPosZ] = z;
	ArrestPoints[id][arrestInt] = GetPlayerInterior(playerid);
	ArrestPoints[id][arrestVW] = GetPlayerVirtualWorld(playerid);

	new str[128];
	format(str, sizeof(str), "[ID: %d]\n{FF0000}/arrest {FFFFFF}to arrest a suspect and /release to release suspect", id);
	ArrestPoints[id][arrestTextID] = CreateDynamic3DTextLabel(str, COLOR_LBLUE, ArrestPoints[id][arrestPosX], ArrestPoints[id][arrestPosY], ArrestPoints[id][arrestPosZ] + 0.3, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, ArrestPoints[id][arrestVW], ArrestPoints[id][arrestInt], -1, 10.0);
	Iter_Add(ARESST, id);

	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO arrestpoints SET id='%d', PosX='%f', PosY='%f', PosZ='%f', VW='%d', Int='%d', Type='%d'", id, ArrestPoints[id][arrestPosX], ArrestPoints[id][arrestPosY], ArrestPoints[id][arrestPosZ], GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), ArrestPoints[id][arrestType]);
	mysql_tquery(g_SQL, query, "OnArrestCreated", "ii", playerid, id);
	return 1;
}

function OnArrestCreated(playerid, id)
{
	SaveArrestPoints(id);
	Servers(playerid, "You has created ATM id: %d.", id);
	return 1;
}

CMD:editarrest(playerid, params[])
{
	if (pData[playerid][pAdmin] >= 4)
	{
		new string[128], choice[32], id, amount;
		if(sscanf(params, "s[32]dD", choice, id, amount))
		{
			SendClientMessageEx(playerid, COLOR_GREY, "USAGE: /arrestedit [name] [id] [amount]");
			SendClientMessageEx(playerid, COLOR_GREY, "Available names: Position, Type, Delete");
			return 1;
		}

		if(id >= MAX_ARRESTPOINTS)
		{
			SendClientMessageEx(playerid, COLOR_WHITE, "Invalid Arrest Points ID!");
			return 1;
		}

		if(strcmp(choice, "position", true) == 0)
		{
			GetPlayerPos(playerid, ArrestPoints[id][arrestPosX], ArrestPoints[id][arrestPosY], ArrestPoints[id][arrestPosZ]);
			ArrestPoints[id][arrestInt] = GetPlayerInterior(playerid);
			ArrestPoints[id][arrestVW] = GetPlayerVirtualWorld(playerid);
			format(string, sizeof(string), "You have changed the position on Arrest Point #%d.", id);
			SendClientMessageEx(playerid, COLOR_WHITE, string);
			DestroyDynamic3DTextLabel(ArrestPoints[id][arrestTextID]);
			DestroyDynamicPickup(ArrestPoints[id][arrestPickupID]);
			switch(ArrestPoints[id][arrestType])
			{
				case 0:
				{
					format(string, sizeof(string), "/arrest\nArrest Point #%d", id);
					ArrestPoints[id][arrestTextID] = CreateDynamic3DTextLabel(string, COLOR_DBLUE, ArrestPoints[id][arrestPosX], ArrestPoints[id][arrestPosY], ArrestPoints[id][arrestPosZ]+0.6, 4.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, ArrestPoints[id][arrestVW], ArrestPoints[id][arrestInt], -1);
					ArrestPoints[id][arrestPickupID] = CreateDynamicPickup(1247, 23, ArrestPoints[id][arrestPosX], ArrestPoints[id][arrestPosY], ArrestPoints[id][arrestPosZ], ArrestPoints[id][arrestVW]);
				}
			}
			SaveArrestPoints(id);
			return 1;
		}
		else if(strcmp(choice, "delete", true) == 0)
		{
			if(ArrestPoints[id][arrestPosX] == 0)
			{
				format(string, sizeof(string), "Arrest Point #%d does not exist.", id);
				SendClientMessageEx(playerid, COLOR_WHITE, string);
				return 1;
			}
			DestroyDynamic3DTextLabel(ArrestPoints[id][arrestTextID]);
			DestroyDynamicPickup(ArrestPoints[id][arrestPickupID]);
			ArrestPoints[id][arrestPosX] = 0.0;
			ArrestPoints[id][arrestPosY] = 0.0;
			ArrestPoints[id][arrestPosZ] = 0.0;
			ArrestPoints[id][arrestVW] = 0;
			ArrestPoints[id][arrestInt] = 0;
			ArrestPoints[id][arrestType] = 0;
			SaveArrestPoints(id);
			format(string, sizeof(string), "You have deleted Arrest Point #%d.", id);
			SendClientMessageEx(playerid, COLOR_WHITE, string);
			return 1;
		}
	}
	else SendClientMessageEx(playerid, COLOR_GRAD1, "You are not authorized to use that command.");
	return 1;
}

CMD:gotoarrest(playerid, params[])
{
	new id;
	if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);

	if(sscanf(params, "d", id))
		return Usage(playerid, "/gotoarrest [id]");
	if(!Iter_Contains(ARESST, id)) return Error(playerid, "The atm you specified ID of doesn't exist.");

	SetPlayerPosition(playerid, ArrestPoints[id][arrestPosX], ArrestPoints[id][arrestPosY], ArrestPoints[id][arrestPosZ], 2.0);
    SetPlayerInterior(playerid, ArrestPoints[id][arrestInt]);
    SetPlayerVirtualWorld(playerid, ArrestPoints[id][arrestVW]);
	Servers(playerid, "You has teleport to arrest id %d", id);
	return 1;
}
