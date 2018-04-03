/*
TODO:
Finish the CheckPlayer function - Checks if the player has gotten any new achivements[X]
Create a function that is called upon new achivement - print to chat[X]
Create events for jumps, kills, deaths and shots[X]
Create a way for it to count the maps finished[X]
Create sm_achivement menu
Create sm_addachivement menu aswell as command
Add the following achivement settings: airtime, speed, playtime[X]
Create a way for it to count the amount of achivements we've got(would have to be after the map thing, but before the checker)[X]
*/

/*
adding more achivements checklist:
update enum + methodmap
have a way to get the score(how much of x type)
update the database(the actual one)
update the get queries(database.LoadInfo)
update the set queries(database.SaveInfo)
lastly update checkplayer function in database
*/
#pragma semicolon 1
#pragma dynamic 131072

#define PLUGIN_AUTHOR "Kasea"
#define PLUGIN_VERSION "1.0.0"

#include <achivements>
#include "achivement/database.sp"
#include "achivement/events.sp"
#include "achivement/commands.sp"
#include "achivement/menus.sp"
#include <sourcemod>
#include <sdktools>
#include <security_k>

int g_iPlaytime[MAXPLAYERS+1];
float g_fAirtime[MAXPLAYERS + 1];
bool g_bAirtime[MAXPLAYERS + 1];

public Plugin myinfo = 
{
	name = "Achivement",
	author = PLUGIN_AUTHOR,
	description = "",
	version = PLUGIN_VERSION,
	url = ""
};

public void OnPluginStart()
{
	Verification();
	if(licence)
	{
		LoadTranslations("Achivements");
		//whoop ur a good guy ;) Keepo
		HookEvent("player_death", Event_Death);
		HookEvent("player_shoot", Event_Shoot);
		HookEvent("player_jump", Event_Jump);
		RegConsoleCmd("sm_achiv", cmd_achivement);
		RegAdminCmd("sm_addachiv", cmd_addachivement, ADMFLAG_ROOT, "sm_addachivement \"achivname\" \"type\" points score credits hidden");
		CreateTimer(30.0, timer_CheckAchivs, _, TIMER_REPEAT);
		ConnectSQL(0);
	}
}

public Action timer_CheckAchivs(Handle timer)
{
	LoopValidClients(i)
		CheckPlayer(i);
}

//incase the plugin shutsdown by accident we want to save the information
public void OnPluginEnd()
{
	LoopValidClients(i){
		OnClientDisconnect(i);
	}
}

//load the information about the client
public OnClientPostAdminCheck(int client)
{
	//CheckPlayer(client);
	g_iPlaytime[client] = GetTime();
	CreateTimer(3.0, timer_LoadInfo, client, TIMER_FLAG_NO_MAPCHANGE);
}

public Action timer_LoadInfo(Handle timer, any client)
{
	LoadInfo(client);
	return Plugin_Handled;
}

//save the information about the client
public OnClientDisconnect(int client)
{
	Player player = Player(client);
	player.iPlaytime = GetTime()-g_iPlaytime[client]+player.iPlaytime;
	SaveInfo(client);
}

/********************************************************************
************************Achivement score*****************************
*********************************************************************/
public Action OnPlayerRunCmd(int client, int &buttons, int &impulse, float vel[3], float angles[3], int &weapon, int &subtype, int &cmdnum, int &tickcount, int &seed, int mouse[2])
{
	Player player = Player(client);
	//speed
	float fVelocity[3];
	GetEntPropVector(client, Prop_Data, "m_vecVelocity", fVelocity); //velocity
	float currentspeed = SquareRoot(Pow(fVelocity[0],2.0)+Pow(fVelocity[1],2.0)); //player speed (units per secound)
	if(player.iSpeed<RoundToFloor(currentspeed))
		player.iSpeed = RoundToFloor(currentspeed);
	if(IsClientInAir(client) && !g_bAirtime[client])
	{
		//the client is in the air AND the counter hasn't started
		g_bAirtime[client] = true;
		g_fAirtime[client] = GetEngineTime();
	}else if((!IsClientInAir(client) && g_bAirtime[client]) || (!IsPlayerAlive(client) && g_bAirtime[client]))
	{
		g_fAirtime[client] = GetEngineTime()-g_fAirtime[client];
		//the client isn't in the air and the counter has started
		if(g_fAirtime[client]>player.fAirtime)
			player.fAirtime = g_fAirtime[client];
		g_fAirtime[client] = 0.0;
		g_bAirtime[client] = false;
	}
}