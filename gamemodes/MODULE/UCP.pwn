#define MAX_CHARS 3

new PlayerChar[MAX_PLAYERS][MAX_CHARS][MAX_PLAYER_NAME + 1];
new tempUCP[64];

stock CheckUCP(playerid)
{
	new query[256];
	format(query, sizeof(query), "SELECT * FROM `playerucp` WHERE `UCP` = '%s' LIMIT 1", GetName(playerid));
	mysql_tquery(g_SQL, query, "CheckPlayerUCP", "d", playerid);
	return 1;
}
function CheckPlayerUCP(playerid)
{
	new rows = cache_num_rows() > 0;
	new str[789], query[248], PlayerIP[16];
	if (rows)
	{
	    cache_get_value_name(0, "Password", pData[playerid][pPassword], 65);
	    cache_get_value_name(0, "salt", pData[playerid][pSalt], 17);
	    cache_get_value_name(0, "UCP", tempUCP[playerid]);
	    format(str, sizeof(str), """Clarnce Roleplay SA-MP\nLogin with me Clarence!\nif you are already logged in\nLogin yahoo ", GetName(playerid));
		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Account Login", str, "Login", "Exit");
	}
	else
	{
	    CheckVerify(playerid);
	}
	mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM `banneds` WHERE `name` = '%s' OR `ip` = '%s' OR (`longip` != 0 AND (`longip` & %i) = %i) LIMIT 1", tempUCP[playerid], pData[playerid][pIP], BAN_MASK, (Ban_GetLongIP(PlayerIP) & BAN_MASK));
	mysql_tquery(g_SQL, query, "CheckBan", "i", playerid);
	return 1;
}
function CheckVerify(playerid)
{
	new name[MAX_PLAYER_NAME+1];
    GetPlayerName(playerid, name, sizeof(name));
    new player[200];
    new strong[1000];
    new string[1000];
    format(player,sizeof(player),"Ucp/%s.txt",name);
    if(!dini_Exists(player))
    {
        format(strong, sizeof strong, """Ucp Name: ""%s\n""Database: ""Checking....\n""Detected Account ""%s's ""doest not verified\n""Please Registered UCP on Discord or Contact Moderator Servers\n"LB2_E"- "YELLOW_E"https://discord.gg/JuRTngnM2w", name);
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Database - Format", strong, "Close", "");
        SCM(playerid, COLOR_RIKO, """Your account is not ferivy in database ""(Kicked)");
		SetTimerEx("DelayedKick", 1, false, "i", playerid);
    }
    else
    {
	    format(string, sizeof(string), ""LG_E"Ucp Name: "LB2_E" %s\n"LG_E"Status: "LB2_E"Unverified\n"LG_E"Password: "LB2_E"(Input below):", GetName(playerid));
		ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "LegacyPride - Register", string, "Register", "Exit");
		SendClientMessageEx(playerid, COLOR_RIKO, "DATABASE: "WHITE_E"database succesfully loaded account with Names "YELLOW_E"%s", ReturnName(playerid));
	}
    return 1;
}
function CheckPlayerChar(playerid)
{
	cache_get_value_name_int(0, "extrac", pData[playerid][pExtraChar]);
	new query[256];
	format(query, sizeof(query), "SELECT `username` FROM `players` WHERE `UCP` = '%s' LIMIT %d;", GetName(playerid), MAX_CHARS + pData[playerid][pExtraChar]);
	mysql_tquery(g_SQL, query, "LoadCharacter", "d", playerid);
	return 1;
}
function LoadCharacter(playerid)
{
	for (new i = 0; i < MAX_CHARS; i ++)
	{
		PlayerChar[playerid][i][0] = EOS;
	}
	for (new i = 0; i < cache_num_rows(); i ++)
	{
		cache_get_value_name(i, "username", PlayerChar[playerid][i]);
	}
  	ShowCharacterList(playerid);
  	return 1;
}
ShowCharacterList(playerid)
{
	new name[256], count, sgstr[128];
	for (new i; i < MAX_CHARS; i ++) if(PlayerChar[playerid][i][0] != EOS)
	{
	    format(sgstr, sizeof(sgstr), """%s:\n", PlayerChar[playerid][i], pData[playerid][pLevel]);
		strcat(name, sgstr);
		count++;
	}
	if(count < MAX_CHARS)
		strcat(name, ""LB2_E"Input Charakter");
	ShowPlayerDialog(playerid, DIALOG_CHARLIST, DIALOG_STYLE_LIST, "Listening Character Slot", name, "Select", "Quit");
	return 1;
}
function OnPlayerPassDone(playerid)
{
	CheckUCP(playerid);
	return 1;
}
