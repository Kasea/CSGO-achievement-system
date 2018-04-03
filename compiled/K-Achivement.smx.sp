/*
** ATTENTION
** THE PRODUCED CODE, IS NOT ABLE TO COMPILE!
** THE DECOMPILER JUST TRIES TO GIVE YOU A POSSIBILITY
** TO LOOK HOW A PLUGIN DOES IT'S JOB AND LOOK FOR
** POSSIBLE MALICIOUS CODE.
**
** ALL CONVERSIONS ARE WRONG! AT EXAMPLE:
** SetEntityRenderFx(client, RenderFx 0);  →  SetEntityRenderFx(client, view_as<RenderFx>0);  →  SetEntityRenderFx(client, RENDERFX_NONE);
*/

 PlVers __version = 5;
 float NULL_VECTOR[3];
 char NULL_STRING[1];
 Extension __ext_core = 72;
 int MaxClients;
 char CTag[11][0];
 char CTagCode[11][4] =
{
	"\x01",
	"\x02",
	"\x03",
	"\x04",
	"\x05",
	"\x06",
	"\x07",
	"\x08",
	"\x11",
	"\x12",
	"\x14"
}
 bool CTagReqSayText2[11];
 bool CEventIsHooked;
 bool CSkipList[66];
 bool CProfile_Colors[11] =
{
	1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
}
 int CProfile_TeamIndex[9] =
{
	-1, ...
}
 bool CProfile_SayText2;
 int e_player[66][10];
 Handle g_hSQL;
 Handle g_hStore;
 Handle g_hTimer;
 Extension __ext_sdktools = 12832;
 bool licence;
 int EpochTime = 1593882099;
 int g_iPlaytime[66];
 float g_fAirtime[66];
 bool g_bAirtime[66];
public Plugin myinfo =
{
	name = "K-Achivement",
	description = "",
	author = "Kasea",
	version = "1.0.0",
	url = ""
};
public int __ext_core_SetNTVOptional()
{
	MarkNativeAsOptional("GetFeatureStatus");
	MarkNativeAsOptional("RequireFeature");
	MarkNativeAsOptional("AddCommandListener");
	MarkNativeAsOptional("RemoveCommandListener");
	MarkNativeAsOptional("BfWriteBool");
	MarkNativeAsOptional("BfWriteByte");
	MarkNativeAsOptional("BfWriteChar");
	MarkNativeAsOptional("BfWriteShort");
	MarkNativeAsOptional("BfWriteWord");
	MarkNativeAsOptional("BfWriteNum");
	MarkNativeAsOptional("BfWriteFloat");
	MarkNativeAsOptional("BfWriteString");
	MarkNativeAsOptional("BfWriteEnt");
	MarkNativeAsOptional("BfWriteAngle");
	MarkNativeAsOptional("BfWriteCoord");
	MarkNativeAsOptional("BfWriteVecCoord");
	MarkNativeAsOptional("BfWriteVecNormal");
	MarkNativeAsOptional("BfWriteAngles");
	MarkNativeAsOptional("BfReadBool");
	MarkNativeAsOptional("BfReadByte");
	MarkNativeAsOptional("BfReadChar");
	MarkNativeAsOptional("BfReadShort");
	MarkNativeAsOptional("BfReadWord");
	MarkNativeAsOptional("BfReadNum");
	MarkNativeAsOptional("BfReadFloat");
	MarkNativeAsOptional("BfReadString");
	MarkNativeAsOptional("BfReadEntity");
	MarkNativeAsOptional("BfReadAngle");
	MarkNativeAsOptional("BfReadCoord");
	MarkNativeAsOptional("BfReadVecCoord");
	MarkNativeAsOptional("BfReadVecNormal");
	MarkNativeAsOptional("BfReadAngles");
	MarkNativeAsOptional("BfGetNumBytesLeft");
	MarkNativeAsOptional("BfWrite.WriteBool");
	MarkNativeAsOptional("BfWrite.WriteByte");
	MarkNativeAsOptional("BfWrite.WriteChar");
	MarkNativeAsOptional("BfWrite.WriteShort");
	MarkNativeAsOptional("BfWrite.WriteWord");
	MarkNativeAsOptional("BfWrite.WriteNum");
	MarkNativeAsOptional("BfWrite.WriteFloat");
	MarkNativeAsOptional("BfWrite.WriteString");
	MarkNativeAsOptional("BfWrite.WriteEntity");
	MarkNativeAsOptional("BfWrite.WriteAngle");
	MarkNativeAsOptional("BfWrite.WriteCoord");
	MarkNativeAsOptional("BfWrite.WriteVecCoord");
	MarkNativeAsOptional("BfWrite.WriteVecNormal");
	MarkNativeAsOptional("BfWrite.WriteAngles");
	MarkNativeAsOptional("BfRead.ReadBool");
	MarkNativeAsOptional("BfRead.ReadByte");
	MarkNativeAsOptional("BfRead.ReadChar");
	MarkNativeAsOptional("BfRead.ReadShort");
	MarkNativeAsOptional("BfRead.ReadWord");
	MarkNativeAsOptional("BfRead.ReadNum");
	MarkNativeAsOptional("BfRead.ReadFloat");
	MarkNativeAsOptional("BfRead.ReadString");
	MarkNativeAsOptional("BfRead.ReadEntity");
	MarkNativeAsOptional("BfRead.ReadAngle");
	MarkNativeAsOptional("BfRead.ReadCoord");
	MarkNativeAsOptional("BfRead.ReadVecCoord");
	MarkNativeAsOptional("BfRead.ReadVecNormal");
	MarkNativeAsOptional("BfRead.ReadAngles");
	MarkNativeAsOptional("BfRead.GetNumBytesLeft");
	MarkNativeAsOptional("PbReadInt");
	MarkNativeAsOptional("PbReadFloat");
	MarkNativeAsOptional("PbReadBool");
	MarkNativeAsOptional("PbReadString");
	MarkNativeAsOptional("PbReadColor");
	MarkNativeAsOptional("PbReadAngle");
	MarkNativeAsOptional("PbReadVector");
	MarkNativeAsOptional("PbReadVector2D");
	MarkNativeAsOptional("PbGetRepeatedFieldCount");
	MarkNativeAsOptional("PbSetInt");
	MarkNativeAsOptional("PbSetFloat");
	MarkNativeAsOptional("PbSetBool");
	MarkNativeAsOptional("PbSetString");
	MarkNativeAsOptional("PbSetColor");
	MarkNativeAsOptional("PbSetAngle");
	MarkNativeAsOptional("PbSetVector");
	MarkNativeAsOptional("PbSetVector2D");
	MarkNativeAsOptional("PbAddInt");
	MarkNativeAsOptional("PbAddFloat");
	MarkNativeAsOptional("PbAddBool");
	MarkNativeAsOptional("PbAddString");
	MarkNativeAsOptional("PbAddColor");
	MarkNativeAsOptional("PbAddAngle");
	MarkNativeAsOptional("PbAddVector");
	MarkNativeAsOptional("PbAddVector2D");
	MarkNativeAsOptional("PbRemoveRepeatedFieldValue");
	MarkNativeAsOptional("PbReadMessage");
	MarkNativeAsOptional("PbReadRepeatedMessage");
	MarkNativeAsOptional("PbAddMessage");
	MarkNativeAsOptional("Protobuf.ReadInt");
	MarkNativeAsOptional("Protobuf.ReadFloat");
	MarkNativeAsOptional("Protobuf.ReadBool");
	MarkNativeAsOptional("Protobuf.ReadString");
	MarkNativeAsOptional("Protobuf.ReadColor");
	MarkNativeAsOptional("Protobuf.ReadAngle");
	MarkNativeAsOptional("Protobuf.ReadVector");
	MarkNativeAsOptional("Protobuf.ReadVector2D");
	MarkNativeAsOptional("Protobuf.GetRepeatedFieldCount");
	MarkNativeAsOptional("Protobuf.SetInt");
	MarkNativeAsOptional("Protobuf.SetFloat");
	MarkNativeAsOptional("Protobuf.SetBool");
	MarkNativeAsOptional("Protobuf.SetString");
	MarkNativeAsOptional("Protobuf.SetColor");
	MarkNativeAsOptional("Protobuf.SetAngle");
	MarkNativeAsOptional("Protobuf.SetVector");
	MarkNativeAsOptional("Protobuf.SetVector2D");
	MarkNativeAsOptional("Protobuf.AddInt");
	MarkNativeAsOptional("Protobuf.AddFloat");
	MarkNativeAsOptional("Protobuf.AddBool");
	MarkNativeAsOptional("Protobuf.AddString");
	MarkNativeAsOptional("Protobuf.AddColor");
	MarkNativeAsOptional("Protobuf.AddAngle");
	MarkNativeAsOptional("Protobuf.AddVector");
	MarkNativeAsOptional("Protobuf.AddVector2D");
	MarkNativeAsOptional("Protobuf.RemoveRepeatedFieldValue");
	MarkNativeAsOptional("Protobuf.ReadMessage");
	MarkNativeAsOptional("Protobuf.ReadRepeatedMessage");
	MarkNativeAsOptional("Protobuf.AddMessage");
	VerifyCoreVersion();
	return 0;
}

bool StrEqual(char str1[], char str2[], bool caseSensitive)
{
	return strcmp(str1, str2, caseSensitive) == 0;
}

Handle StartMessageOne(char msgname[], int client, int flags)
{
	int players[1];
	players[0] = client;
	return StartMessage(msgname, players, 1, flags);
}

MoveType GetEntityMoveType(int entity)
{
	static bool gotconfig;
	static char datamap[8];
	if (!gotconfig)
	{
		Handle gc = LoadGameConfigFile("core.games");
		bool exists = GameConfGetKeyValue(gc, "m_MoveType", "", 32);
		CloseHandle(gc);
		if (!exists)
		{
			strcopy("", 32, "m_MoveType");
		}
		__unk = 1;
	}
	return GetEntProp(entity, PropType 1, "", 4, 0);
}

void CPrintToChat(int client, char szMessage[])
{
	int var1;
	if (client <= 0)
	{
		ThrowError("Invalid client index %d", client);
	}
	if (!IsClientInGame(client))
	{
		ThrowError("Client %d is not in game", client);
	}
	char szBuffer[252];
	char szCMessage[252];
	SetGlobalTransTarget(client);
	Format(szBuffer, 250, "\x01%s", szMessage);
	VFormat(szCMessage, 250, szBuffer, 3);
	int index = CFormat(szCMessage, 250, -1);
	if (index == -1)
	{
		PrintToChat(client, "%s", szCMessage);
	}
	else
	{
		CSayText2(client, index, szCMessage);
	}
	return void 0;
}

void CPrintToChatAll(char szMessage[])
{
	char szBuffer[252];
	int i = 1;
	while (i <= MaxClients)
	{
		int var1;
		if (IsClientInGame(i))
		{
			SetGlobalTransTarget(i);
			VFormat(szBuffer, 250, szMessage, 2);
			CPrintToChat(i, "%s", szBuffer);
		}
		CSkipList[i] = 0;
		i++;
	}
	return void 0;
}

int CFormat(char szMessage[], int maxlength, int author)
{
	char szGameName[32];
	GetGameFolderName(szGameName, 30);
	if (!CEventIsHooked)
	{
		CSetupProfile();
		HookEvent("server_spawn", EventHook 17, EventHookMode 2);
		CEventIsHooked = 1;
	}
	int iRandomPlayer = -1;
	if (StrEqual(szGameName, "csgo", false))
	{
		Format(szMessage, maxlength, " \x01\x11\x01%s", szMessage);
	}
	if (author != -1)
	{
		if (CProfile_SayText2)
		{
			ReplaceString(szMessage, maxlength, "{teamcolor}", "\x03", false);
			iRandomPlayer = author;
		}
		else
		{
			ReplaceString(szMessage, maxlength, "{teamcolor}", CTagCode[12][0], false);
		}
	}
	else
	{
		ReplaceString(szMessage, maxlength, "{teamcolor}", "", false);
	}
	int i = 0;
	while (i < 11)
	{
		if (!(StrContains(szMessage, CTag[i][0][0], false) == -1))
		{
			if (!CProfile_Colors[i][0][0])
			{
				ReplaceString(szMessage, maxlength, CTag[i][0][0], CTagCode[12][0], false);
			}
			else
			{
				if (!CTagReqSayText2[i][0][0])
				{
					ReplaceString(szMessage, maxlength, CTag[i][0][0], CTagCode[i][0][0], false);
				}
				if (!CProfile_SayText2)
				{
					ReplaceString(szMessage, maxlength, CTag[i][0][0], CTagCode[12][0], false);
				}
				if (iRandomPlayer == -1)
				{
					iRandomPlayer = CFindRandomPlayerByTeam(CProfile_TeamIndex[i][0][0]);
					if (iRandomPlayer == -2)
					{
						ReplaceString(szMessage, maxlength, CTag[i][0][0], CTagCode[12][0], false);
					}
					else
					{
						ReplaceString(szMessage, maxlength, CTag[i][0][0], CTagCode[i][0][0], false);
					}
				}
				ThrowError("Using two team colors in one message is not allowed");
			}
		}
		i++;
	}
	return iRandomPlayer;
}

int CFindRandomPlayerByTeam(int color_team)
{
	if (color_team)
	{
		int i = 1;
		while (i <= MaxClients)
		{
			int var1;
			if (IsClientInGame(i))
			{
				return i;
			}
			i++;
		}
		return -2;
	}
	return 0;
}

void CSayText2(int client, int author, char szMessage[])
{
	Handle hBuffer = StartMessageOne("SayText2", client, 132);
	int var1;
	if (GetFeatureStatus(FeatureType 0, "GetUserMessageType"))
	{
		PbSetInt(hBuffer, "ent_idx", author, -1);
		PbSetBool(hBuffer, "chat", true, -1);
		PbSetString(hBuffer, "msg_name", szMessage, -1);
		PbAddString(hBuffer, "params", "");
		PbAddString(hBuffer, "params", "");
		PbAddString(hBuffer, "params", "");
		PbAddString(hBuffer, "params", "");
	}
	else
	{
		BfWriteByte(hBuffer, author);
		BfWriteByte(hBuffer, 1);
		BfWriteString(hBuffer, szMessage);
	}
	EndMessage();
	return void 0;
}

void CSetupProfile()
{
	char szGameName[32];
	GetGameFolderName(szGameName, 30);
	if (StrEqual(szGameName, "csgo", false))
	{
		CProfile_Colors[4] = 1;
		CProfile_Colors[8] = 1;
		CProfile_Colors[12] = 1;
		CProfile_Colors[16] = 1;
		CProfile_Colors[20] = 1;
		CProfile_Colors[24] = 1;
		CProfile_Colors[28] = 1;
		CProfile_Colors[32] = 1;
		CProfile_Colors[36] = 1;
		CProfile_Colors[40] = 1;
		CProfile_TeamIndex[20] = 2;
		CProfile_TeamIndex[28] = 3;
		CProfile_SayText2 = 1;
	}
	else
	{
		if (GetUserMessageId("SayText2") == -1)
		{
			CProfile_SayText2 = 0;
		}
		CProfile_Colors[20] = 1;
		CProfile_Colors[28] = 1;
		CProfile_TeamIndex[20] = 2;
		CProfile_TeamIndex[28] = 3;
		CProfile_SayText2 = 1;
	}
	return void 0;
}

public Action CEvent_MapStart(Handle event, char name[], bool dontBroadcast)
{
	CSetupProfile();
	int i = 1;
	while (i <= MaxClients)
	{
		CSkipList[i] = 0;
		i++;
	}
	return Action 0;
}

Player Player.Player(int client)
{
	if (IsValidClient(client, false))
	{
		return client;
	}
	return Player -1;
}

int Player.index.get(Player this)
{
	return this;
}

int Player.iPoints.get(Player this)
{
	return e_player[Player.index.get(this)][0][0][0];
}

void Player.iPoints.set(Player this, int val)
{
	e_player[Player.index.get(this)][0][0][0] = val;
	return void 0;
}

int Player.iAchivs.get(Player this)
{
	return e_player[Player.index.get(this)][0][0][4];
}

void Player.iAchivs.set(Player this, int val)
{
	e_player[Player.index.get(this)][0][0][4] = val;
	return void 0;
}

int Player.iJumps.get(Player this)
{
	return e_player[Player.index.get(this)][0][0][8];
}

void Player.iJumps.set(Player this, int val)
{
	e_player[Player.index.get(this)][0][0][8] = val;
	return void 0;
}

int Player.iKills.get(Player this)
{
	return e_player[Player.index.get(this)][0][0][12];
}

void Player.iKills.set(Player this, int val)
{
	e_player[Player.index.get(this)][0][0][12] = val;
	return void 0;
}

int Player.iMaps.get(Player this)
{
	return e_player[Player.index.get(this)][0][0][16];
}

void Player.iMaps.set(Player this, int val)
{
	e_player[Player.index.get(this)][0][0][16] = val;
	return void 0;
}

int Player.iDeaths.get(Player this)
{
	return e_player[Player.index.get(this)][0][0][20];
}

void Player.iDeaths.set(Player this, int val)
{
	e_player[Player.index.get(this)][0][0][20] = val;
	return void 0;
}

int Player.iShots.get(Player this)
{
	return e_player[Player.index.get(this)][0][0][24];
}

void Player.iShots.set(Player this, int val)
{
	e_player[Player.index.get(this)][0][0][24] = val;
	return void 0;
}

float Player.fAirtime.get(Player this)
{
	return e_player[Player.index.get(this)][0][0][28];
}

void Player.fAirtime.set(Player this, float val)
{
	e_player[Player.index.get(this)][0][0][28] = val;
	return void 0;
}

int Player.iSpeed.get(Player this)
{
	return e_player[Player.index.get(this)][0][0][32];
}

void Player.iSpeed.set(Player this, int val)
{
	e_player[Player.index.get(this)][0][0][32] = val;
	return void 0;
}

int Player.iPlaytime.get(Player this)
{
	return e_player[Player.index.get(this)][0][0][36];
}

void Player.iPlaytime.set(Player this, int val)
{
	e_player[Player.index.get(this)][0][0][36] = val;
	return void 0;
}


/* ERROR! Unable to cast object of type 'Lysis.DReturn' to type 'Lysis.DJumpCondition'. */
 function "IsValidClient" (number 33)
int StringSubString(char input[], int startindx, int endindx, char dest[], int maxlength)
{
	Format(dest, maxlength, input[startindx]);
	if (strlen(input) > endindx)
	{
		ReplaceString(dest, maxlength, input[endindx], "", true);
	}
	return 0;
}

bool IsClientInAir(int client)
{
	int var1;
	if (!GetEntityFlags(client) & 1)
	{
		return true;
	}
	return false;
}

public void LoadInfo(int client)
{
	char query[256];
	char SteamID[32];
	GetClientAuthId(client, AuthIdType 1, SteamID, 32, true);
	Format(query, 256, "INSERT IGNORE INTO players(SteamID, points, achivements, jumps, kills, maps, deaths, shots, airtime, speed, playtime, name) VALUES('%s', 0, 0, 0, 0, 0, 0, 0, 0.00, 0, 0, \"%N\")", SteamID, client);
	SQL_TQuery(g_hSQL, SQLTCallback 13, query, any 0, DBPriority 1);
	Format(query, 256, "SELECT points, achivements, jumps, kills, maps, deaths, shots, airtime, speed, playtime FROM players WHERE SteamID = '%s'", SteamID);
	SQL_TQuery(g_hSQL, SQLTCallback 9, query, client, DBPriority 1);
	return void 0;
}

public int CB_LoadInfo(Handle owner, Handle hndl, char error[], any param1)
{
	if (hndl)
	{
		Player player = Player.Player(param1);
		while (SQL_FetchRow(hndl))
		{
			Player.iPoints.set(player, SQL_FetchInt(hndl, 0, 0));
			Player.iAchivs.set(player, SQL_FetchInt(hndl, 1, 0));
			Player.iJumps.set(player, SQL_FetchInt(hndl, 2, 0));
			Player.iKills.set(player, SQL_FetchInt(hndl, 3, 0));
			Player.iMaps.set(player, SQL_FetchInt(hndl, 4, 0));
			Player.iDeaths.set(player, SQL_FetchInt(hndl, 5, 0));
			Player.iShots.set(player, SQL_FetchInt(hndl, 6, 0));
			Player.fAirtime.set(player, SQL_FetchFloat(hndl, 7, 0));
			Player.iSpeed.set(player, SQL_FetchInt(hndl, 8, 0));
			Player.iPlaytime.set(player, SQL_FetchInt(hndl, 9, 0));
		}
		CountAchivements(param1);
		UpdateMapsCompleted(param1);
		return 0;
	}
	SetFailState("Failed to connect to SQL database. Error: %s", error);
	return 0;
}

public void SaveInfo(int client)
{
	Player player = Player.Player(client);
	char query[256];
	char SteamID[32];
	GetClientAuthId(client, AuthIdType 1, SteamID, 32, true);
	Format(query, 256, "UPDATE players SET name = \"%N\" WHERE SteamID = '%s'", client, SteamID);
	SQL_TQuery(g_hSQL, SQLTCallback 13, query, any 1, DBPriority 1);
	Format(query, 256, "UPDATE players SET points = %i WHERE SteamID = '%s'", Player.iPoints.get(player), SteamID);
	SQL_TQuery(g_hSQL, SQLTCallback 13, query, any 2, DBPriority 1);
	Format(query, 256, "UPDATE players SET achivements = %i WHERE SteamID = '%s'", Player.iAchivs.get(player), SteamID);
	SQL_TQuery(g_hSQL, SQLTCallback 13, query, any 3, DBPriority 1);
	Format(query, 256, "UPDATE players SET jumps = %i WHERE SteamID = '%s'", Player.iJumps.get(player), SteamID);
	SQL_TQuery(g_hSQL, SQLTCallback 13, query, any 4, DBPriority 1);
	Format(query, 256, "UPDATE players SET kills = %i WHERE SteamID = '%s'", Player.iKills.get(player), SteamID);
	SQL_TQuery(g_hSQL, SQLTCallback 13, query, any 5, DBPriority 1);
	Format(query, 256, "UPDATE players SET maps = %i WHERE SteamID = '%s'", Player.iMaps.get(player), SteamID);
	SQL_TQuery(g_hSQL, SQLTCallback 13, query, any 6, DBPriority 1);
	Format(query, 256, "UPDATE players SET deaths = %i WHERE SteamID = '%s'", Player.iDeaths.get(player), SteamID);
	SQL_TQuery(g_hSQL, SQLTCallback 13, query, any 7, DBPriority 1);
	Format(query, 256, "UPDATE players SET shots = %i WHERE SteamID = '%s'", Player.iShots.get(player), SteamID);
	SQL_TQuery(g_hSQL, SQLTCallback 13, query, any 8, DBPriority 1);
	Format(query, 256, "UPDATE players SET airtime = %f WHERE SteamID = '%s'", Player.fAirtime.get(player), SteamID);
	SQL_TQuery(g_hSQL, SQLTCallback 13, query, any 9, DBPriority 1);
	Format(query, 256, "UPDATE players SET speed = %i WHERE SteamID = '%s'", Player.iSpeed.get(player), SteamID);
	SQL_TQuery(g_hSQL, SQLTCallback 13, query, any 10, DBPriority 1);
	Format(query, 256, "UPDATE players SET playtime = %i WHERE SteamID = '%s'", Player.iPlaytime.get(player), SteamID);
	SQL_TQuery(g_hSQL, SQLTCallback 13, query, any 11, DBPriority 1);
	return void 0;
}

public void CheckPlayer(int client)
{
	char SteamID[32];
	char query[512];
	GetClientAuthId(client, AuthIdType 1, SteamID, 32, true);
	Handle SQL_Transaction = SQL_CreateTransaction();
	Player player = Player.Player(client);
	Format(query, 512, "SELECT a.id as AchivID, p.id as PlayID FROM achivements a, players p WHERE NOT EXISTS(SELECT 1 FROM completed_achivements WHERE completed_achivements.achiv_id = a.id AND completed_achivements.play_id = p.id) AND p.SteamID = '%s' AND a.type = 'points' AND a.score<=p.%i;", SteamID, Player.iPoints.get(player));
	SQL_AddQuery(SQL_Transaction, query, any 0);
	Format(query, 512, "SELECT a.id as AchivID, p.id as PlayID FROM achivements a, players p WHERE NOT EXISTS(SELECT 1 FROM completed_achivements WHERE completed_achivements.achiv_id = a.id AND completed_achivements.play_id = p.id) AND p.SteamID = '%s' AND a.type = 'achivements' AND a.score<=p.%i;", SteamID, Player.iAchivs.get(player));
	SQL_AddQuery(SQL_Transaction, query, any 0);
	Format(query, 512, "SELECT a.id as AchivID, p.id as PlayID FROM achivements a, players p WHERE NOT EXISTS(SELECT 1 FROM completed_achivements WHERE completed_achivements.achiv_id = a.id AND completed_achivements.play_id = p.id) AND p.SteamID = '%s' AND a.type = 'jumps' AND a.score<=p.%i;", SteamID, Player.iJumps.get(player));
	SQL_AddQuery(SQL_Transaction, query, any 0);
	Format(query, 512, "SELECT a.id as AchivID, p.id as PlayID FROM achivements a, players p WHERE NOT EXISTS(SELECT 1 FROM completed_achivements WHERE completed_achivements.achiv_id = a.id AND completed_achivements.play_id = p.id) AND p.SteamID = '%s' AND a.type = 'kills' AND a.score<=p.%i;", SteamID, Player.iKills.get(player));
	SQL_AddQuery(SQL_Transaction, query, any 0);
	Format(query, 512, "SELECT a.id as AchivID, p.id as PlayID FROM achivements a, players p WHERE NOT EXISTS(SELECT 1 FROM completed_achivements WHERE completed_achivements.achiv_id = a.id AND completed_achivements.play_id = p.id) AND p.SteamID = '%s' AND a.type = 'maps' AND a.score<=p.%i;", SteamID, Player.iAchivs.get(player));
	SQL_AddQuery(SQL_Transaction, query, any 0);
	Format(query, 512, "SELECT a.id as AchivID, p.id as PlayID FROM achivements a, players p WHERE NOT EXISTS(SELECT 1 FROM completed_achivements WHERE completed_achivements.achiv_id = a.id AND completed_achivements.play_id = p.id) AND p.SteamID = '%s' AND a.type = 'deaths' AND a.score<=p.%i;", SteamID, Player.iDeaths.get(player));
	SQL_AddQuery(SQL_Transaction, query, any 0);
	Format(query, 512, "SELECT a.id as AchivID, p.id as PlayID FROM achivements a, players p WHERE NOT EXISTS(SELECT 1 FROM completed_achivements WHERE completed_achivements.achiv_id = a.id AND completed_achivements.play_id = p.id) AND p.SteamID = '%s' AND a.type = 'shots' AND a.score<=p.%i;", SteamID, Player.iShots.get(player));
	SQL_AddQuery(SQL_Transaction, query, any 0);
	Format(query, 512, "SELECT a.id as AchivID, p.id as PlayID FROM achivements a, players p WHERE NOT EXISTS(SELECT 1 FROM completed_achivements WHERE completed_achivements.achiv_id = a.id AND completed_achivements.play_id = p.id) AND p.SteamID = '%s' AND a.type = 'airtime' AND a.score<=p.%f;", SteamID, Player.fAirtime.get(player));
	SQL_AddQuery(SQL_Transaction, query, any 0);
	Format(query, 512, "SELECT a.id as AchivID, p.id as PlayID FROM achivements a, players p WHERE NOT EXISTS(SELECT 1 FROM completed_achivements WHERE completed_achivements.achiv_id = a.id AND completed_achivements.play_id = p.id) AND p.SteamID = '%s' AND a.type = 'speed' AND a.score<=p.%i;", SteamID, Player.iSpeed.get(player));
	SQL_AddQuery(SQL_Transaction, query, any 0);
	Format(query, 512, "SELECT a.id as AchivID, p.id as PlayID FROM achivements a, players p WHERE NOT EXISTS(SELECT 1 FROM completed_achivements WHERE completed_achivements.achiv_id = a.id AND completed_achivements.play_id = p.id) AND p.SteamID = '%s' AND a.type = 'playtime' AND a.score<=p.%i;", SteamID, Player.iPlaytime.get(player));
	SQL_AddQuery(SQL_Transaction, query, any 0);
	SQL_ExecuteTransaction(g_hSQL, SQL_Transaction, SQLTxnSuccess 83, SQLTxnFailure -1, client, DBPriority 1);
	return void 0;
}

public int txn_CheckPlayer(Handle db, any client, int numQueries, Handle hndl[], any queryData[])
{
	if (!IsValidClient(client, false))
	{
		return 0;
	}
	char query[256];
	int i = 0;
	while (i < numQueries)
	{
		if (hndl[i])
		{
			while (SQL_FetchRow(hndl[i]))
			{
				Format(query, 256, "INSERT INTO completed_achivements(achiv_id, play_id) VALUES(%i, %i);", SQL_FetchInt(hndl[i], 0, 0), SQL_FetchInt(hndl[i], 1, 0));
				GotAchivement(client, SQL_FetchInt(hndl[i], 0, 0));
				SQL_TQuery(g_hSQL, SQLTCallback 13, query, any 12, DBPriority 1);
			}
			i++;
		}
		else
		{
			SetFailState("Failed during the txn_CheckPlayer at the count %i", i);
			return 0;
		}
		while (SQL_FetchRow(hndl[i]))
		{
			Format(query, 256, "INSERT INTO completed_achivements(achiv_id, play_id) VALUES(%i, %i);", SQL_FetchInt(hndl[i], 0, 0), SQL_FetchInt(hndl[i], 1, 0));
			GotAchivement(client, SQL_FetchInt(hndl[i], 0, 0));
			SQL_TQuery(g_hSQL, SQLTCallback 13, query, any 12, DBPriority 1);
		}
		i++;
	}
	return 0;
}

public void GotAchivement(int client, int achivementId)
{
	char query[256];
	Format(query, 256, "SELECT name, points, credits FROM achivements WHERE id = %i", achivementId);
	SQL_TQuery(g_hSQL, SQLTCallback 7, query, client, DBPriority 1);
	return void 0;
}

public int CB_GotAchivement(Handle owner, Handle hndl, char error[], any client)
{
	if (!IsValidClient(client, false))
	{
		return 0;
	}
	if (hndl)
	{
		Player player = Player.Player(client);
		char achiv[64];
		char SteamID[32];
		GetClientAuthId(client, AuthIdType 1, SteamID, 32, true);
		while (SQL_FetchRow(hndl))
		{
			SQL_FetchString(hndl, 0, achiv, 64, 0);
			CPrintToChatAll("%t", 10072, client, achiv);
			int var1 = player;
			Player.iPoints.set(var1, SQL_FetchInt(hndl, 1, 0) + Player.iPoints.get(var1));
			GiveCredits(SteamID, SQL_FetchInt(hndl, 2, 0));
		}
		return 0;
	}
	SetFailState("Failed to connect to SQL database. Error: %s", error);
	return 0;
}

public int CB_Maps(Handle owner, Handle hndl, char error[], any param1)
{
	if (hndl)
	{
		Player player = Player.Player(param1);
		while (SQL_FetchRow(hndl))
		{
			Player.iMaps.set(player, SQL_FetchInt(hndl, 0, 0));
		}
		return 0;
	}
	SetFailState("Failed to connect to SQL database. Error: %s", error);
	return 0;
}

public int CB_AchivementCount(Handle owner, Handle hndl, char error[], any param1)
{
	if (hndl)
	{
		Player player = Player.Player(param1);
		while (SQL_FetchRow(hndl))
		{
			Player.iAchivs.set(player, SQL_FetchInt(hndl, 0, 0));
		}
		return 0;
	}
	SetFailState("Failed to connect to SQL database. Error: %s", error);
	return 0;
}

public int CB_Useless(Handle owner, Handle hndl, char error[], any param1)
{
	if (hndl)
	{
		return 0;
	}
	SetFailState("Failed to connect to SQL database. Error: %s | Param1 = %i", error, param1);
	return 0;
}

public void CreateDatabase()
{
	SQL_TQuery(g_hSQL, SQLTCallback 13, "CREATE TABLE IF NOT EXISTS `players` ( `id` int(11) NOT NULL AUTO_INCREMENT, `SteamID` varchar(32) DEFAULT NULL, `name` varchar(32) NOT NULL, `points` int(11) NOT NULL, `achivements` int(11) NOT NULL, `jumps` int(11) NOT NULL, `kills` int(11) NOT NULL, `maps` int(11) NOT NULL, `deaths` int(11) NOT NULL, `shots` int(11) NOT NULL, `airtime` float(9,2) NOT NULL, `speed` int(12) NOT NULL, `playtime` int(32) NOT NULL, PRIMARY KEY (`id`), UNIQUE KEY `SteamID` (`SteamID`))", any 13, DBPriority 1);
	SQL_TQuery(g_hSQL, SQLTCallback 13, "CREATE TABLE IF NOT EXISTS `completed_achivements` ( `achiv_id` int(11) NOT NULL, `play_id` int(11) NOT NULL, PRIMARY KEY(`achiv_id`, `play_id`));", any 14, DBPriority 1);
	SQL_TQuery(g_hSQL, SQLTCallback 13, "CREATE TABLE IF NOT EXISTS `achivements` ( `id` int(11) NOT NULL AUTO_INCREMENT, `name` varchar(128) NOT NULL, `type` varchar(32) DEFAULT 'temp', `points` int(11) NOT NULL DEFAULT '0', `score` int(11) NOT NULL DEFAULT '0', `credits` int(11) NOT NULL DEFAULT '0', `hidden` tinyint(1) NOT NULL DEFAULT '0', PRIMARY KEY (`id`,`name`))", any 15, DBPriority 1);
	return void 0;
}

public int GiveCredits(char t_steamid[], int amount)
{
	char steamid[32];
	char query[256];
	StringSubString(t_steamid, 8, 32, steamid, 32);
	Format(query, 256, "UPDATE store_players SET store_players.credits = (store_players.credits + %i) WHERE store_players.authid = '%s';", amount, steamid);
	SQL_TQuery(g_hStore, SQLTCallback 13, query, any 16, DBPriority 1);
	return 0;
}

public Handle GetSQL()
{
	return g_hSQL;
}

public Action timer_retryConnectSQL(Handle timer, any data)
{
	ConnectSQL(data);
	return Action 4;
}

public void ConnectSQL(int DB)
{
	char errorBuffer[256];
	switch (DB)
	{
		case 0: {
			g_hSQL = SQL_Connect("achievement", true, errorBuffer, 256);
			g_hStore = SQL_Connect("store", true, errorBuffer, 256);
			g_hTimer = SQL_Connect("timer", true, errorBuffer, 256);
		}
		case 1: {
			if (g_hSQL)
			{
				CloseHandle(g_hSQL);
			}
			g_hSQL = 0;
			g_hSQL = SQL_Connect("achievement", true, errorBuffer, 256);
		}
		case 2: {
			if (g_hStore)
			{
				CloseHandle(g_hStore);
			}
			g_hStore = 0;
			g_hStore = SQL_Connect("achivement", true, errorBuffer, 256);
		}
		case 3: {
			if (g_hTimer)
			{
				CloseHandle(g_hTimer);
			}
			g_hTimer = 0;
			g_hTimer = SQL_Connect("achivement", true, errorBuffer, 256);
		}
		default: {
		}
	}
	if (g_hSQL)
	{
		int i = 1;
		while (i <= MaxClients)
		{
			if (IsValidClient(i, false))
			{
				OnClientPostAdminCheck(i);
				i++;
			}
			i++;
		}
		CreateDatabase();
	}
	else
	{
		CreateTimer(0,5, timer_retryConnectSQL, any 1, 0);
	}
	if (!g_hStore)
	{
		CreateTimer(0,5, timer_retryConnectSQL, any 2, 0);
	}
	if (!g_hTimer)
	{
		CreateTimer(0,5, timer_retryConnectSQL, any 3, 0);
	}
	return void 0;
}

public void UpdateMapsCompleted(int client)
{
	char SteamID[32];
	char query[128];
	GetClientAuthId(client, AuthIdType 1, SteamID, 32, true);
	Format(query, 128, "SELECT COUNT(DISTINCT map) FROM round WHERE auth = '%s'", SteamID);
	SQL_TQuery(g_hTimer, SQLTCallback 11, query, client, DBPriority 1);
	return void 0;
}

public void CountAchivements(int client)
{
	char query[256];
	char SteamID[32];
	GetClientAuthId(client, AuthIdType 1, SteamID, 32, true);
	Format(query, 256, "SELECT COUNT(cp.play_id) FROM completed_achivements as cp, players as p WHERE cp.play_id = p.id AND p.SteamID = '%s'", SteamID);
	SQL_TQuery(g_hSQL, SQLTCallback 3, query, client, DBPriority 1);
	return void 0;
}

public void CreateAchivement(char achiv_name[], char type[], int i_points, int score, int credits, int hidden)
{
	char query[512];
	Format(query, 512, "INSERT INTO achivements(name, type, points, score, credits, hidden) VALUES(\"%s\", '%s', %i, %i, %i, %i);", achiv_name, type, i_points, score, credits, hidden);
	SQL_TQuery(g_hSQL, SQLTCallback 13, query, any 17, DBPriority 1);
	return void 0;
}

public int CB_AllAchievements(Handle owner, Handle hndl, char error[], any param1)
{
	if (hndl)
	{
		Handle menu = CreateMenu(MenuHandler 65, MenuAction 28);
		SetMenuTitle(menu, "Achievements");
		char buffer[64];
		while (SQL_FetchRow(hndl))
		{
			SQL_FetchString(hndl, 0, buffer, 64, 0);
			AddMenuItem(menu, buffer, buffer, 0);
		}
		if (!(SQL_GetRowCount(hndl)))
		{
			AddMenuItem(menu, "0", "You don't have any", 1);
		}
		SetMenuExitBackButton(menu, true);
		DisplayMenu(menu, param1, 0);
		return 0;
	}
	SetFailState("Failed to connect to SQL database. Error: %s", error);
	return 0;
}

public int CB_menu_achievement(Handle owner, Handle hndl, char error[], any param1)
{
	if (hndl)
	{
		Handle menu = CreateMenu(MenuHandler 75, MenuAction 28);
		SetMenuExitBackButton(menu, true);
		SetMenuExitButton(menu, true);
		char name[64];
		char type[32];
		char buffer[128];
		while (SQL_FetchRow(hndl))
		{
			SQL_FetchString(hndl, 0, name, 64, 0);
			SQL_FetchString(hndl, 1, type, 32, 0);
			SetMenuTitle(menu, "%s", name);
			Format(buffer, 128, "Goal - %i %s", SQL_FetchInt(hndl, 3, 0), type);
			AddMenuItem(menu, "0", buffer, 1);
			Format(buffer, 128, "Achievement points - %i", SQL_FetchInt(hndl, 2, 0));
			AddMenuItem(menu, "1", buffer, 1);
			Format(buffer, 128, "Credits - %i", SQL_FetchInt(hndl, 4, 0));
			AddMenuItem(menu, "2", buffer, 1);
			Format(buffer, 128, "Hidden - %i", SQL_FetchInt(hndl, 5, 0));
			AddMenuItem(menu, "3", buffer, 1);
		}
		DisplayMenu(menu, param1, 0);
		return 0;
	}
	SetFailState("Failed to connect to SQL database. Error: %s", error);
	return 0;
}

public Action Event_Death(Handle event, char name[], bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid", 0));
	int attacker = GetEventInt(event, "attacker", 0);
	if (IsValidClient(attacker, false))
	{
		Player player2 = Player.Player(attacker);
		int var1 = player2;
		int var2 = Player.iKills.get(var1);
		var2++;
		Player.iKills.set(var1, var2);
	}
	Player player = Player.Player(client);
	int var3 = player;
	int var4 = Player.iDeaths.get(var3);
	var4++;
	Player.iDeaths.set(var3, var4);
	return Action 0;
}

public Action Event_Jump(Handle event, char name[], bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid", 0));
	Player player = Player.Player(client);
	int var1 = player;
	int var2 = Player.iJumps.get(var1);
	var2++;
	Player.iJumps.set(var1, var2);
	return Action 0;
}

public Action Event_Shoot(Handle event, char name[], bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid", 0));
	Player player = Player.Player(client);
	int var1 = player;
	int var2 = Player.iShots.get(var1);
	var2++;
	Player.iShots.set(var1, var2);
	return Action 0;
}

public Action cmd_achivement(int client, int args)
{
	AchievementMenu(client);
	return Action 0;
}

public Action cmd_addachivement(int client, int args)
{
	if (args == 6)
	{
		char achiv_name[256];
		char type[32];
		char temp[32];
		int iPoints = 0;
		int IScore = 0;
		int ICredits = 0;
		int BHidden = 0;
		GetCmdArg(1, achiv_name, 256);
		GetCmdArg(2, type, 32);
		GetCmdArg(3, temp, 32);
		iPoints = StringToInt(temp, 10);
		GetCmdArg(4, temp, 32);
		IScore = StringToInt(temp, 10);
		GetCmdArg(5, temp, 32);
		ICredits = StringToInt(temp, 10);
		GetCmdArg(6, temp, 32);
		BHidden = StringToInt(temp, 10);
		CreateAchivement(achiv_name, type, iPoints, IScore, ICredits, BHidden);
	}
	else
	{
		ReplyToCommand(client, "sm_addachivement \"achivname\" \"type\" points score credits hidden");
	}
	return Action 3;
}

public void AchievementMenu(int client)
{
	Handle menu = CreateMenu(MenuHandler 63, MenuAction 28);
	SetMenuTitle(menu, "Select option:");
	AddMenuItem(menu, "0", "All achievements", 0);
	AddMenuItem(menu, "1", "Your achievements", 0);
	AddMenuItem(menu, "2", "Achievements to complete", 0);
	AddMenuItem(menu, "3", "Stats", 0);
	DisplayMenu(menu, client, 0);
	return void 0;
}

public int menu_First(Handle menu, MenuAction action, int client, int itemNum)
{
	if (action == MenuAction 4)
	{
		char info[8];
		GetMenuItem(menu, itemNum, info, 8, 0, "", 0);
		switch (StringToInt(info, 10))
		{
			case 0: {
				menu_case0(client);
			}
			case 1: {
				menu_case1(client);
			}
			case 2: {
				menu_case2(client);
			}
			case 3: {
				menu_case3(client);
			}
			default: {
			}
		}
	}
	return 0;
}

public void menu_case0(int client)
{
	SQL_TQuery(g_hSQL, SQLTCallback 5, "SELECT achivements.name FROM achivements WHERE achivements.hidden = 0", client, DBPriority 1);
	return void 0;
}

public void menu_case1(int client)
{
	char query[256];
	char SteamID[32];
	GetClientAuthId(client, AuthIdType 1, SteamID, 32, true);
	Format(query, 256, "SELECT a.name FROM achivements a LEFT JOIN completed_achivements cp ON a.id = cp.achiv_id LEFT JOIN players p ON cp.play_id = p.id WHERE p.SteamID like '%s'", SteamID);
	SQL_TQuery(g_hSQL, SQLTCallback 5, query, client, DBPriority 1);
	return void 0;
}

public void menu_case2(int client)
{
	char query[256];
	char SteamID[32];
	GetClientAuthId(client, AuthIdType 1, SteamID, 32, true);
	Format(query, 256, "SELECT a.name FROM achivements a WHERE a.id NOT IN(SELECT a.id FROM achivements a LEFT JOIN completed_achivements cp ON a.id = cp.achiv_id LEFT JOIN players p ON cp.play_id = p.id WHERE p.SteamID = '%s') AND a.hidden = 0;", SteamID);
	SQL_TQuery(g_hSQL, SQLTCallback 5, query, client, DBPriority 1);
	return void 0;
}

public void menu_case3(int client)
{
	char buffer[128];
	Player player = Player.Player(client);
	Handle menu = CreateMenu(MenuHandler 75, MenuAction 28);
	SetMenuTitle(menu, "%N", client);
	SetMenuPagination(menu, 0);
	SetMenuExitBackButton(menu, true);
	Format(buffer, 128, "Achievement points - %i", Player.iPoints.get(player));
	AddMenuItem(menu, "0", buffer, 0);
	Format(buffer, 128, "Achievements done - %i", Player.iAchivs.get(player));
	AddMenuItem(menu, "1", buffer, 0);
	Format(buffer, 128, "Jumps - %i", Player.iJumps.get(player));
	AddMenuItem(menu, "2", buffer, 0);
	Format(buffer, 128, "Kills - %i", Player.iKills.get(player));
	AddMenuItem(menu, "3", buffer, 0);
	Format(buffer, 128, "Maps completed - %i", Player.iMaps.get(player));
	AddMenuItem(menu, "4", buffer, 0);
	Format(buffer, 128, "Deaths - %i", Player.iDeaths.get(player));
	AddMenuItem(menu, "5", buffer, 0);
	Format(buffer, 128, "Airtime - %5.2f", Player.fAirtime.get(player));
	AddMenuItem(menu, "6", buffer, 0);
	Format(buffer, 128, "Max speed - %i", Player.iSpeed.get(player));
	AddMenuItem(menu, "7", buffer, 0);
	Format(buffer, 128, "Playtime - %i hours", RoundToCeil(float(Player.iPlaytime.get(player) / 60 / 60)));
	AddMenuItem(menu, "8", buffer, 0);
	DisplayMenu(menu, client, 0);
	return void 0;
}

public int menu_achievement(Handle menu, MenuAction action, int client, int itemNum)
{
	if (action == MenuAction 4)
	{
		char achivName[64];
		char query[256];
		GetMenuItem(menu, itemNum, achivName, 64, 0, "", 0);
		Format(query, 256, "SELECT name, type, points, score, credits, hidden FROM achivements WHERE name = \"%s\"", achivName);
		SQL_TQuery(g_hSQL, SQLTCallback 15, query, client, DBPriority 1);
	}
	else
	{
		if (action == MenuAction 8)
		{
			AchievementMenu(client);
			CloseHandle(menu);
		}
	}
	return 0;
}

public int menu_useless(Handle menu, MenuAction action, int client, int itemNum)
{
	if (action == MenuAction 8)
	{
		AchievementMenu(client);
		CloseHandle(menu);
	}
	else
	{
		if (action == MenuAction 4)
		{
			char info[4];
			GetMenuItem(menu, itemNum, info, 3, 0, "", 0);
			if (StringToInt(info, 10) < 9)
			{
				AchievementMenu(client);
				CloseHandle(menu);
			}
		}
	}
	return 0;
}

int Verification()
{
	if (GetTime({0,0}) < EpochTime)
	{
		licence = 1;
	}
	else
	{
		licence = 0;
	}
	if (!licence)
	{
		Handle hPlugins = GetMyHandle();
		char sServer[244];
		GetPluginFilename(hPlugins, sServer, 244);
		ServerCommand("sm plugins unload %s", sServer);
		ServerCommand("hostname Trial period of %s is over - Contact Kasea", sServer);
	}
	return 0;
}

public void OnPluginStart()
{
	Verification();
	if (licence)
	{
		LoadTranslations("Achivements");
		HookEvent("player_death", EventHook 29, EventHookMode 1);
		HookEvent("player_shoot", EventHook 33, EventHookMode 1);
		HookEvent("player_jump", EventHook 31, EventHookMode 1);
		RegConsoleCmd("sm_achiv", cmd_achivement, "", 0);
		RegAdminCmd("sm_addachiv", cmd_addachivement, 16384, "sm_addachivement \"achivname\" \"type\" points score credits hidden", "", 0);
		CreateTimer(30, timer_CheckAchivs, any 0, 1);
		ConnectSQL(0);
	}
	return void 0;
}

public Action timer_CheckAchivs(Handle timer)
{
	int i = 1;
	while (i <= MaxClients)
	{
		if (IsValidClient(i, false))
		{
			CheckPlayer(i);
			i++;
		}
		i++;
	}
	return Action 0;
}

public void OnPluginEnd()
{
	int i = 1;
	while (i <= MaxClients)
	{
		if (IsValidClient(i, false))
		{
			OnClientDisconnect(i);
			i++;
		}
		i++;
	}
	return void 0;
}

public void OnClientPostAdminCheck(int client)
{
	g_iPlaytime[client] = GetTime({0,0});
	CreateTimer(3, timer_LoadInfo, client, 2);
	return void 0;
}

public Action timer_LoadInfo(Handle timer, any client)
{
	LoadInfo(client);
	return Action 3;
}

public void OnClientDisconnect(int client)
{
	Player player = Player.Player(client);
	Player.iPlaytime.set(player, Player.iPlaytime.get(player) + GetTime({0,0}) - g_iPlaytime[client][0][0]);
	SaveInfo(client);
	return void 0;
}

public Action OnPlayerRunCmd(int client, &int buttons, &int impulse, float vel[3], float angles[3], &int weapon, &int subtype, &int cmdnum, &int tickcount, &int seed, int mouse[2])
{
	Player player = Player.Player(client);
	float fVelocity[3];
	GetEntPropVector(client, PropType 1, "m_vecVelocity", fVelocity, 0);
	float currentspeed = SquareRoot(FloatAdd(Pow(fVelocity[0], 2), Pow(fVelocity[4], 2)));
	if (RoundToFloor(currentspeed) > Player.iSpeed.get(player))
	{
		Player.iSpeed.set(player, RoundToFloor(currentspeed));
	}
	int var1;
	if (IsClientInAir(client))
	{
		g_bAirtime[client] = 1;
		g_fAirtime[client] = GetEngineTime();
	}
	else
	{
		int var2;
		if (!IsClientInAir(client))
		{
			g_fAirtime[client] = FloatSub(GetEngineTime(), g_fAirtime[client][0][0]);
			if (__FLOAT_GT__(g_fAirtime[client][0][0], Player.fAirtime.get(player)))
			{
				Player.fAirtime.set(player, g_fAirtime[client][0][0]);
			}
			g_fAirtime[client] = 0;
			g_bAirtime[client] = 0;
		}
	}
	return Action 0;
}

