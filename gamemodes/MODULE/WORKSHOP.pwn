#define MAX_WORKSHOP 100
#define MAX_WORKSHOP_EMPLOYEE 3
#define MAX_WORKSHOP_INT 7000

enum E_WORKSHOP
{
    wID,
    wName[24],
    wOwner[MAX_PLAYER_NAME + 1],
    wComp,
    wMat,
    wMoney,
    Text3D:wText,
    Text3D:wTxt,
    wPickup,
    Float:wX,
    Float:wY,
    Float:wZ,
    wStatus,
    wPrice
};
new wsData[MAX_WORKSHOP][E_WORKSHOP],
    wsEmploy[MAX_WORKSHOP][3][MAX_PLAYER_NAME + 1],
    Iterator:Workshop<MAX_WORKSHOP>;

Workshop_Refresh(id)
{
    if(id != -1)
    {
        static
        string[255];

        if(IsValidDynamic3DTextLabel(wsData[id][wText]))
            DestroyDynamic3DTextLabel(wsData[id][wText]);

        if(IsValidDynamic3DTextLabel(wsData[id][wTxt]))
            DestroyDynamic3DTextLabel(wsData[id][wTxt]);

		if(IsValidDynamicPickup(wsData[id][wPickup]))
			  DestroyDynamicPickup(wsData[id][wPickup]), wsData[id][wPickup] = -1;

        if(strcmp(wsData[id][wOwner], "-"))
		{
		    if(wsData[id][wStatus] == 0)
        	{
				format
				(
					string, sizeof(string),
					""AQUA"[ID: %d]\n"AQUA"Workshop: {FFFFFF}%s\n"AQUA"Owner: "WHITE_E"%s\n"AQUA"Status: {7fffd4}[{FF4040}CLOSED{7fffd4}]",
					id,
					wsData[id][wName],
					wsData[id][wOwner]
				);
			}
   			else if(wsData[id][wStatus] == 1)
      		{
                format
				(
					string, sizeof(string),
					""AQUA"[ID: %d]\n"AQUA"Workshop: {FFFFFF}%s\n"AQUA"Owner: "WHITE_E"%s\n"AQUA"Status: {7fffd4}[{8CCB5E}OPEN{7fffd4}]",
					id,
					wsData[id][wName],
					wsData[id][wOwner]
				);
      		}
        }
        else
        {
            format
			(
				string, sizeof(string),
				""AQUA"[ID: %d]\n"AQUA"Location: {FFFFFF}%s\n"AQUA"Price: {FFFFFF}%s\n"AQUA"[TYPE '/buy' TO PURCHASE]",
				id,
				GetLocation(wsData[id][wX], wsData[id][wY], wsData[id][wZ]),
				FormatMoney(wsData[id][wPrice])
			);
        }

		wsData[id][wText] = CreateDynamic3DTextLabel(string, COLOR_GREEN, wsData[id][wX], wsData[id][wY], wsData[id][wZ], 10, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0);
		//wsData[id][wPickup] = CreateDynamicPickup(1239, 23, wsData[id][wX], wsData[id][wY], wsData[id][wZ]+0.2, -1);
    }
    return 1;
}

Workshop_Save(id)
{
    new query[2248];
    format(query, sizeof query,"UPDATE workshop SET owner='%s', name='%s', component=%d, material=%d, money=%d, posx='%f', posy='%f', posz='%f', status=%d, price=%d",
        wsData[id][wOwner],
        wsData[id][wName],
        wsData[id][wComp],
        wsData[id][wMat],
        wsData[id][wMoney],
        wsData[id][wX],
        wsData[id][wY],
        wsData[id][wZ],
        wsData[id][wStatus],
        wsData[id][wPrice]);
    for(new z = 0; z < MAX_WORKSHOP_EMPLOYEE; z++)
    {
        format(query, sizeof query,"%s, employe%d='%s'", query, z, wsEmploy[id][z]);
    }
    format(query, sizeof query,"%s WHERE id = %d", query, id);
    return mysql_tquery(g_SQL, query);
}

Workshop_Reset(id)
{
    format(wsData[id][wOwner], MAX_PLAYER_NAME, "-");
    format(wsEmploy[id][0], MAX_PLAYER_NAME, "-");
    format(wsEmploy[id][1], MAX_PLAYER_NAME, "-");
    format(wsEmploy[id][2], MAX_PLAYER_NAME, "-");
    wsData[id][wComp] = 0;
    wsData[id][wMat] = 0;
    wsData[id][wMoney] = 0;
    for(new z = 0; z < MAX_WORKSHOP_EMPLOYEE; z++)
    {
        format(wsEmploy[id][z], MAX_PLAYER_NAME, "-");
    }
    Workshop_Refresh(id);
}

IsWorkshopEmploye(playerid, id)
{
    if(!strcmp(wsEmploy[id][0], pData[playerid][pName], true)) return 1;
    if(!strcmp(wsEmploy[id][1], pData[playerid][pName], true)) return 1;
    if(!strcmp(wsEmploy[id][2], pData[playerid][pName], true)) return 1;
    return 0;
}

IsWorkshopOwner(playerid, id)
{
    if(!strcmp(wsData[id][wOwner], pData[playerid][pName], true))
        return 1;

    return 0;
}

function LoadWorkshop()
{
    static wid;

	new rows = cache_num_rows(), owner[128], name[128];
 	if(rows)
  	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "id", wid);
			cache_get_value_name(i, "owner", owner);
			format(wsData[wid][wOwner], 128, owner);
			cache_get_value_name(i, "name", name);
			format(wsData[wid][wName], 128, name);
			cache_get_value_name_int(i, "price", wsData[wid][wPrice]);
			cache_get_value_name_float(i, "posx", wsData[wid][wX]);
			cache_get_value_name_float(i, "posy", wsData[wid][wY]);
			cache_get_value_name_float(i, "posz", wsData[wid][wZ]);
			cache_get_value_name_int(i, "component", wsData[wid][wComp]);
			cache_get_value_name_int(i, "material", wsData[wid][wMat]);
            cache_get_value_name_int(i, "money", wsData[wid][wMoney]);
            for(new z = 0; z < MAX_WORKSHOP_EMPLOYEE; z++)
            {
                new str[64];
                format(str, sizeof str,"employe%d", z);
                cache_get_value_name(i, str, wsEmploy[wid][z]);
            }
			Workshop_Refresh(wid);
			Iter_Add(Workshop, wid);
		}
		printf("[WORKSHOP] Number of Loaded: %d.", rows);
	}
}

GetOwnedWorkshop(playerid)
{
	new tmpcount;
	foreach(new wid : Workshop)
	{
	    if(!strcmp(wsData[wid][wOwner], pData[playerid][pName], true))
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}

ReturnPlayerWorkshopID(playerid, hslot)
{
	new tmpcount;
	if(hslot < 1 && hslot > LIMIT_PER_PLAYER) return -1;
	foreach(new wid : Workshop)
	{
	    if(!strcmp(pData[playerid][pName], wsData[wid][wOwner], true))
	    {
     		tmpcount++;
       		if(tmpcount == hslot)
       		{
        		return wid;
  			}
	    }
	}
	return -1;
}

GetAnyWorkshop()
{
	new tmpcount;
	foreach(new id : Workshop)
	{
     	tmpcount++;
	}
	return tmpcount;
}

ReturnWorkshopID(slot)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_WORKSHOP) return -1;
	foreach(new id : Workshop)
	{
        tmpcount++;
        if(tmpcount == slot)
        {
            return id;
        }
	}
	return -1;
}

CMD:whelp(playerid)
{
	new line3[500];
	strcat(line3, "Workshop Duty: "WHITE_E"/wduty");
	strcat(line3, "Workshop My: "WHITE_E"/wmy\n");
	strcat(line3, "Workshop Menu: "WHITE_E"/wmenu");
	strcat(line3, "Workshop Lock: "WHITE_E"/wlock\n");
   	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""ORANGE_E"Clarnce "WHITE_E"Workshop Help", line3, "OK", "");
	return 1;
}

//Mechanic jobs
CMD:mechduty(playerid)
{
	if(pData[playerid][pJob] == 2 || pData[playerid][pJob2] == 2)
	{
		if(pData[playerid][pMechDuty] == 0)
		{
			pData[playerid][pMechDuty] = 1;
			SetPlayerColor(playerid, COLOR_GREEN);
			Servers(playerid, "Anda telah on duty dari mech duty!");
			//SendClientMessageToAllEx(COLOR_GREEN, "[MECH]"WHITE_E" %s is now on taxi duty. Type \"/call 1222\" to call a taxi!", ReturnName(playerid, 0));
		}
		else
		{
			pData[playerid][pMechDuty] = 0;
			SetPlayerColor(playerid, COLOR_WHITE);
			Servers(playerid, "Anda telah off dari mech duty!");
		}
	}
	else return Error(playerid, "Anda bukan pekerja mechanic!");
	return 1;
}

CMD:wmenu(playerid, params[])
{
    foreach(new id : Workshop)
	{
        if(IsPlayerInRangeOfPoint(playerid, 4.0, wsData[id][wX], wsData[id][wY], wsData[id][wZ]))
        {
            if(!IsWorkshopOwner(playerid, id) && !IsWorkshopEmploye(playerid, id))
                return Error(playerid, "You're not the Owner or Employee of this Workshop");

            ShowWorkshopMenu(playerid, id);
        }
    }
    return 1;
}

ShowWorkshopMenu(playerid, id)
{
    pData[playerid][pMenuType] = 0;
    pData[playerid][pInWs] = id;

    new str[256], vstr[64];
    format(vstr, sizeof vstr,"\t{7fff00}Workshop %s", wsData[id][wName]);
    format(str, sizeof str,"Workshop Name\nWorkshop Employe Menu\nWorkshop Component\t[%d/%d]\nWorkshop Material\t[%d/%d]\nWorkshopMoney\t[{7fff00}%s{ffffff}]",
        wsData[id][wComp],
        MAX_WORKSHOP_INT,
        wsData[id][wMat],
        MAX_WORKSHOP_INT,
        FormatMoney(wsData[id][wMoney]));
    ShowPlayerDialog(playerid, WS_MENU, DIALOG_STYLE_LIST, vstr, str, "Select", "Cancel");
    return 1;
}

CMD:wcreate(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	new query[512];
	new wid = Iter_Free(Workshop);
	if(wid == -1) return Error(playerid, "You Don't Cant "ORANGE_E"Create "WHITE_E"Workshop");
	new price;
	if(sscanf(params, "d", price)) return Usage(playerid, "/wcreate [Workshop Price]");
	new totalcash[25];
	format(totalcash, sizeof totalcash,"%d00",price);
	price = strval(totalcash);
	format(wsData[wid][wOwner], MAX_PLAYER_NAME, "-");
    format(wsEmploy[wid][0], MAX_PLAYER_NAME, "-");
    format(wsEmploy[wid][1], MAX_PLAYER_NAME, "-");
    format(wsEmploy[wid][2], MAX_PLAYER_NAME, "-");
    format(wsData[wid][wName], 24, "-");
	GetPlayerPos(playerid, wsData[wid][wX], wsData[wid][wY], wsData[wid][wZ]);
	wsData[wid][wPrice] = price;
	wsData[wid][wStatus] = 0;

    Workshop_Refresh(wid);
	Iter_Add(Workshop, wid);

	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO workshop SET id=%d, owner='%s', price=%d, posx='%f', posy='%f', posz='%f', name='%s'", wid, wsData[wid][wOwner], wsData[wid][wPrice], wsData[wid][wX], wsData[wid][wY], wsData[wid][wZ], wsData[wid][wName]);
	mysql_tquery(g_SQL, query, "OnWorkshopCreated", "i", wid);
    Info(playerid, "Created Workshop ID:%d", wid);
	return 1;
}

function OnWorkshopCreated(wid)
{
	Workshop_Save(wid);
    Workshop_Refresh(wid);
	return 1;
}

CMD:wgoto(playerid, params[])
{
	new wid;
	if(pData[playerid][pAdmin] < 2)
        return PermissionError(playerid);

	if(sscanf(params, "d", wid))
		return Usage(playerid, "/wgoto [Workshop Id]");
	if(!Iter_Contains(Workshop, wid)) return Error(playerid, "The Workshop you specified ID of doesn't exist.");
	SetPlayerPos(playerid, wsData[wid][wX], wsData[wid][wY], wsData[wid][wZ]);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
	Info(playerid, "You has teleport to Workshop id %d", wid);
	return 1;
}

CMD:wedit(playerid, params[])
{
    static
        wid,
        type[24],
        string[128];

    if(pData[playerid][pAdmin] < 6)
        return PermissionError(playerid);

    if(sscanf(params, "ds[24]S()[128]", wid, type, string))
    {
        Usage(playerid, "/wedit [Workshop Id] [Part]");
        SendClientMessage(playerid, COLOR_RIKO, "PART:{FFFFFF} name, owner, price, location, money, component, material, status, reset, delete");
        return 1;
    }
    if((wid < 0 || wid >= MAX_WORKSHOP))
        return Error(playerid, "You have specified an invalid ID.");
	if(!Iter_Contains(Workshop, wid)) return Error(playerid, "Invalid Workshop Id");

    if(!strcmp(type, "location", true))
    {
		GetPlayerPos(playerid, wsData[wid][wX], wsData[wid][wY], wsData[wid][wZ]);
        Workshop_Save(wid);
		Workshop_Refresh(wid);

        SendAdminMessage(COLOR_RED, "%s Has changed the location of the workshop id "YELLOW_E"%d", pData[playerid][pAdminname], wid);
	}
    else if(!strcmp(type, "status", true))
    {
        new locked;

        if(sscanf(string, "d", locked))
            return Usage(playerid, "/workshopedit [Workshop Id] [Status] [0/1]");

        if(locked < 0 || locked > 1)
            return Error(playerid, "0 : "RED_E"Closed "WHITE_E"1 : "LG_E"Open");

        wsData[wid][wStatus] = locked;
        Workshop_Save(wid);
		Workshop_Refresh(wid);

        if(locked) {
            SendAdminMessage(COLOR_RED, "%s Has opened a workshop id "YELLOW_E"%d", pData[playerid][pAdminname], wid);
        }
        else {
            SendAdminMessage(COLOR_RED, "%s Has opened a workshop id "YELLOW_E"%d", pData[playerid][pAdminname], wid);
        }
    }
    if(!strcmp(type, "name", true))
    {
	    new name[50];

	    if(sscanf(string, "s[50]", name))
  			return Usage(playerid, "/workshopedit [Workshop Id] [Name]");

	    format(wsData[wid][wName], 128, name);
	    Workshop_Refresh(wid);
	    Workshop_Save(wid);
    }
    else if(!strcmp(type, "price", true))
    {
        new price;

        if(sscanf(string, "d", price))
            return Usage(playerid, "/workshopedit [Workshop Id] [Price] [Amount]");

        wsData[wid][wPrice] = price;

        Workshop_Save(wid);
		Workshop_Refresh(wid);
        SendAdminMessage(COLOR_RED, "%s Has changed the price of the workshop id "YELLOW_E"%d "RED_E"to "LG_E"%d", pData[playerid][pAdminname], wid, price);
    }
	else if(!strcmp(type, "money", true))
    {
        new money;

        if(sscanf(string, "d", money))
            return Usage(playerid, "/workshopedit [Workshop Id] [Money] [Ammount]");

        wsData[wid][wMoney] = money;
        Workshop_Save(wid);
		Workshop_Refresh(wid);
        SendAdminMessage(COLOR_RED, "%s Changed the amount of workshop money "YELLOW_E"%d "RED_E"to "LG_E"%s.", pData[playerid][pAdminname], wid, FormatMoney(money));
    }
	else if(!strcmp(type, "component", true))
    {
        new amount;

        if(sscanf(string, "d", amount))
            return Usage(playerid, "/workshopedit [Workshop Id] [Component] [Ammount]");

        wsData[wid][wComp] = amount;
        Workshop_Save(wid);
		Workshop_Refresh(wid);
        SendAdminMessage(COLOR_RED, "%s Changed the number of workshop components "YELLOW_E"%d "RED_E"to "YELLOW_E"%d.", pData[playerid][pAdminname], wid, amount);
    }
    else if(!strcmp(type, "material", true))
    {
        new amount;

        if(sscanf(string, "d", amount))
            return Usage(playerid, "/workshopedit [Workshop Id] [Material] [Ammount]");

        wsData[wid][wMat] = amount;
        Workshop_Save(wid);
		Workshop_Refresh(wid);
        SendAdminMessage(COLOR_RED, "%s Changed the number of workshop materials "YELLOW_E"%d "RED_E"to "YELLOW_E"%d.", pData[playerid][pAdminname], wid, amount);
    }
    else if(!strcmp(type, "owner", true))
    {
        new owners[MAX_PLAYER_NAME];

        if(sscanf(string, "s[24]", owners))
            return Usage(playerid, "/editws [id] [owner] [player name] [use '-' to no owner]");

        format(wsData[wid][wOwner], MAX_PLAYER_NAME, owners);

        Workshop_Save(wid);
		Workshop_Refresh(wid);
        SendAdminMessage(COLOR_RED, "%s Have changed the name of the workshop owner id "YELLOW_E"%d "RED_E"to "YELLOW_E"%s", pData[playerid][pAdminname], wid, owners);
    }
    else if(!strcmp(type, "reset", true))
    {
        Workshop_Reset(wid);
		Workshop_Save(wid);
		Workshop_Refresh(wid);
        SendAdminMessage(COLOR_RED, "%s Have reset workshop id "YELLOW_E"%d", pData[playerid][pAdminname], wid);
    }
	else if(!strcmp(type, "delete", true))
    {
		Workshop_Reset(wid);

		DestroyDynamic3DTextLabel(wsData[wid][wText]);
        DestroyDynamicPickup(wsData[wid][wPickup]);

		wsData[wid][wX] = 0;
		wsData[wid][wY] = 0;
		wsData[wid][wZ] = 0;
		wsData[wid][wPrice] = 0;
		wsData[wid][wText] = Text3D: INVALID_3DTEXT_ID;
		wsData[wid][wPickup] = -1;

		Iter_Remove(Workshop, wid);
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM Workshop WHERE ID=%d", wid);
		mysql_tquery(g_SQL, query);
        SendAdminMessage(COLOR_RED, "%s Have reset workshop id "YELLOW_E"%d", pData[playerid][pAdminname], wid);
	}
    return 1;
}

CMD:wlock(playerid, params[])
{
	foreach(new wid : Workshop)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.5, wsData[wid][wX], wsData[wid][wY], wsData[wid][wZ]))
		{
			if(!IsWorkshopOwner(playerid, wid) && !IsWorkshopEmploye(playerid, wid)) return Error(playerid, "Kamu bukan pengurus Workshop ini.");
			if(!wsData[wid][wStatus])
			{
				wsData[wid][wStatus] = 1;
				Workshop_Save(wid);

				InfoTD_MSG(playerid, 4000, "Workshop ~g~Open");
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
			}
			else
			{
				wsData[wid][wStatus] = 0;
				Workshop_Save(wid);

				InfoTD_MSG(playerid, 4000,"Workshop ~g~Closed");
				PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
			}
            Workshop_Refresh(wid);
		}
	}
	return 1;
}

CMD:wmy(playerid)
{
	if(!GetOwnedWorkshop(playerid)) return Error(playerid, "You don't have any Workshop.");
	new wid, _tmpstring[128], count = GetOwnedWorkshop(playerid), CMDSString[512];
	CMDSString = "";
	new lock[128];
	strcat(CMDSString,"No\tName(Status)\tLocation\n",sizeof(CMDSString));
	Loop(itt, (count + 1), 1)
	{
	    wid = ReturnPlayerWorkshopID(playerid, itt);
		if(wsData[wid][wStatus] == 1)
		{
			lock = "{7FFF00}OPEN{ffffff}";
		}
		else
		{
			lock = "{FF0000}CLOSED{ffffff}";
		}
		if(itt == count)
		{
		    format(_tmpstring, sizeof(_tmpstring), "%d\t%s{ffffff}(%s)\t%s{ffffff}\n", itt, wsData[wid][wName], lock, GetLocation(wsData[wid][wX], wsData[wid][wY], wsData[wid][wZ]));
		}
		else format(_tmpstring, sizeof(_tmpstring), "%d\t%s{ffffff}(%s)\t%s{ffffff}\n", itt, wsData[wid][wName], lock, GetLocation(wsData[wid][wX], wsData[wid][wY], wsData[wid][wZ]));
		strcat(CMDSString, _tmpstring);
	}
	ShowPlayerDialog(playerid, DIALOG_MY_WS, DIALOG_STYLE_TABLIST_HEADERS, "My Workshop", CMDSString, "Track", "Cancel");
	return 1;
}

stock IsPlayerInRangeOfPlayer(playerid, to_player, Float: distance)
{
	new Float: x, Float: y, Float: z;
	GetPlayerPos(to_player, x, y, z);

	return IsPlayerInRangeOfPoint(playerid, distance, x, y, z);
}

Player_OwnsWorkshop(playerid, id)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(id == -1) return 0;
	if(!strcmp(wsData[id][wOwner], pData[playerid][pName], true)) return 1;
	return 0;
}

Player_WorkshopCount(playerid)
{
	#if LIMIT_PER_PLAYER != 0
    new count;
	foreach(new i : Workshop)
	{
		if(Player_OwnsWorkshop(playerid, i)) count++;
	}

	return count;
	#else
	return 0;
	#endif
}
