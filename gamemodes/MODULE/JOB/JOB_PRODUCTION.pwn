CreateJoinProductionPoint()
{
	//JOBS
	new strings[128];
	CreateDynamicPickup(1239, 23, -86.2656, -299.3626, 2.7646, -1);
	format(strings, sizeof(strings), "[PRODUCTION JOBS]\n{ffffff}Jadilah Pekerja Production disini\n{7fffd4}/getjob /accept job");
	CreateDynamic3DTextLabel(strings, COLOR_LIGHTGREEN, -86.2656, -299.3626, 2.7646, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // production job
	
	CreateDynamicPickup(1239, 23, -116.9033, -313.0775, 2.7646, -1);
	format(strings, sizeof(strings), "[PRODUCTION JOBS]\n{FFFFFF}/createproduct");
	CreateDynamic3DTextLabel(strings, COLOR_LIGHTGREEN, -116.9033, -313.0775, 2.7646, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // production job
	
	CreateDynamicPickup(1239, 23, -130.6788, -313.0763, 2.7646, -1);
	format(strings, sizeof(strings), "[PRODUCTION JOBS]\n{FFFFFF}/createproduct");
	CreateDynamic3DTextLabel(strings, COLOR_LIGHTGREEN, -130.6788, -313.0763, 2.7646, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // production job
	
	CreateDynamicPickup(1239, 23, -144.5109, -313.0769, 2.7646, -1);
	format(strings, sizeof(strings), "[PRODUCTION JOBS]\n{FFFFFF}/createproduct");
	CreateDynamic3DTextLabel(strings, COLOR_LIGHTGREEN, -144.5109, -313.0769, 2.7646, 3.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // production job
}


CMD:createproduct(playerid, params[])
{
	if(pData[playerid][pJobTime] > 0) return Error(playerid, "Anda harus menunggu "GREY2_E"%d "WHITE_E"detik untuk bisa bekerja kembali.", pData[playerid][pJobTime]);
	if(pData[playerid][pJob] == 6 || pData[playerid][pJob2] == 6)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.0, -116.9033, -313.0775, 2.7646) || IsPlayerInRangeOfPoint(playerid, 2.0, -144.5109, -313.0769, 2.7646)
		|| IsPlayerInRangeOfPoint(playerid, 2.0, -130.6788, -313.0763, 2.7646))
		{
			new type;
			if(sscanf(params, "d", type)) return Usage(playerid, "/createproduct [type, 1.Food 2.Clothes 3.Equipment");
			
			if(type < 1 || type > 3) return Error(playerid, "Invalid type id.");
			
			if(type == 1)
			{
				if(pData[playerid][pActivityTime] > 5) return Error(playerid, "Anda masih memiliki activity progress!");
				if(pData[playerid][pFood] < 40) return Error(playerid, "Food tidak cukup!(Minimal: 40).");
				if(pData[playerid][CarryProduct] != 0) return Error(playerid, "Anda sedang membawa sebuah product");
				pData[playerid][pFood] -= 40;
				
				TogglePlayerControllable(playerid, 0);
				Info(playerid, "Anda sedang memproduksi bahan makanan dengan 40 food!");
				ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
				pData[playerid][pProducting] = SetTimerEx("CreateProduct", 1000, true, "id", playerid, 1);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Creating...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
			}
			else if(type == 2)
			{
				if(pData[playerid][pActivityTime] > 5) return Error(playerid, "Anda masih memiliki activity progress!");
				if(pData[playerid][pMaterial] < 40) return Error(playerid, "Material tidak cukup!(Butuh: 40).");
				if(pData[playerid][CarryProduct] != 0) return Error(playerid, "Anda sedang membawa sebuah product");
				pData[playerid][pMaterial] -= 40;
				
				TogglePlayerControllable(playerid, 0);
				Info(playerid, "Anda sedang memproduksi baju dengan 40 material!");
				ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
				pData[playerid][pProducting] = SetTimerEx("CreateProduct", 1000, true, "id", playerid, 2);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Creating...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				
			}
			else if(type == 3)
			{
				if(pData[playerid][pActivityTime] > 5) return Error(playerid, "Anda masih memiliki activity progress!");
				if(pData[playerid][pMaterial] < 40) return Error(playerid, "Material tidak cukup!(Butuh: 40).");
				if(pData[playerid][pComponent] < 20) return Error(playerid, "Component tidak cukup!(Butuh: 20).");
				if(pData[playerid][CarryProduct] != 0) return Error(playerid, "Anda sedang membawa sebuah product");
				pData[playerid][pMaterial] -= 40;
				pData[playerid][pComponent] -= 20;
				
				TogglePlayerControllable(playerid, 0);
				Info(playerid, "Anda sedang memproduksi equipment dengan 40 material dan 20 component!");
				ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
				pData[playerid][pProducting] = SetTimerEx("CreateProduct", 1000, true, "id", playerid, 3);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Creating...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
			}
		}
		else return Error(playerid, "You're not near in production warehouse.");
	}
	else Error(playerid, "Anda bukan pekerja sebagai operator produksi.");
	return 1;
}

function CreateProduct(playerid, type)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidTimer(pData[playerid][pProducting])) return 0;
	if(pData[playerid][pJob] == 6 || pData[playerid][pJob2] == 6)
	{
		if(pData[playerid][pActivityTime] >= 100)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.0, -116.9033, -313.0775, 2.7646) || IsPlayerInRangeOfPoint(playerid, 2.0, -144.5109, -313.0769, 2.7646)
			|| IsPlayerInRangeOfPoint(playerid, 2.0, -130.6788, -313.0763, 2.7646))
			{
				if(type == 1)
				{
					pData[playerid][CarryProduct] = 1;
					Info(playerid, "Anda telah berhasil membuat bahan makanan, /sellproduct untuk menjualnya.");
					TogglePlayerControllable(playerid, 1);
					InfoTD_MSG(playerid, 8000, "Food Created!");
					KillTimer(pData[playerid][pProducting]);
					pData[playerid][pActivityTime] = 0;
					HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
					PlayerTextDrawHide(playerid, ActiveTD[playerid]);
					pData[playerid][pEnergy] -= 3;
					ClearAnimations(playerid);
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.1, 1, 1, 1, 1, 1, 1);
    				SetPlayerAttachedObject(playerid, 0, 2912, 1, 0.436000, 0.519000, -0.342000, 0.000000, 0.000000, 0.000000, 1.000000,1.000000,1.000000);
				}
				else if(type == 2)
				{
					pData[playerid][CarryProduct] = 2;
					Info(playerid, "Anda telah berhasil membuat product baju, /sellproduct untuk menjualnya.");
					TogglePlayerControllable(playerid, 1);
					InfoTD_MSG(playerid, 8000, "Clothes Created!");
					KillTimer(pData[playerid][pProducting]);
					pData[playerid][pActivityTime] = 0;
					HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
					PlayerTextDrawHide(playerid, ActiveTD[playerid]);
					pData[playerid][pEnergy] -= 3;
					ClearAnimations(playerid);
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.1, 1, 1, 1, 1, 1, 1);
    				SetPlayerAttachedObject(playerid, 0, 2912, 1, 0.436000, 0.519000, -0.342000, 0.000000, 0.000000, 0.000000, 1.000000,1.000000,1.000000);
				}
				else if(type == 3)
				{
					pData[playerid][CarryProduct] = 3;
					Info(playerid, "Anda telah berhasil membuat product equipment, /sellproduct untuk menjualnya.");
					TogglePlayerControllable(playerid, 1);
					InfoTD_MSG(playerid, 8000, "Equipment Created!");
					KillTimer(pData[playerid][pProducting]);
					pData[playerid][pActivityTime] = 0;
					HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
					PlayerTextDrawHide(playerid, ActiveTD[playerid]);
					pData[playerid][pEnergy] -= 3;
					ClearAnimations(playerid);
					SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
					ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.1, 1, 1, 1, 1, 1, 1);
    				SetPlayerAttachedObject(playerid, 0, 2912, 1, 0.436000, 0.519000, -0.342000, 0.000000, 0.000000, 0.000000, 1.000000,1.000000,1.000000);
				}
				else
				{
					KillTimer(pData[playerid][pProducting]);
					pData[playerid][pActivityTime] = 0;
					HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
					PlayerTextDrawHide(playerid, ActiveTD[playerid]);
					ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.1, 1, 1, 1, 1, 1, 1);
					return 1;
				}
			}
		}
		else if(pData[playerid][pActivityTime] < 100)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.0, -116.9033, -313.0775, 2.7646) || IsPlayerInRangeOfPoint(playerid, 2.0, -144.5109, -313.0769, 2.7646)
			|| IsPlayerInRangeOfPoint(playerid, 2.0, -130.6788, -313.0763, 2.7646))
			{
				pData[playerid][pActivityTime] += 5;
				SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
				ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
			}
		}
	}
	return 1;
}

CMD:sellproduct(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, -133.5227,-326.1761,1.4219)) return Error(playerid, "You're not near in production warehouse.");
	if(pData[playerid][CarryProduct] == 0) return Error(playerid, "You are not holding any products.");
	
	if(pData[playerid][CarryProduct] == 1)
	{
	    ClearAnimations(playerid);
		RemovePlayerAttachedObject(playerid,0);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		pData[playerid][CarryProduct] = 0;
		GivePlayerMoneyEx(playerid, 8000);
		
		Product += 10;
		Server_MinMoney(8000);
		Info(playerid, "Anda menjual 10 bahan makanan dengan harga "GREEN_E"$80.00");
		pData[playerid][pJobTime] += 600;
	}
	else if(pData[playerid][CarryProduct] == 2)
	{
	    ClearAnimations(playerid);
		RemovePlayerAttachedObject(playerid,0);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		pData[playerid][CarryProduct] = 0;
		GivePlayerMoneyEx(playerid, 10000);
		
		Product += 10;
		Server_MinMoney(10000);
		Info(playerid, "Anda menjual 10 product baju dengan harga "GREEN_E"$100.00");
		pData[playerid][pJobTime] += 600;
	}
	else if(pData[playerid][CarryProduct] == 3)
	{
	    RemovePlayerAttachedObject(playerid,0);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		pData[playerid][CarryProduct] = 0;
		GivePlayerMoneyEx(playerid, 15000);
		
		Product += 10;
		Server_MinMoney(15000);
		Info(playerid, "Anda menjual 10 product equipment dengan harga "GREEN_E"$150.00");
		pData[playerid][pJobTime] += 600;
	}
	return 1;
}
