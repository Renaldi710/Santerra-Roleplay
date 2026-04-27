//------------[ Textdraw ]------------

//Info textdraw
new PlayerText:InfoTD[MAX_PLAYERS];
new Text:TextTime, Text:TextDate;

//------------- SIMPLE
new Text:JGRP[3]; //CHARAKTER
new Text:SIMPLEHUD[5]; //veh
new PlayerText:DIGIHUNGER[MAX_PLAYERS];
new PlayerText:DIGIENERGY[MAX_PLAYERS];

new PlayerText:SIMPLEFUEL[MAX_PLAYERS];
new PlayerText:SIMPLEDAMAGE[MAX_PLAYERS];
new PlayerText:SIMPLESPEED[MAX_PLAYERS];
/*
		PlayerTextDrawHide(playerid, SIMPLEFUEL[playerid]);
		PlayerTextDrawHide(playerid, SIMPLEDAMAGE[playerid]);
		PlayerTextDrawHide(playerid, SIMPLESPEED[playerid]);
		for(new txd; txd < 4; txd++)
		{
			TextDrawHideForPlayer(playerid, SIMPLEHUD[txd]);
		}

				PlayerTextDrawShow(playerid, DIGIHUNGER[playerid]);
				PlayerTextDrawShow(playerid, DIGIENERGY[playerid]);
				for(new txd; txd < 3; txd++)
				{
					TextDrawShowForPlayer(playerid, JGRP[txd]);
				}
*/

//------------- MODERN
new Text:LaparHaus[6];
new Text:AkuVeh[4];
new PlayerText:DGFood[MAX_PLAYERS];
new PlayerText:DGEnergy[MAX_PLAYERS];
new PlayerText:AkuDamage[MAX_PLAYERS];
new PlayerText:AkuFuel[MAX_PLAYERS];
new PlayerText:AkuSpeed[MAX_PLAYERS];

//-------------
new Text:Blind;
//-------------
//KTP
new Text:KTPTD[20];
//-------------
new Text:AnimH4N;
new Text:TextFare;
new Text:DPvehfare[MAX_PLAYERS];
//-------------
new PlayerText:ActiveTD[MAX_PLAYERS];
//-------------
//SetVobjPos
new PlayerText:EditVObjTD[MAX_PLAYERS][8];
//-------------
//settoyspos
new PlayerText:EditToysTD[MAX_PLAYERS][5];
new PlayerText:ToysTDdown[MAX_PLAYERS];
new PlayerText:ToysTDup[MAX_PLAYERS];
new PlayerText:ToysTDsave[MAX_PLAYERS];
new PlayerText:ToysTDedit[MAX_PLAYERS];
//-------------
CreatePlayerTextDraws(playerid)
{
	//SIMPLE LAPAR HAUS
	DIGIENERGY[playerid] = CreatePlayerTextDraw(playerid, 617.000000, 360.000000, "100%");
	PlayerTextDrawFont(playerid, DIGIENERGY[playerid], 3);
	PlayerTextDrawLetterSize(playerid, DIGIENERGY[playerid], 0.400000, 2.000000);
	PlayerTextDrawTextSize(playerid, DIGIENERGY[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, DIGIENERGY[playerid], 1);
	PlayerTextDrawSetShadow(playerid, DIGIENERGY[playerid], 0);
	PlayerTextDrawAlignment(playerid, DIGIENERGY[playerid], 2);
	PlayerTextDrawColor(playerid, DIGIENERGY[playerid], 9109759);
	PlayerTextDrawBackgroundColor(playerid, DIGIENERGY[playerid], 255);
	PlayerTextDrawBoxColor(playerid, DIGIENERGY[playerid], 50);
	PlayerTextDrawUseBox(playerid, DIGIENERGY[playerid], 0);
	PlayerTextDrawSetProportional(playerid, DIGIENERGY[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, DIGIENERGY[playerid], 0);

	DIGIHUNGER[playerid] = CreatePlayerTextDraw(playerid, 617.000000, 395.000000, "100%");
	PlayerTextDrawFont(playerid, DIGIHUNGER[playerid], 3);
	PlayerTextDrawLetterSize(playerid, DIGIHUNGER[playerid], 0.400000, 2.000000);
	PlayerTextDrawTextSize(playerid, DIGIHUNGER[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, DIGIHUNGER[playerid], 1);
	PlayerTextDrawSetShadow(playerid, DIGIHUNGER[playerid], 0);
	PlayerTextDrawAlignment(playerid, DIGIHUNGER[playerid], 2);
	PlayerTextDrawColor(playerid, DIGIHUNGER[playerid], 9109759);
	PlayerTextDrawBackgroundColor(playerid, DIGIHUNGER[playerid], 255);
	PlayerTextDrawBoxColor(playerid, DIGIHUNGER[playerid], 50);
	PlayerTextDrawUseBox(playerid, DIGIHUNGER[playerid], 0);
	PlayerTextDrawSetProportional(playerid, DIGIHUNGER[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, DIGIHUNGER[playerid], 0);

	SIMPLEDAMAGE[playerid] = CreatePlayerTextDraw(playerid, 617.000000, 310.000000, "100%");
	PlayerTextDrawFont(playerid, SIMPLEDAMAGE[playerid], 3);
	PlayerTextDrawLetterSize(playerid, SIMPLEDAMAGE[playerid], 0.400000, 2.000000);
	PlayerTextDrawTextSize(playerid, SIMPLEDAMAGE[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, SIMPLEDAMAGE[playerid], 1);
	PlayerTextDrawSetShadow(playerid, SIMPLEDAMAGE[playerid], 0);
	PlayerTextDrawAlignment(playerid, SIMPLEDAMAGE[playerid], 2);
	PlayerTextDrawColor(playerid, SIMPLEDAMAGE[playerid], 9109759);
	PlayerTextDrawBackgroundColor(playerid, SIMPLEDAMAGE[playerid], 255);
	PlayerTextDrawBoxColor(playerid, SIMPLEDAMAGE[playerid], 50);
	PlayerTextDrawUseBox(playerid, SIMPLEDAMAGE[playerid], 0);
	PlayerTextDrawSetProportional(playerid, SIMPLEDAMAGE[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, SIMPLEDAMAGE[playerid], 0);

	SIMPLEFUEL[playerid] = CreatePlayerTextDraw(playerid, 617.000000, 275.000000, "100%");
	PlayerTextDrawFont(playerid, SIMPLEFUEL[playerid], 3);
	PlayerTextDrawLetterSize(playerid, SIMPLEFUEL[playerid], 0.400000, 2.000000);
	PlayerTextDrawTextSize(playerid, SIMPLEFUEL[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, SIMPLEFUEL[playerid], 1);
	PlayerTextDrawSetShadow(playerid, SIMPLEFUEL[playerid], 0);
	PlayerTextDrawAlignment(playerid, SIMPLEFUEL[playerid], 2);
	PlayerTextDrawColor(playerid, SIMPLEFUEL[playerid], 9109759);
	PlayerTextDrawBackgroundColor(playerid, SIMPLEFUEL[playerid], 255);
	PlayerTextDrawBoxColor(playerid, SIMPLEFUEL[playerid], 50);
	PlayerTextDrawUseBox(playerid, SIMPLEFUEL[playerid], 0);
	PlayerTextDrawSetProportional(playerid, SIMPLEFUEL[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, SIMPLEFUEL[playerid], 0);

	SIMPLESPEED[playerid] = CreatePlayerTextDraw(playerid, 598.000000, 240.000000, "100");
	PlayerTextDrawFont(playerid, SIMPLESPEED[playerid], 3);
	PlayerTextDrawLetterSize(playerid, SIMPLESPEED[playerid], 0.300000, 1.799999);
	PlayerTextDrawTextSize(playerid, SIMPLESPEED[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, SIMPLESPEED[playerid], 1);
	PlayerTextDrawSetShadow(playerid, SIMPLESPEED[playerid], 0);
	PlayerTextDrawAlignment(playerid, SIMPLESPEED[playerid], 2);
	PlayerTextDrawColor(playerid, SIMPLESPEED[playerid], 9109759);
	PlayerTextDrawBackgroundColor(playerid, SIMPLESPEED[playerid], 255);
	PlayerTextDrawBoxColor(playerid, SIMPLESPEED[playerid], 50);
	PlayerTextDrawUseBox(playerid, SIMPLESPEED[playerid], 0);
	PlayerTextDrawSetProportional(playerid, SIMPLESPEED[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, SIMPLESPEED[playerid], 0);

	//ALPRASH MODERN DAMAGE, FUEL, SPEED
	AkuDamage[playerid] = CreatePlayerTextDraw(playerid, 600.000000, 370.000000, "100");
	PlayerTextDrawFont(playerid, AkuDamage[playerid], 1);
	PlayerTextDrawLetterSize(playerid, AkuDamage[playerid], 0.300000, 1.799998);
	PlayerTextDrawTextSize(playerid, AkuDamage[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AkuDamage[playerid], 1);
	PlayerTextDrawSetShadow(playerid, AkuDamage[playerid], 0);
	PlayerTextDrawAlignment(playerid, AkuDamage[playerid], 2);
	PlayerTextDrawColor(playerid, AkuDamage[playerid], -16776961);
	PlayerTextDrawBackgroundColor(playerid, AkuDamage[playerid], 255);
	PlayerTextDrawBoxColor(playerid, AkuDamage[playerid], 50);
	PlayerTextDrawUseBox(playerid, AkuDamage[playerid], 0);
	PlayerTextDrawSetProportional(playerid, AkuDamage[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, AkuDamage[playerid], 0);

	AkuFuel[playerid] = CreatePlayerTextDraw(playerid, 600.000000, 340.000000, "100");
	PlayerTextDrawFont(playerid, AkuFuel[playerid], 1);
	PlayerTextDrawLetterSize(playerid, AkuFuel[playerid], 0.300000, 1.799998);
	PlayerTextDrawTextSize(playerid, AkuFuel[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AkuFuel[playerid], 1);
	PlayerTextDrawSetShadow(playerid, AkuFuel[playerid], 0);
	PlayerTextDrawAlignment(playerid, AkuFuel[playerid], 2);
	PlayerTextDrawColor(playerid, AkuFuel[playerid], -16776961);
	PlayerTextDrawBackgroundColor(playerid, AkuFuel[playerid], 255);
	PlayerTextDrawBoxColor(playerid, AkuFuel[playerid], 50);
	PlayerTextDrawUseBox(playerid, AkuFuel[playerid], 0);
	PlayerTextDrawSetProportional(playerid, AkuFuel[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, AkuFuel[playerid], 0);

	AkuSpeed[playerid] = CreatePlayerTextDraw(playerid, 600.000000, 310.000000, "100");
	PlayerTextDrawFont(playerid, AkuSpeed[playerid], 1);
	PlayerTextDrawLetterSize(playerid, AkuSpeed[playerid], 0.300000, 1.799998);
	PlayerTextDrawTextSize(playerid, AkuSpeed[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AkuSpeed[playerid], 1);
	PlayerTextDrawSetShadow(playerid, AkuSpeed[playerid], 0);
	PlayerTextDrawAlignment(playerid, AkuSpeed[playerid], 2);
	PlayerTextDrawColor(playerid, AkuSpeed[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, AkuSpeed[playerid], 255);
	PlayerTextDrawBoxColor(playerid, AkuSpeed[playerid], 50);
	PlayerTextDrawUseBox(playerid, AkuSpeed[playerid], 0);
	PlayerTextDrawSetProportional(playerid, AkuSpeed[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, AkuSpeed[playerid], 0);

	//ALPRASH MODERN LAPAR HAUS
	DGFood[playerid] = CreatePlayerTextDraw(playerid, 595.000000, 417.000000, "100%");
	PlayerTextDrawFont(playerid, DGFood[playerid], 1);
	PlayerTextDrawLetterSize(playerid, DGFood[playerid], 0.300000, 1.799998);
	PlayerTextDrawTextSize(playerid, DGFood[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, DGFood[playerid], 1);
	PlayerTextDrawSetShadow(playerid, DGFood[playerid], 0);
	PlayerTextDrawAlignment(playerid, DGFood[playerid], 2);
	PlayerTextDrawColor(playerid, DGFood[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, DGFood[playerid], 255);
	PlayerTextDrawBoxColor(playerid, DGFood[playerid], 50);
	PlayerTextDrawUseBox(playerid, DGFood[playerid], 0);
	PlayerTextDrawSetProportional(playerid, DGFood[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, DGFood[playerid], 0);

	DGEnergy[playerid] = CreatePlayerTextDraw(playerid, 520.000000, 417.000000, "100%");
	PlayerTextDrawFont(playerid, DGEnergy[playerid], 1);
	PlayerTextDrawLetterSize(playerid, DGEnergy[playerid], 0.300000, 1.799998);
	PlayerTextDrawTextSize(playerid, DGEnergy[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, DGEnergy[playerid], 1);
	PlayerTextDrawSetShadow(playerid, DGEnergy[playerid], 0);
	PlayerTextDrawAlignment(playerid, DGEnergy[playerid], 2);
	PlayerTextDrawColor(playerid, DGEnergy[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, DGEnergy[playerid], 255);
	PlayerTextDrawBoxColor(playerid, DGEnergy[playerid], 50);
	PlayerTextDrawUseBox(playerid, DGEnergy[playerid], 0);
	PlayerTextDrawSetProportional(playerid, DGEnergy[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, DGEnergy[playerid], 0);

	//Info textdraw
	InfoTD[playerid] = CreatePlayerTextDraw(playerid, 148.888, 361.385, "Welcome!");
 	PlayerTextDrawLetterSize(playerid, InfoTD[playerid], 0.326, 1.654);
	PlayerTextDrawAlignment(playerid, InfoTD[playerid], 1);
	PlayerTextDrawColor(playerid, InfoTD[playerid], -1);
	PlayerTextDrawSetOutline(playerid, InfoTD[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, InfoTD[playerid], 0x000000FF);
	PlayerTextDrawFont(playerid, InfoTD[playerid], 1);
	PlayerTextDrawSetProportional(playerid, InfoTD[playerid], 1);

	ActiveTD[playerid] = CreatePlayerTextDraw(playerid, 280.000000, 370.000000, "Proses...");
	PlayerTextDrawFont(playerid, ActiveTD[playerid], 2);
	PlayerTextDrawLetterSize(playerid, ActiveTD[playerid], 0.300000, 1.700000);
	PlayerTextDrawTextSize(playerid, ActiveTD[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ActiveTD[playerid], 1);
	PlayerTextDrawSetShadow(playerid, ActiveTD[playerid], 0);
	PlayerTextDrawAlignment(playerid, ActiveTD[playerid], 1);
	PlayerTextDrawColor(playerid, ActiveTD[playerid], 2094792959);
	PlayerTextDrawBackgroundColor(playerid, ActiveTD[playerid], 255);
	PlayerTextDrawBoxColor(playerid, ActiveTD[playerid], 50);
	PlayerTextDrawUseBox(playerid, ActiveTD[playerid], 0);
	PlayerTextDrawSetProportional(playerid, ActiveTD[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, ActiveTD[playerid], 0);

	DPvehfare[playerid] = TextDrawCreate(462.000000, 401.166687, "$500.000");
	TextDrawLetterSize(DPvehfare[playerid], 0.216000, 0.952498);
	TextDrawAlignment(DPvehfare[playerid], 1);
	TextDrawColor(DPvehfare[playerid], 16711935);
	TextDrawSetShadow(DPvehfare[playerid], 0);
	TextDrawSetOutline(DPvehfare[playerid], 1);
	TextDrawBackgroundColor(DPvehfare[playerid], 255);
	TextDrawFont(DPvehfare[playerid], 1);
	TextDrawSetProportional(DPvehfare[playerid], 1);
	TextDrawSetShadow(DPvehfare[playerid], 0);

	//Set vObj atth pos
	EditVObjTD[playerid][0] = CreatePlayerTextDraw(playerid, 263.000000, 406.000000, "_");
	PlayerTextDrawFont(playerid, EditVObjTD[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, EditVObjTD[playerid][0], 0.154164, 2.700001);
	PlayerTextDrawTextSize(playerid, EditVObjTD[playerid][0], 1.000000, 282.500000);
	PlayerTextDrawSetOutline(playerid, EditVObjTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, EditVObjTD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, EditVObjTD[playerid][0], 2);
	PlayerTextDrawColor(playerid, EditVObjTD[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, EditVObjTD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, EditVObjTD[playerid][0], -741092407);
	PlayerTextDrawUseBox(playerid, EditVObjTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, EditVObjTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, EditVObjTD[playerid][0], 0);

	EditVObjTD[playerid][1] = CreatePlayerTextDraw(playerid, 263.000000, 362.000000, "_");
	PlayerTextDrawFont(playerid, EditVObjTD[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, EditVObjTD[playerid][1], 0.154164, 9.150011);
	PlayerTextDrawTextSize(playerid, EditVObjTD[playerid][1], 1.000000, 94.500000);
	PlayerTextDrawSetOutline(playerid, EditVObjTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, EditVObjTD[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, EditVObjTD[playerid][1], 2);
	PlayerTextDrawColor(playerid, EditVObjTD[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, EditVObjTD[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, EditVObjTD[playerid][1], -741092407);
	PlayerTextDrawUseBox(playerid, EditVObjTD[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, EditVObjTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, EditVObjTD[playerid][1], 0);

	EditVObjTD[playerid][2] = CreatePlayerTextDraw(playerid, 358.000000, 408.000000, "+");
	PlayerTextDrawFont(playerid, EditVObjTD[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, EditVObjTD[playerid][2], 0.258332, 2.149998);
	PlayerTextDrawTextSize(playerid, EditVObjTD[playerid][2], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, EditVObjTD[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, EditVObjTD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, EditVObjTD[playerid][2], 2);
	PlayerTextDrawColor(playerid, EditVObjTD[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, EditVObjTD[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, EditVObjTD[playerid][2], 1296911816);
	PlayerTextDrawUseBox(playerid, EditVObjTD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, EditVObjTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, EditVObjTD[playerid][2], 1);

	EditVObjTD[playerid][3] = CreatePlayerTextDraw(playerid, 169.000000, 408.000000, "-");
	PlayerTextDrawFont(playerid, EditVObjTD[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, EditVObjTD[playerid][3], 0.258332, 2.149998);
	PlayerTextDrawTextSize(playerid, EditVObjTD[playerid][3], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, EditVObjTD[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, EditVObjTD[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, EditVObjTD[playerid][3], 2);
	PlayerTextDrawColor(playerid, EditVObjTD[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, EditVObjTD[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, EditVObjTD[playerid][3], 1296911816);
	PlayerTextDrawUseBox(playerid, EditVObjTD[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, EditVObjTD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, EditVObjTD[playerid][3], 1);

	EditVObjTD[playerid][4] = CreatePlayerTextDraw(playerid, 263.000000, 389.000000, "SAVE");
	PlayerTextDrawFont(playerid, EditVObjTD[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, EditVObjTD[playerid][4], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, EditVObjTD[playerid][4], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, EditVObjTD[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, EditVObjTD[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, EditVObjTD[playerid][4], 2);
	PlayerTextDrawColor(playerid, EditVObjTD[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, EditVObjTD[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, EditVObjTD[playerid][4], 16711881);
	PlayerTextDrawUseBox(playerid, EditVObjTD[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, EditVObjTD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, EditVObjTD[playerid][4], 1);

	EditVObjTD[playerid][5] = CreatePlayerTextDraw(playerid, 264.000000, 409.000000, "Cordinate");
	PlayerTextDrawFont(playerid, EditVObjTD[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid, EditVObjTD[playerid][5], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, EditVObjTD[playerid][5], 16.500000, 92.000000);
	PlayerTextDrawSetOutline(playerid, EditVObjTD[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, EditVObjTD[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, EditVObjTD[playerid][5], 2);
	PlayerTextDrawColor(playerid, EditVObjTD[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, EditVObjTD[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, EditVObjTD[playerid][5], 1296911817);
	PlayerTextDrawUseBox(playerid, EditVObjTD[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, EditVObjTD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, EditVObjTD[playerid][5], 0);

	EditVObjTD[playerid][6] = CreatePlayerTextDraw(playerid, 263.000000, 429.000000, "BACK");
	PlayerTextDrawFont(playerid, EditVObjTD[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid, EditVObjTD[playerid][6], 0.258332, 1.450000);
	PlayerTextDrawTextSize(playerid, EditVObjTD[playerid][6], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, EditVObjTD[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, EditVObjTD[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, EditVObjTD[playerid][6], 2);
	PlayerTextDrawColor(playerid, EditVObjTD[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, EditVObjTD[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, EditVObjTD[playerid][6], -16777015);
	PlayerTextDrawUseBox(playerid, EditVObjTD[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, EditVObjTD[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, EditVObjTD[playerid][6], 1);

	EditVObjTD[playerid][7] = CreatePlayerTextDraw(playerid, 263.000000, 366.000000, "EDITING");
	PlayerTextDrawFont(playerid, EditVObjTD[playerid][7], 1);
	PlayerTextDrawLetterSize(playerid, EditVObjTD[playerid][7], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, EditVObjTD[playerid][7], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, EditVObjTD[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, EditVObjTD[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, EditVObjTD[playerid][7], 2);
	PlayerTextDrawColor(playerid, EditVObjTD[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, EditVObjTD[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, EditVObjTD[playerid][7], -1378294071);
	PlayerTextDrawUseBox(playerid, EditVObjTD[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, EditVObjTD[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, EditVObjTD[playerid][7], 1);

	//edit toys td
	EditToysTD[playerid][0] = CreatePlayerTextDraw(playerid, 174.000000, 160.000000, "_");
	PlayerTextDrawFont(playerid, EditToysTD[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, EditToysTD[playerid][0], 0.266665, 11.750000);
	PlayerTextDrawTextSize(playerid, EditToysTD[playerid][0], 298.500000, 83.500000);
	PlayerTextDrawSetOutline(playerid, EditToysTD[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, EditToysTD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, EditToysTD[playerid][0], 2);
	PlayerTextDrawColor(playerid, EditToysTD[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, EditToysTD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, EditToysTD[playerid][0], -1061109690);
	PlayerTextDrawUseBox(playerid, EditToysTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, EditToysTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, EditToysTD[playerid][0], 0);

	EditToysTD[playerid][1] = CreatePlayerTextDraw(playerid, 84.000000, 160.000000, "_");
	PlayerTextDrawFont(playerid, EditToysTD[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, EditToysTD[playerid][1], 0.266665, 11.750000);
	PlayerTextDrawTextSize(playerid, EditToysTD[playerid][1], 298.500000, 83.500000);
	PlayerTextDrawSetOutline(playerid, EditToysTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, EditToysTD[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, EditToysTD[playerid][1], 2);
	PlayerTextDrawColor(playerid, EditToysTD[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, EditToysTD[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, EditToysTD[playerid][1], -1061109690);
	PlayerTextDrawUseBox(playerid, EditToysTD[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, EditToysTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, EditToysTD[playerid][1], 0);

	EditToysTD[playerid][2] = CreatePlayerTextDraw(playerid, 84.000000, 171.000000, "_");
	PlayerTextDrawFont(playerid, EditToysTD[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, EditToysTD[playerid][2], 0.600000, 9.200007);
	PlayerTextDrawTextSize(playerid, EditToysTD[playerid][2], 298.500000, 75.000000);
	PlayerTextDrawSetOutline(playerid, EditToysTD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, EditToysTD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, EditToysTD[playerid][2], 2);
	PlayerTextDrawColor(playerid, EditToysTD[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, EditToysTD[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, EditToysTD[playerid][2], 135);
	PlayerTextDrawUseBox(playerid, EditToysTD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, EditToysTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, EditToysTD[playerid][2], 0);

	ToysTDdown[playerid] = CreatePlayerTextDraw(playerid, 74.000000, 229.000000, "ld_beat:down");
	PlayerTextDrawFont(playerid, ToysTDdown[playerid], 4);
	PlayerTextDrawLetterSize(playerid, ToysTDdown[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, ToysTDdown[playerid], 20.000000, 24.000000);
	PlayerTextDrawSetOutline(playerid, ToysTDdown[playerid], 1);
	PlayerTextDrawSetShadow(playerid, ToysTDdown[playerid], 0);
	PlayerTextDrawAlignment(playerid, ToysTDdown[playerid], 1);
	PlayerTextDrawColor(playerid, ToysTDdown[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, ToysTDdown[playerid], 255);
	PlayerTextDrawBoxColor(playerid, ToysTDdown[playerid], 50);
	PlayerTextDrawUseBox(playerid, ToysTDdown[playerid], 1);
	PlayerTextDrawSetProportional(playerid, ToysTDdown[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, ToysTDdown[playerid], 1);

	ToysTDup[playerid] = CreatePlayerTextDraw(playerid, 74.000000, 174.000000, "ld_beat:up");
	PlayerTextDrawFont(playerid, ToysTDup[playerid], 4);
	PlayerTextDrawLetterSize(playerid, ToysTDup[playerid], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, ToysTDup[playerid], 20.000000, 24.000000);
	PlayerTextDrawSetOutline(playerid, ToysTDup[playerid], 1);
	PlayerTextDrawSetShadow(playerid, ToysTDup[playerid], 0);
	PlayerTextDrawAlignment(playerid, ToysTDup[playerid], 1);
	PlayerTextDrawColor(playerid, ToysTDup[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, ToysTDup[playerid], 255);
	PlayerTextDrawBoxColor(playerid, ToysTDup[playerid], 50);
	PlayerTextDrawUseBox(playerid, ToysTDup[playerid], 1);
	PlayerTextDrawSetProportional(playerid, ToysTDup[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, ToysTDup[playerid], 1);

	EditToysTD[playerid][3] = CreatePlayerTextDraw(playerid, 174.000000, 171.000000, "_");
	PlayerTextDrawFont(playerid, EditToysTD[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, EditToysTD[playerid][3], 0.600000, 9.200007);
	PlayerTextDrawTextSize(playerid, EditToysTD[playerid][3], 298.500000, 75.000000);
	PlayerTextDrawSetOutline(playerid, EditToysTD[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, EditToysTD[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, EditToysTD[playerid][3], 2);
	PlayerTextDrawColor(playerid, EditToysTD[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, EditToysTD[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, EditToysTD[playerid][3], 135);
	PlayerTextDrawUseBox(playerid, EditToysTD[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, EditToysTD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, EditToysTD[playerid][3], 0);

	ToysTDsave[playerid] = CreatePlayerTextDraw(playerid, 174.000000, 270.000000, "SAVE");
	PlayerTextDrawFont(playerid, ToysTDsave[playerid], 1);
	PlayerTextDrawLetterSize(playerid, ToysTDsave[playerid], 0.600000, 1.600000);
	PlayerTextDrawTextSize(playerid, ToysTDsave[playerid], 298.500000, 83.500000);
	PlayerTextDrawSetOutline(playerid, ToysTDsave[playerid], 1);
	PlayerTextDrawSetShadow(playerid, ToysTDsave[playerid], 0);
	PlayerTextDrawAlignment(playerid, ToysTDsave[playerid], 2);
	PlayerTextDrawColor(playerid, ToysTDsave[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, ToysTDsave[playerid], 255);
	PlayerTextDrawBoxColor(playerid, ToysTDsave[playerid], 135);
	PlayerTextDrawUseBox(playerid, ToysTDsave[playerid], 1);
	PlayerTextDrawSetProportional(playerid, ToysTDsave[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, ToysTDsave[playerid], 1);

	ToysTDedit[playerid] = CreatePlayerTextDraw(playerid, 84.000000, 270.000000, "EDIT");
	PlayerTextDrawFont(playerid, ToysTDedit[playerid], 1);
	PlayerTextDrawLetterSize(playerid, ToysTDedit[playerid], 0.600000, 1.600000);
	PlayerTextDrawTextSize(playerid, ToysTDedit[playerid], 298.500000, 83.000000);
	PlayerTextDrawSetOutline(playerid, ToysTDedit[playerid], 1);
	PlayerTextDrawSetShadow(playerid, ToysTDedit[playerid], 0);
	PlayerTextDrawAlignment(playerid, ToysTDedit[playerid], 2);
	PlayerTextDrawColor(playerid, ToysTDedit[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, ToysTDedit[playerid], 255);
	PlayerTextDrawBoxColor(playerid, ToysTDedit[playerid], 135);
	PlayerTextDrawUseBox(playerid, ToysTDedit[playerid], 1);
	PlayerTextDrawSetProportional(playerid, ToysTDedit[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, ToysTDedit[playerid], 1);

	EditToysTD[playerid][4] = CreatePlayerTextDraw(playerid, 174.000000, 206.000000, "0.00000");
	PlayerTextDrawFont(playerid, EditToysTD[playerid][4], 3);
	PlayerTextDrawLetterSize(playerid, EditToysTD[playerid][4], 0.479166, 1.400007);
	PlayerTextDrawTextSize(playerid, EditToysTD[playerid][4], 298.500000, 75.000000);
	PlayerTextDrawSetOutline(playerid, EditToysTD[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, EditToysTD[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, EditToysTD[playerid][4], 2);
	PlayerTextDrawColor(playerid, EditToysTD[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, EditToysTD[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, EditToysTD[playerid][4], 16777102);
	PlayerTextDrawUseBox(playerid, EditToysTD[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, EditToysTD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, EditToysTD[playerid][4], 0);
}

CreateTextDraw()
{
	//SIMPLE VEHICLE
	SIMPLEHUD[0] = TextDrawCreate(623.000000, 240.000000, "mph");
	TextDrawFont(SIMPLEHUD[0], 3);
	TextDrawLetterSize(SIMPLEHUD[0], 0.300000, 1.799999);
	TextDrawTextSize(SIMPLEHUD[0], 400.000000, 17.000000);
	TextDrawSetOutline(SIMPLEHUD[0], 1);
	TextDrawSetShadow(SIMPLEHUD[0], 0);
	TextDrawAlignment(SIMPLEHUD[0], 2);
	TextDrawColor(SIMPLEHUD[0], -1);
	TextDrawBackgroundColor(SIMPLEHUD[0], 255);
	TextDrawBoxColor(SIMPLEHUD[0], 50);
	TextDrawUseBox(SIMPLEHUD[0], 0);
	TextDrawSetProportional(SIMPLEHUD[0], 1);
	TextDrawSetSelectable(SIMPLEHUD[0], 0);

	SIMPLEHUD[1] = TextDrawCreate(565.000000, 310.000000, "hud:radar_spray");
	TextDrawFont(SIMPLEHUD[1], 4);
	TextDrawLetterSize(SIMPLEHUD[1], 0.600000, 2.000000);
	TextDrawTextSize(SIMPLEHUD[1], 19.000000, 22.000000);
	TextDrawSetOutline(SIMPLEHUD[1], 1);
	TextDrawSetShadow(SIMPLEHUD[1], 0);
	TextDrawAlignment(SIMPLEHUD[1], 1);
	TextDrawColor(SIMPLEHUD[1], -1);
	TextDrawBackgroundColor(SIMPLEHUD[1], 255);
	TextDrawBoxColor(SIMPLEHUD[1], 50);
	TextDrawUseBox(SIMPLEHUD[1], 1);
	TextDrawSetProportional(SIMPLEHUD[1], 1);
	TextDrawSetSelectable(SIMPLEHUD[1], 0);

	SIMPLEHUD[2] = TextDrawCreate(565.000000, 273.000000, "hud:radar_modGarage");
	TextDrawFont(SIMPLEHUD[2], 4);
	TextDrawLetterSize(SIMPLEHUD[2], 0.600000, 2.000000);
	TextDrawTextSize(SIMPLEHUD[2], 19.000000, 22.000000);
	TextDrawSetOutline(SIMPLEHUD[2], 1);
	TextDrawSetShadow(SIMPLEHUD[2], 0);
	TextDrawAlignment(SIMPLEHUD[2], 1);
	TextDrawColor(SIMPLEHUD[2], -1);
	TextDrawBackgroundColor(SIMPLEHUD[2], 255);
	TextDrawBoxColor(SIMPLEHUD[2], 50);
	TextDrawUseBox(SIMPLEHUD[2], 1);
	TextDrawSetProportional(SIMPLEHUD[2], 1);
	TextDrawSetSelectable(SIMPLEHUD[2], 0);

	SIMPLEHUD[3] = TextDrawCreate(565.000000, 240.000000, "hud:radar_impound");
	TextDrawFont(SIMPLEHUD[3], 4);
	TextDrawLetterSize(SIMPLEHUD[3], 0.600000, 2.000000);
	TextDrawTextSize(SIMPLEHUD[3], 19.000000, 22.000000);
	TextDrawSetOutline(SIMPLEHUD[3], 1);
	TextDrawSetShadow(SIMPLEHUD[3], 0);
	TextDrawAlignment(SIMPLEHUD[3], 1);
	TextDrawColor(SIMPLEHUD[3], -1);
	TextDrawBackgroundColor(SIMPLEHUD[3], 255);
	TextDrawBoxColor(SIMPLEHUD[3], 50);
	TextDrawUseBox(SIMPLEHUD[3], 1);
	TextDrawSetProportional(SIMPLEHUD[3], 1);
	TextDrawSetSelectable(SIMPLEHUD[3], 0);

	SIMPLEHUD[4] = TextDrawCreate(605.000000, 230.000000, "_");
	TextDrawFont(SIMPLEHUD[4], 1);
	TextDrawLetterSize(SIMPLEHUD[4], 0.600000, 12.000000);
	TextDrawTextSize(SIMPLEHUD[4], 298.500000, 90.000000);
	TextDrawSetOutline(SIMPLEHUD[4], 1);
	TextDrawSetShadow(SIMPLEHUD[4], 1);
	TextDrawAlignment(SIMPLEHUD[4], 2);
	TextDrawColor(SIMPLEHUD[4], -1);
	TextDrawBackgroundColor(SIMPLEHUD[4], 255);
	TextDrawBoxColor(SIMPLEHUD[4], 135);
	TextDrawUseBox(SIMPLEHUD[4], 1);
	TextDrawSetProportional(SIMPLEHUD[4], 1);
	TextDrawSetSelectable(SIMPLEHUD[4], 0);

	//HUD CHARAKTER SIMPLE
    JGRP[0] = TextDrawCreate(605.000000, 350.000000, "_");
	TextDrawFont(JGRP[0], 1);
	TextDrawLetterSize(JGRP[0], 0.600000, 8.000000);
	TextDrawTextSize(JGRP[0], 298.500000, 90.000000);
	TextDrawSetOutline(JGRP[0], 1);
	TextDrawSetShadow(JGRP[0], 1);
	TextDrawAlignment(JGRP[0], 2);
	TextDrawColor(JGRP[0], -1);
	TextDrawBackgroundColor(JGRP[0], 255);
	TextDrawBoxColor(JGRP[0], 135);
	TextDrawUseBox(JGRP[0], 1);
	TextDrawSetProportional(JGRP[0], 1);
	TextDrawSetSelectable(JGRP[0], 0);

	JGRP[1] = TextDrawCreate(565.000000, 392.000000, "hud:radar_diner");
	TextDrawFont(JGRP[1], 4);
	TextDrawLetterSize(JGRP[1], 0.600000, 2.000000);
	TextDrawTextSize(JGRP[1], 19.000000, 22.000000);
	TextDrawSetOutline(JGRP[1], 1);
	TextDrawSetShadow(JGRP[1], 0);
	TextDrawAlignment(JGRP[1], 1);
	TextDrawColor(JGRP[1], -1);
	TextDrawBackgroundColor(JGRP[1], 255);
	TextDrawBoxColor(JGRP[1], 50);
	TextDrawUseBox(JGRP[1], 1);
	TextDrawSetProportional(JGRP[1], 1);
	TextDrawSetSelectable(JGRP[1], 0);

	JGRP[2] = TextDrawCreate(565.000000, 357.000000, "hud:radar_dateFood");
	TextDrawFont(JGRP[2], 4);
	TextDrawLetterSize(JGRP[2], 0.600000, 2.000000);
	TextDrawTextSize(JGRP[2], 19.000000, 22.000000);
	TextDrawSetOutline(JGRP[2], 1);
	TextDrawSetShadow(JGRP[2], 0);
	TextDrawAlignment(JGRP[2], 1);
	TextDrawColor(JGRP[2], -1);
	TextDrawBackgroundColor(JGRP[2], 255);
	TextDrawBoxColor(JGRP[2], 50);
	TextDrawUseBox(JGRP[2], 1);
	TextDrawSetProportional(JGRP[2], 1);
	TextDrawSetSelectable(JGRP[2], 0);

	//ALPRASH VEH PACK
	AkuVeh[0] = TextDrawCreate(565.000000, 370.000000, "hud:radar_spray");
	TextDrawFont(AkuVeh[0], 4);
	TextDrawLetterSize(AkuVeh[0], 0.600000, 2.000000);
	TextDrawTextSize(AkuVeh[0], 17.000000, 19.000000);
	TextDrawSetOutline(AkuVeh[0], 1);
	TextDrawSetShadow(AkuVeh[0], 0);
	TextDrawAlignment(AkuVeh[0], 1);
	TextDrawColor(AkuVeh[0], -1);
	TextDrawBackgroundColor(AkuVeh[0], 255);
	TextDrawBoxColor(AkuVeh[0], 50);
	TextDrawUseBox(AkuVeh[0], 1);
	TextDrawSetProportional(AkuVeh[0], 1);
	TextDrawSetSelectable(AkuVeh[0], 0);

	AkuVeh[1] = TextDrawCreate(565.000000, 340.000000, "hud:radar_modGarage");
	TextDrawFont(AkuVeh[1], 4);
	TextDrawLetterSize(AkuVeh[1], 0.600000, 2.000000);
	TextDrawTextSize(AkuVeh[1], 17.000000, 19.000000);
	TextDrawSetOutline(AkuVeh[1], 1);
	TextDrawSetShadow(AkuVeh[1], 0);
	TextDrawAlignment(AkuVeh[1], 1);
	TextDrawColor(AkuVeh[1], -1);
	TextDrawBackgroundColor(AkuVeh[1], 255);
	TextDrawBoxColor(AkuVeh[1], 50);
	TextDrawUseBox(AkuVeh[1], 1);
	TextDrawSetProportional(AkuVeh[1], 1);
	TextDrawSetSelectable(AkuVeh[1], 0);

	AkuVeh[2] = TextDrawCreate(565.000000, 310.000000, "hud:radar_impound");
	TextDrawFont(AkuVeh[2], 4);
	TextDrawLetterSize(AkuVeh[2], 0.600000, 2.000000);
	TextDrawTextSize(AkuVeh[2], 17.000000, 19.000000);
	TextDrawSetOutline(AkuVeh[2], 1);
	TextDrawSetShadow(AkuVeh[2], 0);
	TextDrawAlignment(AkuVeh[2], 1);
	TextDrawColor(AkuVeh[2], -1);
	TextDrawBackgroundColor(AkuVeh[2], 255);
	TextDrawBoxColor(AkuVeh[2], 50);
	TextDrawUseBox(AkuVeh[2], 1);
	TextDrawSetProportional(AkuVeh[2], 1);
	TextDrawSetSelectable(AkuVeh[2], 0);

	AkuVeh[3] = TextDrawCreate(623.000000, 310.000000, "mph");
	TextDrawFont(AkuVeh[3], 1);
	TextDrawLetterSize(AkuVeh[3], 0.300000, 1.799998);
	TextDrawTextSize(AkuVeh[3], 400.000000, 17.000000);
	TextDrawSetOutline(AkuVeh[3], 1);
	TextDrawSetShadow(AkuVeh[3], 0);
	TextDrawAlignment(AkuVeh[3], 2);
	TextDrawColor(AkuVeh[3], -16776961);
	TextDrawBackgroundColor(AkuVeh[3], 255);
	TextDrawBoxColor(AkuVeh[3], 50);
	TextDrawUseBox(AkuVeh[3], 0);
	TextDrawSetProportional(AkuVeh[3], 1);
	TextDrawSetSelectable(AkuVeh[3], 0);

	//ALPRASH LAPAR HAUS
	LaparHaus[0] = TextDrawCreate(550.000000, 403.000000, "id_dual:white");
	TextDrawFont(LaparHaus[0], 4);
	TextDrawLetterSize(LaparHaus[0], 0.600000, 2.000000);
	TextDrawTextSize(LaparHaus[0], 70.000000, 45.000000);
	TextDrawSetOutline(LaparHaus[0], 1);
	TextDrawSetShadow(LaparHaus[0], 0);
	TextDrawAlignment(LaparHaus[0], 1);
	TextDrawColor(LaparHaus[0], -1);
	TextDrawBackgroundColor(LaparHaus[0], 255);
	TextDrawBoxColor(LaparHaus[0], 50);
	TextDrawUseBox(LaparHaus[0], 1);
	TextDrawSetProportional(LaparHaus[0], 1);
	TextDrawSetSelectable(LaparHaus[0], 0);

	LaparHaus[1] = TextDrawCreate(475.000000, 403.000000, "id_dual:white");
	TextDrawFont(LaparHaus[1], 4);
	TextDrawLetterSize(LaparHaus[1], 0.600000, 2.000000);
	TextDrawTextSize(LaparHaus[1], 70.000000, 45.000000);
	TextDrawSetOutline(LaparHaus[1], 1);
	TextDrawSetShadow(LaparHaus[1], 0);
	TextDrawAlignment(LaparHaus[1], 1);
	TextDrawColor(LaparHaus[1], -1);
	TextDrawBackgroundColor(LaparHaus[1], 255);
	TextDrawBoxColor(LaparHaus[1], 50);
	TextDrawUseBox(LaparHaus[1], 1);
	TextDrawSetProportional(LaparHaus[1], 1);
	TextDrawSetSelectable(LaparHaus[1], 0);

	LaparHaus[2] = TextDrawCreate(480.000000, 408.000000, "id_dual:white");
	TextDrawFont(LaparHaus[2], 4);
	TextDrawLetterSize(LaparHaus[2], 0.600000, 2.000000);
	TextDrawTextSize(LaparHaus[2], 60.000000, 35.000000);
	TextDrawSetOutline(LaparHaus[2], 1);
	TextDrawSetShadow(LaparHaus[2], 0);
	TextDrawAlignment(LaparHaus[2], 1);
	TextDrawColor(LaparHaus[2], 16711935);
	TextDrawBackgroundColor(LaparHaus[2], 255);
	TextDrawBoxColor(LaparHaus[2], 50);
	TextDrawUseBox(LaparHaus[2], 1);
	TextDrawSetProportional(LaparHaus[2], 1);
	TextDrawSetSelectable(LaparHaus[2], 0);

	LaparHaus[3] = TextDrawCreate(555.000000, 408.000000, "id_dual:white");
	TextDrawFont(LaparHaus[3], 4);
	TextDrawLetterSize(LaparHaus[3], 0.600000, 2.000000);
	TextDrawTextSize(LaparHaus[3], 60.000000, 35.000000);
	TextDrawSetOutline(LaparHaus[3], 1);
	TextDrawSetShadow(LaparHaus[3], 0);
	TextDrawAlignment(LaparHaus[3], 1);
	TextDrawColor(LaparHaus[3], 35839);
	TextDrawBackgroundColor(LaparHaus[3], 255);
	TextDrawBoxColor(LaparHaus[3], 50);
	TextDrawUseBox(LaparHaus[3], 1);
	TextDrawSetProportional(LaparHaus[3], 1);
	TextDrawSetSelectable(LaparHaus[3], 0);

	LaparHaus[4] = TextDrawCreate(485.000000, 415.000000, "hud:radar_dateFood");
	TextDrawFont(LaparHaus[4], 4);
	TextDrawLetterSize(LaparHaus[4], 0.600000, 2.000000);
	TextDrawTextSize(LaparHaus[4], 18.000000, 19.000000);
	TextDrawSetOutline(LaparHaus[4], 1);
	TextDrawSetShadow(LaparHaus[4], 0);
	TextDrawAlignment(LaparHaus[4], 1);
	TextDrawColor(LaparHaus[4], -1);
	TextDrawBackgroundColor(LaparHaus[4], 255);
	TextDrawBoxColor(LaparHaus[4], 50);
	TextDrawUseBox(LaparHaus[4], 1);
	TextDrawSetProportional(LaparHaus[4], 1);
	TextDrawSetSelectable(LaparHaus[4], 0);

	LaparHaus[5] = TextDrawCreate(560.000000, 415.000000, "hud:radar_diner");
	TextDrawFont(LaparHaus[5], 4);
	TextDrawLetterSize(LaparHaus[5], 0.600000, 2.000000);
	TextDrawTextSize(LaparHaus[5], 17.000000, 19.000000);
	TextDrawSetOutline(LaparHaus[5], 1);
	TextDrawSetShadow(LaparHaus[5], 0);
	TextDrawAlignment(LaparHaus[5], 1);
	TextDrawColor(LaparHaus[5], -1);
	TextDrawBackgroundColor(LaparHaus[5], 255);
	TextDrawBoxColor(LaparHaus[5], 50);
	TextDrawUseBox(LaparHaus[5], 1);
	TextDrawSetProportional(LaparHaus[5], 1);
	TextDrawSetSelectable(LaparHaus[5], 0);

	// Blindfold - Ez
	Blind = TextDrawCreate(641.199951, 1.500000, "usebox");
	TextDrawLetterSize(Blind, 0.000000, 49.378147);
	TextDrawTextSize(Blind, -2.000000, 0.000000);
	TextDrawAlignment(Blind, 3);
	TextDrawColor(Blind, -1);
	TextDrawUseBox(Blind, true);
	TextDrawBoxColor(Blind, 255);
	TextDrawSetShadow(Blind, 0);
	TextDrawSetOutline(Blind, 0);
	TextDrawBackgroundColor(Blind, 255);
	TextDrawFont(Blind, 1);

	TextFare = TextDrawCreate(427.000000, 400.583374, "Fare:");
	TextDrawLetterSize(TextFare, 0.360498, 1.022500);
	TextDrawAlignment(TextFare, 1);
	TextDrawColor(TextFare, -1);
	TextDrawSetShadow(TextFare, 0);
	TextDrawSetOutline(TextFare, 1);
	TextDrawBackgroundColor(TextFare, 255);
	TextDrawFont(TextFare, 1);
	TextDrawSetProportional(TextFare, 1);
	TextDrawSetShadow(TextFare, 0);

 	//Date and Time
	TextDate = TextDrawCreate(618.000000, 120.000000,"--");
	TextDrawBackgroundColor(TextDate, 255);
	TextDrawFont(TextDate, 1);
	TextDrawTextSize(TextDate, 735.500000, 610.000000);
	TextDrawLetterSize(TextDate, 0.199999, 1.250000);
	TextDrawSetOutline(TextDate, 1);
	TextDrawSetProportional(TextDate, 1);
	TextDrawAlignment(TextDate, 3);
	TextDrawSetShadow(TextDate, 1);
	TextDrawColor(TextDate,0xFFFFFFFF);

	TextTime = TextDrawCreate(600.000000, 150.000000,"--");
	TextDrawLetterSize(TextTime,0.270833, 1.150000);
	TextDrawFont(TextTime , 3);
	TextDrawTextSize(TextTime, 796.500000, 847.000000);
	TextDrawSetOutline(TextTime , 1);
	TextDrawAlignment(TextTime, 3);
    TextDrawSetProportional(TextTime , 1);
	TextDrawBackgroundColor(TextTime, 255);
	TextDrawSetShadow(TextTime, 1);
	TextDrawColor(TextTime,0xFFFFFFFF);

	//anim
	AnimH4N = TextDrawCreate(542.000000, 417.000000, /*~r~~k~~KEY_~ ~w~*/"H - To stop the animation");
	TextDrawUseBox(AnimH4N, 0);
	TextDrawFont(AnimH4N, 2);
	TextDrawSetShadow(AnimH4N,0); // no shadow
	TextDrawSetOutline(AnimH4N,1); // thickness 1
	TextDrawBackgroundColor(AnimH4N,0x000000FF);
	TextDrawColor(AnimH4N,0xFFFFFFFF);
	TextDrawAlignment(AnimH4N,3); // align right

	//KTP Textdraw
	KTPTD[0] = TextDrawCreate(498.000000, 203.000000, "_");
	TextDrawFont(KTPTD[0], 1);
	TextDrawLetterSize(KTPTD[0], 0.600000, 15.000005);
	TextDrawTextSize(KTPTD[0], 293.500000, 218.500000);
	TextDrawSetOutline(KTPTD[0], 1);
	TextDrawSetShadow(KTPTD[0], 0);
	TextDrawAlignment(KTPTD[0], 2);
	TextDrawColor(KTPTD[0], -1094795521);
	TextDrawBackgroundColor(KTPTD[0], 255);
	TextDrawBoxColor(KTPTD[0], -1094795521);
	TextDrawUseBox(KTPTD[0], 1);
	TextDrawSetProportional(KTPTD[0], 1);
	TextDrawSetSelectable(KTPTD[0], 0);

	KTPTD[1] = TextDrawCreate(498.000000, 205.000000, "_");
	TextDrawFont(KTPTD[1], 1);
	TextDrawLetterSize(KTPTD[1], 0.600000, 14.450003);
	TextDrawTextSize(KTPTD[1], 293.500000, 215.000000);
	TextDrawSetOutline(KTPTD[1], 1);
	TextDrawSetShadow(KTPTD[1], 0);
	TextDrawAlignment(KTPTD[1], 2);
	TextDrawColor(KTPTD[1], -1);
	TextDrawBackgroundColor(KTPTD[1], 255);
	TextDrawBoxColor(KTPTD[1], -1);
	TextDrawUseBox(KTPTD[1], 1);
	TextDrawSetProportional(KTPTD[1], 1);
	TextDrawSetSelectable(KTPTD[1], 0);

	KTPTD[2] = TextDrawCreate(446.000000, 235.000000, "ld_drv:bronze");
	TextDrawFont(KTPTD[2], 4);
	TextDrawLetterSize(KTPTD[2], 0.600000, 2.000000);
	TextDrawTextSize(KTPTD[2], 96.000000, 97.000000);
	TextDrawSetOutline(KTPTD[2], 1);
	TextDrawSetShadow(KTPTD[2], 0);
	TextDrawAlignment(KTPTD[2], 1);
	TextDrawColor(KTPTD[2], -198);
	TextDrawBackgroundColor(KTPTD[2], 255);
	TextDrawBoxColor(KTPTD[2], 50);
	TextDrawUseBox(KTPTD[2], 1);
	TextDrawSetProportional(KTPTD[2], 1);
	TextDrawSetSelectable(KTPTD[2], 0);

	KTPTD[3] = TextDrawCreate(498.000000, 205.000000, "_");
	TextDrawFont(KTPTD[3], 1);
	TextDrawLetterSize(KTPTD[3], 0.600000, 2.750005);
	TextDrawTextSize(KTPTD[3], 293.500000, 215.000000);
	TextDrawSetOutline(KTPTD[3], 1);
	TextDrawSetShadow(KTPTD[3], 0);
	TextDrawAlignment(KTPTD[3], 2);
	TextDrawColor(KTPTD[3], -1);
	TextDrawBackgroundColor(KTPTD[3], 255);
	TextDrawBoxColor(KTPTD[3], -16776961);
	TextDrawUseBox(KTPTD[3], 1);
	TextDrawSetProportional(KTPTD[3], 1);
	TextDrawSetSelectable(KTPTD[3], 0);

	KTPTD[4] = TextDrawCreate(487.000000, 233.000000, "ID_City_Card");
	TextDrawFont(KTPTD[4], 1);
	TextDrawLetterSize(KTPTD[4], 0.270832, 1.299998);
	TextDrawTextSize(KTPTD[4], 400.000000, 17.000000);
	TextDrawSetOutline(KTPTD[4], 1);
	TextDrawSetShadow(KTPTD[4], 0);
	TextDrawAlignment(KTPTD[4], 2);
	TextDrawColor(KTPTD[4], -16776961);
	TextDrawBackgroundColor(KTPTD[4], 255);
	TextDrawBoxColor(KTPTD[4], 50);
	TextDrawUseBox(KTPTD[4], 0);
	TextDrawSetProportional(KTPTD[4], 1);
	TextDrawSetSelectable(KTPTD[4], 0);

	KTPTD[5] = TextDrawCreate(402.000000, 206.000000, "ld_drv:bronze");
	TextDrawFont(KTPTD[5], 4);
	TextDrawLetterSize(KTPTD[5], 0.600000, 2.000000);
	TextDrawTextSize(KTPTD[5], 45.500000, 46.000000);
	TextDrawSetOutline(KTPTD[5], 1);
	TextDrawSetShadow(KTPTD[5], 0);
	TextDrawAlignment(KTPTD[5], 1);
	TextDrawColor(KTPTD[5], -1);
	TextDrawBackgroundColor(KTPTD[5], 255);
	TextDrawBoxColor(KTPTD[5], 50);
	TextDrawUseBox(KTPTD[5], 1);
	TextDrawSetProportional(KTPTD[5], 1);
	TextDrawSetSelectable(KTPTD[5], 0);

	KTPTD[6] = TextDrawCreate(490.000000, 207.000000, "Infinity");
	TextDrawFont(KTPTD[6], 2);
	TextDrawLetterSize(KTPTD[6], 0.383332, 2.549998);
	TextDrawTextSize(KTPTD[6], 400.000000, 17.000000);
	TextDrawSetOutline(KTPTD[6], 0);
	TextDrawSetShadow(KTPTD[6], 0);
	TextDrawAlignment(KTPTD[6], 2);
	TextDrawColor(KTPTD[6], -1);
	TextDrawBackgroundColor(KTPTD[6], 255);
	TextDrawBoxColor(KTPTD[6], 50);
	TextDrawUseBox(KTPTD[6], 0);
	TextDrawSetProportional(KTPTD[6], 1);
	TextDrawSetSelectable(KTPTD[6], 0);

	KTPTD[7] = TextDrawCreate(572.000000, 222.000000, "NIK:Infinity");
	TextDrawFont(KTPTD[7], 1);
	TextDrawLetterSize(KTPTD[7], 0.174998, 1.050001);
	TextDrawTextSize(KTPTD[7], 400.000000, 17.000000);
	TextDrawSetOutline(KTPTD[7], 1);
	TextDrawSetShadow(KTPTD[7], 0);
	TextDrawAlignment(KTPTD[7], 2);
	TextDrawColor(KTPTD[7], -1);
	TextDrawBackgroundColor(KTPTD[7], 255);
	TextDrawBoxColor(KTPTD[7], 50);
	TextDrawUseBox(KTPTD[7], 0);
	TextDrawSetProportional(KTPTD[7], 1);
	TextDrawSetSelectable(KTPTD[7], 0);

	KTPTD[8] = TextDrawCreate(387.000000, 254.000000, "Preview_Model");
	TextDrawFont(KTPTD[8], 5);
	TextDrawLetterSize(KTPTD[8], 0.600000, 2.000000);
	TextDrawTextSize(KTPTD[8], 59.500000, 70.500000);
	TextDrawSetOutline(KTPTD[8], 0);
	TextDrawSetShadow(KTPTD[8], 0);
	TextDrawAlignment(KTPTD[8], 1);
	TextDrawColor(KTPTD[8], -1);
	TextDrawBackgroundColor(KTPTD[8], 0);
	TextDrawBoxColor(KTPTD[8], 255);
	TextDrawUseBox(KTPTD[8], 0);
	TextDrawSetProportional(KTPTD[8], 1);
	TextDrawSetSelectable(KTPTD[8], 0);
	TextDrawSetPreviewModel(KTPTD[8], 2050);
	TextDrawSetPreviewRot(KTPTD[8], -10.000000, 0.000000, -1.000000, 0.720000);
	TextDrawSetPreviewVehCol(KTPTD[8], 1, 1);

	KTPTD[9] = TextDrawCreate(398.000000, 319.000000, "IIIIIIIII");
	TextDrawFont(KTPTD[9], 1);
	TextDrawLetterSize(KTPTD[9], 0.349999, 2.000000);
	TextDrawTextSize(KTPTD[9], 400.000000, 17.000000);
	TextDrawSetOutline(KTPTD[9], 0);
	TextDrawSetShadow(KTPTD[9], 0);
	TextDrawAlignment(KTPTD[9], 1);
	TextDrawColor(KTPTD[9], 255);
	TextDrawBackgroundColor(KTPTD[9], 255);
	TextDrawBoxColor(KTPTD[9], 50);
	TextDrawUseBox(KTPTD[9], 0);
	TextDrawSetProportional(KTPTD[9], 1);
	TextDrawSetSelectable(KTPTD[9], 0);

	KTPTD[10] = TextDrawCreate(462.000000, 251.000000, "Name:");
	TextDrawFont(KTPTD[10], 1);
	TextDrawLetterSize(KTPTD[10], 0.245831, 1.399999);
	TextDrawTextSize(KTPTD[10], 400.000000, 17.000000);
	TextDrawSetOutline(KTPTD[10], 1);
	TextDrawSetShadow(KTPTD[10], 0);
	TextDrawAlignment(KTPTD[10], 2);
	TextDrawColor(KTPTD[10], -1094795521);
	TextDrawBackgroundColor(KTPTD[10], 255);
	TextDrawBoxColor(KTPTD[10], 50);
	TextDrawUseBox(KTPTD[10], 0);
	TextDrawSetProportional(KTPTD[10], 1);
	TextDrawSetSelectable(KTPTD[10], 0);

	KTPTD[11] = TextDrawCreate(516.000000, 250.000000, "Zenn_Ganteng");
	TextDrawFont(KTPTD[11], 1);
	TextDrawLetterSize(KTPTD[11], 0.299997, 1.600000);
	TextDrawTextSize(KTPTD[11], 400.000000, 17.000000);
	TextDrawSetOutline(KTPTD[11], 1);
	TextDrawSetShadow(KTPTD[11], 0);
	TextDrawAlignment(KTPTD[11], 2);
	TextDrawColor(KTPTD[11], -1);
	TextDrawBackgroundColor(KTPTD[11], 255);
	TextDrawBoxColor(KTPTD[11], 50);
	TextDrawUseBox(KTPTD[11], 0);
	TextDrawSetProportional(KTPTD[11], 1);
	TextDrawSetSelectable(KTPTD[11], 0);

	KTPTD[12] = TextDrawCreate(466.000000, 266.000000, "Addreas:");
	TextDrawFont(KTPTD[12], 1);
	TextDrawLetterSize(KTPTD[12], 0.237498, 1.399999);
	TextDrawTextSize(KTPTD[12], 400.000000, 17.000000);
	TextDrawSetOutline(KTPTD[12], 1);
	TextDrawSetShadow(KTPTD[12], 0);
	TextDrawAlignment(KTPTD[12], 2);
	TextDrawColor(KTPTD[12], -1094795521);
	TextDrawBackgroundColor(KTPTD[12], 255);
	TextDrawBoxColor(KTPTD[12], 50);
	TextDrawUseBox(KTPTD[12], 0);
	TextDrawSetProportional(KTPTD[12], 1);
	TextDrawSetSelectable(KTPTD[12], 0);

	KTPTD[13] = TextDrawCreate(521.000000, 265.000000, "San_Andreas");
	TextDrawFont(KTPTD[13], 1);
	TextDrawLetterSize(KTPTD[13], 0.299997, 1.600000);
	TextDrawTextSize(KTPTD[13], 400.000000, 17.000000);
	TextDrawSetOutline(KTPTD[13], 1);
	TextDrawSetShadow(KTPTD[13], 0);
	TextDrawAlignment(KTPTD[13], 2);
	TextDrawColor(KTPTD[13], -1);
	TextDrawBackgroundColor(KTPTD[13], 255);
	TextDrawBoxColor(KTPTD[13], 50);
	TextDrawUseBox(KTPTD[13], 0);
	TextDrawSetProportional(KTPTD[13], 1);
	TextDrawSetSelectable(KTPTD[13], 0);

	KTPTD[14] = TextDrawCreate(465.000000, 281.000000, "Gender:");
	TextDrawFont(KTPTD[14], 1);
	TextDrawLetterSize(KTPTD[14], 0.237498, 1.399999);
	TextDrawTextSize(KTPTD[14], 400.000000, 17.000000);
	TextDrawSetOutline(KTPTD[14], 1);
	TextDrawSetShadow(KTPTD[14], 0);
	TextDrawAlignment(KTPTD[14], 2);
	TextDrawColor(KTPTD[14], -1094795521);
	TextDrawBackgroundColor(KTPTD[14], 255);
	TextDrawBoxColor(KTPTD[14], 50);
	TextDrawUseBox(KTPTD[14], 0);
	TextDrawSetProportional(KTPTD[14], 1);
	TextDrawSetSelectable(KTPTD[14], 0);

	KTPTD[15] = TextDrawCreate(497.000000, 281.000000, "100");
	TextDrawFont(KTPTD[15], 1);
	TextDrawLetterSize(KTPTD[15], 0.299997, 1.600000);
	TextDrawTextSize(KTPTD[15], 400.000000, 17.000000);
	TextDrawSetOutline(KTPTD[15], 1);
	TextDrawSetShadow(KTPTD[15], 0);
	TextDrawAlignment(KTPTD[15], 2);
	TextDrawColor(KTPTD[15], -1);
	TextDrawBackgroundColor(KTPTD[15], 255);
	TextDrawBoxColor(KTPTD[15], 50);
	TextDrawUseBox(KTPTD[15], 0);
	TextDrawSetProportional(KTPTD[15], 1);
	TextDrawSetSelectable(KTPTD[15], 0);

	KTPTD[16] = TextDrawCreate(459.000000, 296.000000, "Job:");
	TextDrawFont(KTPTD[16], 1);
	TextDrawLetterSize(KTPTD[16], 0.237498, 1.399999);
	TextDrawTextSize(KTPTD[16], 400.000000, 17.000000);
	TextDrawSetOutline(KTPTD[16], 1);
	TextDrawSetShadow(KTPTD[16], 0);
	TextDrawAlignment(KTPTD[16], 2);
	TextDrawColor(KTPTD[16], -1094795521);
	TextDrawBackgroundColor(KTPTD[16], 255);
	TextDrawBoxColor(KTPTD[16], 50);
	TextDrawUseBox(KTPTD[16], 0);
	TextDrawSetProportional(KTPTD[16], 1);
	TextDrawSetSelectable(KTPTD[16], 0);

	KTPTD[17] = TextDrawCreate(503.000000, 295.000000, "Tukang_Kuli");
	TextDrawFont(KTPTD[17], 1);
	TextDrawLetterSize(KTPTD[17], 0.299997, 1.600000);
	TextDrawTextSize(KTPTD[17], 400.000000, 17.000000);
	TextDrawSetOutline(KTPTD[17], 1);
	TextDrawSetShadow(KTPTD[17], 0);
	TextDrawAlignment(KTPTD[17], 2);
	TextDrawColor(KTPTD[17], -1);
	TextDrawBackgroundColor(KTPTD[17], 255);
	TextDrawBoxColor(KTPTD[17], 50);
	TextDrawUseBox(KTPTD[17], 0);
	TextDrawSetProportional(KTPTD[17], 1);
	TextDrawSetSelectable(KTPTD[17], 0);

	KTPTD[18] = TextDrawCreate(474.000000, 322.000000, "Masa_Berlaku:");
	TextDrawFont(KTPTD[18], 1);
	TextDrawLetterSize(KTPTD[18], 0.237498, 1.399999);
	TextDrawTextSize(KTPTD[18], 400.000000, 17.000000);
	TextDrawSetOutline(KTPTD[18], 1);
	TextDrawSetShadow(KTPTD[18], 0);
	TextDrawAlignment(KTPTD[18], 2);
	TextDrawColor(KTPTD[18], -1094795521);
	TextDrawBackgroundColor(KTPTD[18], 255);
	TextDrawBoxColor(KTPTD[18], 50);
	TextDrawUseBox(KTPTD[18], 0);
	TextDrawSetProportional(KTPTD[18], 1);
	TextDrawSetSelectable(KTPTD[18], 0);

	KTPTD[19] = TextDrawCreate(528.000000, 320.000000, "30_Hari");
	TextDrawFont(KTPTD[19], 1);
	TextDrawLetterSize(KTPTD[19], 0.299997, 1.600000);
	TextDrawTextSize(KTPTD[19], 400.000000, 17.000000);
	TextDrawSetOutline(KTPTD[19], 1);
	TextDrawSetShadow(KTPTD[19], 0);
	TextDrawAlignment(KTPTD[19], 2);
	TextDrawColor(KTPTD[19], -1);
	TextDrawBackgroundColor(KTPTD[19], 255);
	TextDrawBoxColor(KTPTD[19], 50);
	TextDrawUseBox(KTPTD[19], 0);
	TextDrawSetProportional(KTPTD[19], 1);
	TextDrawSetSelectable(KTPTD[19], 0);
}
