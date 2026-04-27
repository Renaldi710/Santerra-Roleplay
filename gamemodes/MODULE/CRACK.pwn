//CRACK SYSTEM BY BOBI

CMD:buycrack(playerid, prams[]);
{
    if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1370.6390,717.5485,-15.7573))
        return Error(playerid, "Anda tidak di tempat crack");
		{
        if(pData[playerid][pCrack] += 1;
        if(GetPlayerMoney(playerid) < 5000)
            return Error(playerid, "Anda membutuhkan uang "RED_E"50.00 Untuk membeli nya");
     	}
	return 1;
}

CMD:usedrugs(playerid, prams[]);
{
    if(IsPlayerConnected(playerid))
    {
        if(pData[playerid][pCrack] < 1)
			return Error(playerid, "Anda tidak memiliki crack.");
			SetPlayerWeather(playerid, -68);
			ApplyAnimation(playerid, "SMOKING","M_smk_drag",4.1,0,0,0,0,0,1);
	}
	return 1;
}
        
