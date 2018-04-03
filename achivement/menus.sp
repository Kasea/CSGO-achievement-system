public void AchievementMenu(int client)
{
	//display the achiv menu 2 client
	Handle menu = CreateMenu(menu_First);
	SetMenuTitle(menu, "Select option:");
	AddMenuItem(menu, "0", "All achievements");
	AddMenuItem(menu, "1", "Your achievements");
	AddMenuItem(menu, "2", "Achievements to complete");
	AddMenuItem(menu, "3", "Stats");
	DisplayMenu(menu, client, 0);
}

public menu_First(Handle menu, MenuAction action, int client, int itemNum)
{
	if (action == MenuAction_Select)
	{
		char info[8];
		GetMenuItem(menu, itemNum, info, sizeof(info));

		switch(StringToInt(info))
		{
			case 0:
			{
				menu_case0(client);
			}
			case 1:
			{
				menu_case1(client);
			}
			case 2:
			{
				menu_case2(client);
			}
			case 3:
			{
				/*char SteamId[32], query[256];
				GetClientAuthId(client, AuthId_Steam2, SteamId, 32);
				Format(query, sizeof(query), "SELECT points, achivements, jumps, kills, maps, deaths, airtime, speed, playtime FROM players WHERE SteamID = '%s'", SteamId);
				SQL_TQuery(g_hSQL, CB_DisplayClient, query, client);*/
				menu_case3(client);
			}
		}
	}
}

public void menu_case0(int client)
{
	SQL_TQuery(g_hSQL, CB_AllAchievements, "SELECT achivements.name FROM achivements WHERE achivements.hidden = 0", client);
}

public void menu_case1(int client)
{
	char query[256], SteamID[32];
	GetClientAuthId(client, AuthId_Steam2, SteamID, 32);
	Format(query, sizeof(query), "SELECT a.name FROM achivements a LEFT JOIN completed_achivements cp ON a.id = cp.achiv_id LEFT JOIN players p ON cp.play_id = p.id WHERE p.SteamID like '%s'", SteamID);
	SQL_TQuery(g_hSQL, CB_AllAchievements, query, client);
}

public void menu_case2(int client)
{
	char query[256], SteamID[32];
	GetClientAuthId(client, AuthId_Steam2, SteamID, 32);
	Format(query, sizeof(query), "SELECT a.name FROM achivements a WHERE a.id NOT IN(SELECT a.id FROM achivements a \ 
	LEFT JOIN completed_achivements cp ON a.id = cp.achiv_id LEFT JOIN players p ON cp.play_id = p.id WHERE p.SteamID = '%s') AND a.hidden = 0;", SteamID);
	SQL_TQuery(g_hSQL, CB_AllAchievements, query, client);
}

public void menu_case3(int client)
{
	char buffer[128];
	Player player = Player(client);
	Handle menu = CreateMenu(menu_useless);
	SetMenuTitle(menu, "%N", client);
	SetMenuPagination(menu, MENU_NO_PAGINATION);
	SetMenuExitBackButton(menu, true);
	
	Format(buffer, sizeof(buffer), "Achievement points - %i", player.iPoints);
	AddMenuItem(menu, "0", buffer);	
	Format(buffer, sizeof(buffer), "Achievements done - %i", player.iAchivs);
	AddMenuItem(menu, "1", buffer);	
	Format(buffer, sizeof(buffer), "Jumps - %i", player.iJumps);
	AddMenuItem(menu, "2", buffer);	
	Format(buffer, sizeof(buffer), "Kills - %i", player.iKills);
	AddMenuItem(menu, "3", buffer);	
	Format(buffer, sizeof(buffer), "Maps completed - %i", player.iMaps);
	AddMenuItem(menu, "4", buffer);	
	Format(buffer, sizeof(buffer), "Deaths - %i", player.iDeaths);
	AddMenuItem(menu, "5", buffer);	
	Format(buffer, sizeof(buffer), "Airtime - %5.2f", player.fAirtime);
	AddMenuItem(menu, "6", buffer);	
	Format(buffer, sizeof(buffer), "Max speed - %i", player.iSpeed);
	AddMenuItem(menu, "7", buffer);
	Format(buffer, sizeof(buffer), "Playtime - %i hours", RoundToCeil(float(player.iPlaytime/60/60)));
	AddMenuItem(menu, "8", buffer);
	DisplayMenu(menu, client, 0);
}

/********************************************************************/
/*********************** Display Achievement ************************/
/********************************************************************/
public menu_achievement(Handle menu, MenuAction action, int client, int itemNum)
{
	if (action == MenuAction_Select)
	{
		char achivName[64], query[256];
		GetMenuItem(menu, itemNum, achivName, sizeof(achivName));
		Format(query, sizeof(query), "SELECT name, type, points, score, credits, hidden FROM achivements WHERE name = \"%s\"", achivName);
		SQL_TQuery(g_hSQL, CB_menu_achievement, query, client);
	}else if(action == MenuAction_Cancel)
	{
		AchievementMenu(client);
		CloseHandle(menu);
	}
}

public menu_useless(Handle menu, MenuAction action, int client, int itemNum)
{
	if(action == MenuAction_Cancel)
	{
		AchievementMenu(client);
		CloseHandle(menu);
	}else if(action == MenuAction_Select)
	{
		char info[3];
		GetMenuItem(menu, itemNum, info, 3);
		if(9>StringToInt(info))
		{
			AchievementMenu(client);
			CloseHandle(menu);
		}
	}
}
