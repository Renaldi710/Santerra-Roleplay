#define MAX_POINTS 230

new Text:TDEditor_PTD;

enum pdata
{
	showing,
	moneyput,
 	Float:put,
 	buy,
}
new ppDat[MAX_PLAYERS][pdata];

enum pdta
{
	Float:pol
}
new Graph:MY_GRAPH;
new pointData[MAX_POINTS][pdta];

new Float:IncDec[][1] = {
	{1.045}, {2.042}, {-1.045}, {-2.042}, {1.234}, {-1.234}, {-0.124}, {0.124}
};

forward InitializeTD(str[]);
public InitializeTD(str[])
{
	TDEditor_PTD = TextDrawCreate(315.768646, 246.101257, str);
	TextDrawLetterSize( TDEditor_PTD, 0.398000, 1.590000);
	TextDrawTextSize(TDEditor_PTD, 0.000000, 200.000000);
	TextDrawAlignment(TDEditor_PTD, 2);
	TextDrawColor(TDEditor_PTD, -1);
	TextDrawUseBox(TDEditor_PTD, 1);
	TextDrawBoxColor( TDEditor_PTD, 255);
	TextDrawSetShadow(TDEditor_PTD, 0);
	TextDrawSetOutline(TDEditor_PTD, 0);
	TextDrawBackgroundColor(TDEditor_PTD, 255);
	TextDrawFont( TDEditor_PTD, 1);
	TextDrawSetProportional( TDEditor_PTD, 1);
	TextDrawSetShadow(TDEditor_PTD, 0);
}

CMD:trade(playerid, params[])
{
	new money, bbuy[24], mstr[256];
	if(sscanf(params, "is[24]", money, bbuy)) return SendClientMessage(playerid, -1, "[USAGE] /trade [MONEY] [Buy/Sell]");
	if(money < 0) return SendClientMessage(playerid, -1, "[ERROR] Money must be positive.");
	if(!strcmp(bbuy, "buy", true, 3))
	{
	    ppDat[playerid][moneyput] = money;
		ppDat[playerid][put] = pointData[MAX_POINTS - 1][pol];
		GivePlayerMoney(playerid, -money);
		ppDat[playerid][buy] = 1; // buy
		format(mstr, 256, "You have put on buy at %f", ppDat[playerid][put]);
		SendClientMessage(playerid, -1, mstr);
	}
	else if(!strcmp(bbuy, "sell", true, 4))
	{
	    ppDat[playerid][moneyput] = money;
		ppDat[playerid][put] = pointData[MAX_POINTS - 1][pol];
		GivePlayerMoney(playerid, -money);
		ppDat[playerid][buy] = 2; // sell
		format(mstr, 256, "You have put on sell at %f", ppDat[playerid][put]);
		SendClientMessage(playerid, -1, mstr);
	}
	else SendClientMessage(playerid, -1, "ERROR");
	return 1;
}

CMD:stoptrade(playerid, params[])
{
	if(ppDat[playerid][moneyput] == 0) return SendClientMessage(playerid, -1, "ERROR");
	new Float:diff;
	if(ppDat[playerid][buy] == 1) diff = pointData[MAX_POINTS-1][pol] - ppDat[playerid][put];
	else if(ppDat[playerid][buy] == 2) diff = ppDat[playerid][put] - pointData[MAX_POINTS - 1][pol];
	new multi = floatround(diff);
	GivePlayerMoney(playerid, multi*ppDat[playerid][moneyput]);
	new mstr[256];
	format(mstr, 256, "You have earned %i.", multi*ppDat[playerid][moneyput]);
	SendClientMessage(playerid, -1, mstr);
	ppDat[playerid][moneyput] = 0;
	ppDat[playerid][put] = 0;
	ppDat[playerid][buy] = 0;
	return 1;
}

CMD:tradechart(playerid, params[])
{
	if(ppDat[playerid][showing] == 0)
	{
	    GRAPHIC::ShowForPlayer(playerid, MY_GRAPH);
	    TextDrawShowForPlayer(playerid, TDEditor_PTD);
		ppDat[playerid][showing] = 1;
	}
	else
	{
	    GRAPHIC::HideForPlayer(playerid, MY_GRAPH);
	    TextDrawHideForPlayer(playerid, TDEditor_PTD);
		ppDat[playerid][showing] = 0;
	}
	
	return 1;
}

forward Changepols();
public Changepols()
{
    GRAPHIC::RemoveTD(MAX_POINTS);
	GRAPHIC::Destroy(MY_GRAPH);
    MY_GRAPH = GRAPHIC::Create(200.0, 250.0, 0, 0, 230, 230);
    GRAPHIC::XYAxisColor(MY_GRAPH, 0x000000FF, 0x000000FF);


	GRAPHIC::UseBackground(MY_GRAPH, 1);
	GRAPHIC::BackgroundColor(MY_GRAPH, 0x000000FF);
	new Float:exps;
	new Float:oldshit = pointData[MAX_POINTS-1][pol];
	for(new i = 0; i < MAX_POINTS; i++)
	{
		exps = IncDec[random(sizeof(IncDec))][0];
	    if(i == MAX_POINTS - 1) pointData[i][pol] = pointData[i][pol] + exps;
	    else pointData[i][pol] = pointData[i+1][pol];
	    if(pointData[i][pol] < 0.0) pointData[i][pol] = 0.0;
	    if(pointData[i][pol] > 229.0) pointData[i][pol] = 229.0;
	    if(i < 0 || i > MAX_POINTS-1) continue;
	    GRAPHIC::AddPoint(MY_GRAPH, i,  pointData[i][pol], 0xFFFFFFFF);
	}
	new Float:newshit = pointData[MAX_POINTS - 1][pol];
	new Float:diff = newshit - oldshit;
	new mstr[256];
	if(diff >= 0) format(mstr, 256, "      New: %f     Diff:~g~%f", newshit, diff);
	else format(mstr, 256, "      New: %f     Diff:~r~%f", newshit, diff);
	//TextDrawDestroy(TDEditor_PTD);
	//InitializeTD(mstr);
	TextDrawSetString(TDEditor_PTD, mstr);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(ppDat[i][showing] == 1)
			{
			    GRAPHIC::ShowForPlayer(i, MY_GRAPH);
				//TextDrawHideForPlayer(i, TDEditor_PTD);
				TextDrawShowForPlayer(i, TDEditor_PTD);
			}
	    }
	}
	GRAPHIC::ResetTD();
}
