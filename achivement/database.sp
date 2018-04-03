Handle g_hSQL = INVALID_HANDLE;
Handle g_hStore = INVALID_HANDLE;
Handle g_hTimer = INVALID_HANDLE;

#define MAXACHIVEMENTS 9

//char g_cAchivements[MAXACHIVEMENTS][32] = { "achivements", "jumps", "kills", "maps", "deaths", "shots", "airtime", "speed", "playtime" };

/********************************************************************
****************************Get Info*********************************
*********************************************************************/
//loads the information into the methodmap
//done
public void LoadInfo(int client)
{
	char query[256];
	char SteamID[32];
	GetClientAuthId(client, AuthId_Steam2, SteamID, sizeof(SteamID));
	
	//we start by making sure there is a record of the client
	Format(query, sizeof(query), "INSERT IGNORE INTO players(SteamID, points, achivements, jumps, \
	kills, maps, deaths, shots, airtime, speed, playtime, name) VALUES('%s', 0, 0, 0, 0, 0, 0, 0, 0.00, 0, 0, \"%N\")", SteamID, client);
	SQL_TQuery(g_hSQL, CB_Useless, query, 0);
	
	//gets the information then we go too CB_LoadInfo
	Format(query, sizeof(query), "SELECT points, achivements, jumps, kills, maps, deaths, shots, airtime, speed, playtime FROM players WHERE SteamID = '%s'", SteamID);
	SQL_TQuery(g_hSQL, CB_LoadInfo, query, client);
}

//retrieves the information, then it sends it off to be processed and check for any new achivements
//done
public CB_LoadInfo(Handle owner, Handle hndl, char[] error, any param1)
{
	if (hndl == INVALID_HANDLE)
	{
		SetFailState("Failed to connect to SQL database. Error: %s", error);
		return;
	}
	
	Player player = Player(param1);
	
	while(SQL_FetchRow(hndl))
	{
		player.iPoints = SQL_FetchInt(hndl, 0);
		player.iAchivs = SQL_FetchInt(hndl, 1);
		player.iJumps = SQL_FetchInt(hndl, 2);
		player.iKills = SQL_FetchInt(hndl, 3);
		player.iMaps = SQL_FetchInt(hndl, 4);
		player.iDeaths = SQL_FetchInt(hndl, 5);
		player.iShots = SQL_FetchInt(hndl, 6);
		player.fAirtime = SQL_FetchFloat(hndl, 7);
		player.iSpeed = SQL_FetchInt(hndl, 8);
		player.iPlaytime = SQL_FetchInt(hndl, 9);
	}
	CountAchivements(param1);
	UpdateMapsCompleted(param1);
}

/********************************************************************
****************************Save Info********************************
*********************************************************************/
//saves the info of a client into the database
//Consider changing the way it's sendt to database! TODO: done for now tho
public void SaveInfo(int client)
{
	Player player = Player(client);
	char query[256];
	char SteamID[32];
	GetClientAuthId(client, AuthId_Steam2, SteamID, sizeof(SteamID));
	
	Format(query, sizeof(query), "UPDATE players SET name = \"%N\" WHERE SteamID = '%s'", client, SteamID);
	SQL_TQuery(g_hSQL, CB_Useless, query, 1);
	
	Format(query, sizeof(query), "UPDATE players SET points = %i WHERE SteamID = '%s'", player.iPoints, SteamID);
	SQL_TQuery(g_hSQL, CB_Useless, query, 2);
	
	Format(query, sizeof(query), "UPDATE players SET achivements = %i WHERE SteamID = '%s'", player.iAchivs, SteamID);
	SQL_TQuery(g_hSQL, CB_Useless, query, 3);
	
	Format(query, sizeof(query), "UPDATE players SET jumps = %i WHERE SteamID = '%s'", player.iJumps, SteamID);
	SQL_TQuery(g_hSQL, CB_Useless, query, 4);
	
	Format(query, sizeof(query), "UPDATE players SET kills = %i WHERE SteamID = '%s'", player.iKills, SteamID);
	SQL_TQuery(g_hSQL, CB_Useless, query, 5);
	
	Format(query, sizeof(query), "UPDATE players SET maps = %i WHERE SteamID = '%s'", player.iMaps, SteamID);
	SQL_TQuery(g_hSQL, CB_Useless, query, 6);
	
	Format(query, sizeof(query), "UPDATE players SET deaths = %i WHERE SteamID = '%s'", player.iDeaths, SteamID);
	SQL_TQuery(g_hSQL, CB_Useless, query, 7);
	
	Format(query, sizeof(query), "UPDATE players SET shots = %i WHERE SteamID = '%s'", player.iShots, SteamID);
	SQL_TQuery(g_hSQL, CB_Useless, query, 8);
	
	Format(query, sizeof(query), "UPDATE players SET airtime = %f WHERE SteamID = '%s'", player.fAirtime, SteamID);
	SQL_TQuery(g_hSQL, CB_Useless, query, 9);
	
	Format(query, sizeof(query), "UPDATE players SET speed = %i WHERE SteamID = '%s'", player.iSpeed, SteamID);
	SQL_TQuery(g_hSQL, CB_Useless, query, 10);
	
	Format(query, sizeof(query), "UPDATE players SET playtime = %i WHERE SteamID = '%s'", player.iPlaytime, SteamID);
	SQL_TQuery(g_hSQL, CB_Useless, query, 11);
}

/********************************************************************
**********************Check for achivements**************************
*********************************************************************/
//Gets all the achivements and sends then over to txn_CheckPlayer where it adds them into the completed_achivements table if their new.
public void CheckPlayer(int client)
{
	char SteamID[32], query[512];
	GetClientAuthId(client, AuthId_Steam2, SteamID, 32);
	//lets fuck this database up son!
	Handle SQL_Transaction = SQL_CreateTransaction();
	Player player = Player(client);
	//das queries Keepo
	Format(query, sizeof(query), "SELECT a.id as AchivID, p.id as PlayID FROM achivements a, players p WHERE NOT EXISTS(SELECT 1 FROM completed_achivements WHERE completed_achivements.achiv_id = a.id AND completed_achivements.play_id = p.id) AND p.SteamID = '%s' \
	AND a.type = 'points' \
	AND a.score<=p.%i;", SteamID, player.iPoints);
	SQL_AddQuery(SQL_Transaction, query);
	
	Format(query, sizeof(query), "SELECT a.id as AchivID, p.id as PlayID FROM achivements a, players p WHERE NOT EXISTS(SELECT 1 FROM completed_achivements WHERE completed_achivements.achiv_id = a.id AND completed_achivements.play_id = p.id) AND p.SteamID = '%s' \
	AND a.type = 'achivements' \
	AND a.score<=p.%i;", SteamID, player.iAchivs);
	SQL_AddQuery(SQL_Transaction, query);
	
	Format(query, sizeof(query), "SELECT a.id as AchivID, p.id as PlayID FROM achivements a, players p WHERE NOT EXISTS(SELECT 1 FROM completed_achivements WHERE completed_achivements.achiv_id = a.id AND completed_achivements.play_id = p.id) AND p.SteamID = '%s' \
	AND a.type = 'jumps' \
	AND a.score<=p.%i;", SteamID, player.iJumps);
	SQL_AddQuery(SQL_Transaction, query);
	
	Format(query, sizeof(query), "SELECT a.id as AchivID, p.id as PlayID FROM achivements a, players p WHERE NOT EXISTS(SELECT 1 FROM completed_achivements WHERE completed_achivements.achiv_id = a.id AND completed_achivements.play_id = p.id) AND p.SteamID = '%s' \
	AND a.type = 'kills' \
	AND a.score<=p.%i;", SteamID, player.iKills);
	SQL_AddQuery(SQL_Transaction, query);
	
	Format(query, sizeof(query), "SELECT a.id as AchivID, p.id as PlayID FROM achivements a, players p WHERE NOT EXISTS(SELECT 1 FROM completed_achivements WHERE completed_achivements.achiv_id = a.id AND completed_achivements.play_id = p.id) AND p.SteamID = '%s' \
	AND a.type = 'maps' \
	AND a.score<=p.%i;", SteamID, player.iAchivs);
	SQL_AddQuery(SQL_Transaction, query);
	
	Format(query, sizeof(query), "SELECT a.id as AchivID, p.id as PlayID FROM achivements a, players p WHERE NOT EXISTS(SELECT 1 FROM completed_achivements WHERE completed_achivements.achiv_id = a.id AND completed_achivements.play_id = p.id) AND p.SteamID = '%s' \
	AND a.type = 'deaths' \
	AND a.score<=p.%i;", SteamID, player.iDeaths);
	SQL_AddQuery(SQL_Transaction, query);
	
	Format(query, sizeof(query), "SELECT a.id as AchivID, p.id as PlayID FROM achivements a, players p WHERE NOT EXISTS(SELECT 1 FROM completed_achivements WHERE completed_achivements.achiv_id = a.id AND completed_achivements.play_id = p.id) AND p.SteamID = '%s' \
	AND a.type = 'shots' \
	AND a.score<=p.%i;", SteamID, player.iShots);
	SQL_AddQuery(SQL_Transaction, query);
	
	Format(query, sizeof(query), "SELECT a.id as AchivID, p.id as PlayID FROM achivements a, players p WHERE NOT EXISTS(SELECT 1 FROM completed_achivements WHERE completed_achivements.achiv_id = a.id AND completed_achivements.play_id = p.id) AND p.SteamID = '%s' \
	AND a.type = 'airtime' \
	AND a.score<=p.%f;", SteamID, player.fAirtime);
	SQL_AddQuery(SQL_Transaction, query);
	
	Format(query, sizeof(query), "SELECT a.id as AchivID, p.id as PlayID FROM achivements a, players p WHERE NOT EXISTS(SELECT 1 FROM completed_achivements WHERE completed_achivements.achiv_id = a.id AND completed_achivements.play_id = p.id) AND p.SteamID = '%s' \
	AND a.type = 'speed' \
	AND a.score<=p.%i;", SteamID, player.iSpeed);
	SQL_AddQuery(SQL_Transaction, query);
	
	Format(query, sizeof(query), "SELECT a.id as AchivID, p.id as PlayID FROM achivements a, players p WHERE NOT EXISTS(SELECT 1 FROM completed_achivements WHERE completed_achivements.achiv_id = a.id AND completed_achivements.play_id = p.id) AND p.SteamID = '%s' \
	AND a.type = 'playtime' \
	AND a.score<=p.%i;", SteamID, player.iPlaytime);
	SQL_AddQuery(SQL_Transaction, query);
	//oi time 2 execute all dese queries boi!
	SQL_ExecuteTransaction(g_hSQL, SQL_Transaction, txn_CheckPlayer, _, client, DBPrio_Normal);
}

public txn_CheckPlayer(Handle db, any client, int numQueries, Handle[] hndl, any[] queryData)
{
	if(!IsValidClient(client))
		return;
	char query[256];
	for(int i = 0; i < numQueries; i++)
	{
		if(hndl[i] == INVALID_HANDLE)
		{
			SetFailState("Failed during the txn_CheckPlayer at the count %i", i);
			return;
		}
		while(SQL_FetchRow(hndl[i]))
		{
			Format(query, sizeof(query), "INSERT INTO completed_achivements(achiv_id, play_id) VALUES(%i, %i);", SQL_FetchInt(hndl[i], 0), SQL_FetchInt(hndl[i], 1));
			GotAchivement(client, SQL_FetchInt(hndl[i], 0));
			SQL_TQuery(g_hSQL, CB_Useless, query, 12);
		}
	}
}

/********************************************************************
************************Got Achivement*******************************
*********************************************************************/
//client has finished an achivement - done
public void GotAchivement(int client, int achivementId)
{
	char query[256];
	Format(query, sizeof(query), "SELECT name, points, credits FROM achivements WHERE id = %i", achivementId);
	SQL_TQuery(g_hSQL, CB_GotAchivement, query, client);
}
//done
public CB_GotAchivement(Handle owner, Handle hndl, char[] error, any client)
{
	if(!IsValidClient(client))
		return;
	if (hndl == INVALID_HANDLE)
	{
		SetFailState("Failed to connect to SQL database. Error: %s", error);
		return;
	}
	Player player = Player(client);
	char achiv[64], SteamID[32];
	GetClientAuthId(client, AuthId_Steam2, SteamID, 32);
	while(SQL_FetchRow(hndl))
	{
		SQL_FetchString(hndl, 0, achiv, sizeof(achiv));
		CPrintToChatAll("%t", "Got Achivement", client, achiv);
		player.iPoints += SQL_FetchInt(hndl, 1);
		GiveCredits(SteamID, SQL_FetchInt(hndl, 2));
	}
}
/********************************************************************
***************************Callbacks*********************************
*********************************************************************/
//done
public CB_Maps(Handle owner, Handle hndl, char[] error, any param1)
{
	if (hndl == INVALID_HANDLE)
	{
		SetFailState("Failed to connect to SQL database. Error: %s", error);
		return;
	}
	
	Player player = Player(param1);
	while(SQL_FetchRow(hndl))
		player.iMaps = SQL_FetchInt(hndl, 0);
	
}
public CB_AchivementCount(Handle owner, Handle hndl, char[] error, any param1)
{
	if (hndl == INVALID_HANDLE)
	{
		SetFailState("Failed to connect to SQL database. Error: %s", error);
		return;
	}
	Player player = Player(param1);
	while(SQL_FetchRow(hndl))
		player.iAchivs = SQL_FetchInt(hndl, 0);
		//Format(query, 128, "UPDATE players SET achivements = %i WHERE players.SteamID = '%s'", SQL_FetchInt(hndl, 0), SteamID);
}

public CB_Useless(Handle owner, Handle hndl, char[] error, any param1)
{
	if (hndl == INVALID_HANDLE)
	{
		SetFailState("Failed to connect to SQL database. Error: %s | Param1 = %i", error, param1);
		return;
	}
}
/********************************************************************
****************************Databases********************************
*********************************************************************/
public void CreateDatabase()
{
	SQL_TQuery(g_hSQL, CB_Useless, "CREATE TABLE IF NOT EXISTS `players` ( \
  `id` int(11) NOT NULL AUTO_INCREMENT, \
  `SteamID` varchar(32) DEFAULT NULL, \
  `name` varchar(32) NOT NULL, \
  `points` int(11) NOT NULL, \
  `achivements` int(11) NOT NULL, \
  `jumps` int(11) NOT NULL, \
  `kills` int(11) NOT NULL, \
  `maps` int(11) NOT NULL, \
  `deaths` int(11) NOT NULL, \
  `shots` int(11) NOT NULL, \
  `airtime` float(9,2) NOT NULL, \
  `speed` int(12) NOT NULL, \
  `playtime` int(32) NOT NULL, \
  PRIMARY KEY (`id`), UNIQUE KEY `SteamID` (`SteamID`))", 13);
  SQL_TQuery(g_hSQL, CB_Useless, "CREATE TABLE IF NOT EXISTS `completed_achivements` ( \
  `achiv_id` int(11) NOT NULL, \
  `play_id` int(11) NOT NULL, \
  PRIMARY KEY(`achiv_id`, `play_id`));", 14);
  SQL_TQuery(g_hSQL, CB_Useless, "CREATE TABLE IF NOT EXISTS `achivements` ( \
  `id` int(11) NOT NULL AUTO_INCREMENT, \
  `name` varchar(128) NOT NULL, \
  `type` varchar(32) DEFAULT 'temp', \
  `points` int(11) NOT NULL DEFAULT '0', \
  `score` int(11) NOT NULL DEFAULT '0', \
  `credits` int(11) NOT NULL DEFAULT '0', \
  `hidden` tinyint(1) NOT NULL DEFAULT '0', \
  PRIMARY KEY (`id`,`name`))", 15);
}

//give a person credits -- done
public GiveCredits(char[] t_steamid, int amount)
{
	char steamid[32], query[256];
	StringSubString(t_steamid, 8, 32, steamid, sizeof(steamid));
	Format(query, sizeof(query), "UPDATE store_players SET store_players.credits = (store_players.credits + %i) WHERE store_players.authid = '%s';", amount, steamid);
	SQL_TQuery(g_hStore, CB_Useless, query, 16);
}
public Handle GetSQL()
{
	return g_hSQL;
}

public Action timer_retryConnectSQL(Handle timer, any data)
{
	ConnectSQL(data);
	return Plugin_Stop;
}

public void ConnectSQL(int DB)
{
	char errorBuffer[256];
	if(!SQL_CheckConfig("achievement") || !SQL_CheckConfig("store") || !SQL_CheckConfig("timer"))
		LogError("Achievement error: Your a retard, make the databases achievement, store and timer");
	switch(DB)
	{
		case 0:
		{
			//first time
			g_hSQL = SQL_Connect("achievement", true, errorBuffer, sizeof(errorBuffer));
			g_hStore = SQL_Connect("store", true, errorBuffer, sizeof(errorBuffer));
			g_hTimer = SQL_Connect("timer", true, errorBuffer, sizeof(errorBuffer));
		}
		case 1:
		{
			//g_hSQL
			if(g_hSQL != INVALID_HANDLE)
				CloseHandle(g_hSQL);
			g_hSQL = INVALID_HANDLE;
			g_hSQL = SQL_Connect("achievement", true, errorBuffer, sizeof(errorBuffer));
		}
		case 2:
		{
			//g_hStore
			if(g_hStore != INVALID_HANDLE)
				CloseHandle(g_hStore);
			g_hStore = INVALID_HANDLE;
			g_hStore = SQL_Connect("store", true, errorBuffer, sizeof(errorBuffer));
		}
		case 3:
		{
			//g_hTimer
			if(g_hTimer != INVALID_HANDLE)
				CloseHandle(g_hTimer);
			g_hTimer = INVALID_HANDLE;
			g_hTimer = SQL_Connect("timer", true, errorBuffer, sizeof(errorBuffer));
		}
	}	
	if(g_hSQL == INVALID_HANDLE)
		CreateTimer(0.5, timer_retryConnectSQL, 1);
	else
	{
		LoopValidClients(i){
			OnClientPostAdminCheck(i);
		}
		CreateDatabase();
	}
	if(g_hStore == INVALID_HANDLE)
		CreateTimer(0.5, timer_retryConnectSQL, 2);
	if(g_hTimer == INVALID_HANDLE)
		CreateTimer(0.5, timer_retryConnectSQL, 3);
}
/********************************************************************
************************Achivement score*****************************
*********************************************************************/
//Going to update the local maps completed variable for the client. This is going to be saved when the client leaves.
public void UpdateMapsCompleted(int client)
{
	char SteamID[32], query[128];
	GetClientAuthId(client, AuthId_SteamID64, SteamID, 32);
	Format(query, sizeof(query), "SELECT COUNT(DISTINCT map) FROM playertimes WHERE auth = '%s'", SteamID);
	SQL_TQuery(g_hTimer, CB_Maps, query, client);
}

public void CountAchivements(int client)
{
	char query[256], SteamID[32];
	GetClientAuthId(client, AuthId_Steam2, SteamID, 32);
	Format(query, sizeof(query), "SELECT COUNT(cp.play_id) FROM completed_achivements as cp, players as p WHERE cp.play_id = p.id AND p.SteamID = '%s'", SteamID);
	SQL_TQuery(g_hSQL, CB_AchivementCount, query, client);
}

/********************************************************************
************************ Add Achivement *****************************
*********************************************************************/
public void CreateAchivement(char[] achiv_name, char[] type, int i_points, int score, int credits, int hidden)
{
	char query[512];
	Format(query, sizeof(query), "INSERT INTO achivements(name, type, points, score, credits, hidden) VALUES(\"%s\", '%s', %i, %i, %i, %i);", achiv_name, type, i_points, score, credits, hidden);
	SQL_TQuery(g_hSQL, CB_Useless, query, 17);
}

/********************************************************************/
/***************************** MENU *********************************/
/********************************************************************/
public CB_AllAchievements(Handle owner, Handle hndl, char[] error, any param1)
{
	if (hndl == INVALID_HANDLE)
	{
		SetFailState("Failed to connect to SQL database. Error: %s", error);
		return;
	}
	Handle menu = CreateMenu(menu_achievement);
	SetMenuTitle(menu, "Achievements");
	char buffer[64];
	while(SQL_FetchRow(hndl))
	{
		SQL_FetchString(hndl, 0, buffer, 64);
		AddMenuItem(menu, buffer, buffer);
	}
	if(SQL_GetRowCount(hndl) ==  0)
		AddMenuItem(menu, "0", "You don't have any", ITEMDRAW_DISABLED);
	SetMenuExitBackButton(menu, true);
	DisplayMenu(menu, param1, 0);
}

public CB_menu_achievement(Handle owner, Handle hndl, char[] error, any param1)
{
	if (hndl == INVALID_HANDLE)
	{
		SetFailState("Failed to connect to SQL database. Error: %s", error);
		return;
	}
	Handle menu = CreateMenu(menu_useless);
	SetMenuExitBackButton(menu, true);
	SetMenuExitButton(menu, true);
	char name[64], type[32], buffer[128];
	while(SQL_FetchRow(hndl))
	{
		SQL_FetchString(hndl, 0, name, sizeof(name));
		SQL_FetchString(hndl, 1, type, sizeof(type));
		SetMenuTitle(menu, "%s", name);
		Format(buffer, sizeof(buffer), "Goal - %i %s", SQL_FetchInt(hndl, 3), type);
		AddMenuItem(menu, "0", buffer, ITEMDRAW_DISABLED);
		Format(buffer, sizeof(buffer), "Achievement points - %i", SQL_FetchInt(hndl, 2));
		AddMenuItem(menu, "1", buffer, ITEMDRAW_DISABLED);
		Format(buffer, sizeof(buffer), "Credits - %i", SQL_FetchInt(hndl, 4));
		AddMenuItem(menu, "2", buffer, ITEMDRAW_DISABLED);
		Format(buffer, sizeof(buffer), "Hidden - %i", SQL_FetchInt(hndl, 5));
		AddMenuItem(menu, "3", buffer, ITEMDRAW_DISABLED);
	}
	DisplayMenu(menu, param1, 0);
}