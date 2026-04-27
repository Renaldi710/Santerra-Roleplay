#if defined DCMD_PREFIX '>'
#undef DCMD_PREFIX
#endif

function CheckPutih(playerid)
{
	new File[256];
	format(File, sizeof(File), "Ucp/%s.txt", GetName(playerid));
	if(!dini_Exists(File))
	{
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "UCP Verifed", "UCP ini tidak terdaftar dalam Database.", "", "Close");
		KickEx(playerid);
	}
	else Info(playerid, "The UCP has registered at database.");
	return 1;
}

function OnUserVerif(strr[])
{
	new DCC_Channel:channel, DCC_Embed:ucp;
	new y, m, d, timestamp[20];
	getdate(y, m , d);
	format(timestamp, sizeof(timestamp), "i", y, m, d);
	channel = DCC_GetCreatedPrivateChannel();
	ucp = DCC_CreateEmbed("");
	DCC_SetEmbedTitle(ucp, "");
	DCC_SetEmbedTimestamp(ucp, timestamp);
	DCC_SetEmbedColor(ucp, 0x0);
	DCC_SetEmbedUrl(ucp, "");
	DCC_SetEmbedFooter(ucp, "", "");
	DCC_SetEmbedDescription(ucp, strr);
	DCC_SetEmbedImage(ucp, "");
	DCC_SendChannelEmbedMessage(channel, ucp);
	return 1;
}

DCMD:create(user, channel, params[])
{
	new DCC_Channel:bangrell;
	bangrell = DCC_FindChannelById("1408045910012985418");

	if(channel != bangrell) return DCC_SendChannelMessage(channel, "```\nUse this discord command in channel\n```");
	if(isnull(params)) return DCC_SendChannelMessage(channel, "You can't use discord command __>create__ to create ucp account");
	new file[2000], query[2000];
	format(file, sizeof(file), "Ucp/%s.txt", params);
	if(!dini_Exists(file))
	{
		dini_Create(file);
		new str[250], rani = random(10000);
		if(rani == 0 || rani < 1000)
		{
	 		rani = random(9999);
		}
		new rini[64];
		format(rini, 64, "%d", rani);
		new useri[DCC_ID_SIZE], DCC_User:userid;
		DCC_GetUserId(user, useri);
		userid = DCC_FindUserById(useri);
		mysql_format(g_SQL, query, sizeof(query), "INSERT INTO playerucp (`ucp`) VALUES ('%s', '0')", params);
		mysql_query(g_SQL, query);
		format(str, 250, "Clarnce Roleplay\nHello, your ucp has been successfully registered, please use the username ucp below to login!\nUCP\n\n%s\n", params);
		DCC_CreatePrivateChannel(userid, "OnUserVerif", "s", str);
		new DCC_Embed:acc, stri[2800];
		acc = DCC_CreateEmbed("");
		format(stri, 280, "Hello, your ucp %s you have successfully registered ucp Heppy roleplay!", params);
		new y, m, d, timestamp[200];
		getdate(y, m , d);
		format(timestamp, sizeof(timestamp), "", y, m, d);
		DCC_SetEmbedTitle(acc, "");
		DCC_SetEmbedTimestamp(acc, timestamp);
		DCC_SetEmbedColor(acc, 0x00);
		DCC_SetEmbedThumbnail(acc, "");
		DCC_SetEmbedFooter(acc, "", "");
		DCC_SetEmbedDescription(acc, stri);
		DCC_SendChannelEmbedMessage(channel, acc);
		new DCC_Guild:guild, DCC_Role:verified;
		verified = DCC_FindRoleById("1408045775568769086"); //id role warga
		DCC_GetChannelGuild(channel, guild);
		DCC_SetGuildMemberNickname(guild, user, params);
		DCC_AddGuildMemberRole(guild, user, verified);
	}
	else
	{
		new gs[80];
		format(gs, 80, "**ERROR** : Nama **%s** sudah terdaftar sebelumnya!", params);
		DCC_SendChannelMessage(channel, gs);
	}
	return 1;
}
