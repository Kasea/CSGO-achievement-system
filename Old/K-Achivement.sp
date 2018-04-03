#pragma semicolon 1

#define PLUGIN_AUTHOR "Kasea"
#define PLUGIN_VERSION "1.0.0"

#include <sourcemod>
#include <sdktools>
#include "achivements/config.sp"
#include "achivements/database.sp"
#include "achivements/menu.sp"
#include "achivements/commands.sp"

public Plugin myinfo = 
{
	name = "Achivement system",
	author = PLUGIN_AUTHOR,
	description = "",
	version = PLUGIN_VERSION,
	url = ""
};

enum Player
{
	String:steam[32],
	points,
	completed
}

int g_nPlayer[MAXPLAYERS+1][Player];

public void OnPluginStart()
{
	RegConsoleCmd("sm_achivement", cmd_achivement);
	LoadTranslations("Achivements");
	//LoadTranslations("");
	ConnectSQL();
}
