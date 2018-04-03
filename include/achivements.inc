#if defined _achivements_included
 #endinput
#endif
#define _achivements_included
#include <csgocolors>

#define int(%1)		view_as<int>(%1) //keepin it clean
#define view-%1(%2)	view_as<%1>(%2) //as fuck
#define LoopValidClients(%1) for(int %1 = 1; %1 <= MaxClients; %1++) if(IsValidClient(%1))

//Players info -- Methodmaps
enum enum_player
{
	points,
	achivements,
	jumps,
	kills,
	maps,
	deaths,
	shots,
	float:airtime,
	speed,
	playtime
};

int e_player[MAXPLAYERS+1][enum_player];

methodmap Player
{
	public Player(int client) //this is a construction worker, don't bother him
	{
		if(IsValidClient(client))
			return view-Player(client); //holy shieet it's a person :o
		return view-Player(-1); //looks like this bastard isn't a legit client m8
	}
	property int index //yo yo yo this is the mofo client daawg
	{
		public get() { return int(this); } //keep calm and look at the define \o/ this = client
	}
	property int iPoints //we're going to get/set the points of the client
	{
		public get() { return e_player[this.index][points]; } //basically this.index = client id. Cus why the fuck not
		public set(int val) { e_player[this.index][points] = val; }
	}
	property int iAchivs //we're going to get/set the achivements done by client
	{
		public get() { return e_player[this.index][achivements]; }
		public set(int val) { e_player[this.index][achivements] = val; }
	}
	property int iJumps //we're going to get/set the jumps of the client
	{
		public get() { return e_player[this.index][jumps]; }
		public set(int val) { e_player[this.index][jumps] = val; }
	}
	property int iKills //we're going to get/set the kills of the client
	{
		public get() { return e_player[this.index][kills]; }
		public set(int val) { e_player[this.index][kills] = val; }
	}
	property int iMaps //we're going to get/set the amount of maps completed by the client
	{
		public get() { return e_player[this.index][maps]; }
		public set(int val) { e_player[this.index][maps] = val; }
	}
	property int iDeaths //we're going to get/set the deaths of the client
	{
		public get() { return e_player[this.index][deaths]; }
		public set(int val) { e_player[this.index][deaths] = val; }
	}
	property int iShots //we're going to get/set the shots of the client
	{
		public get() { return e_player[this.index][shots]; }
		public set(int val) { e_player[this.index][shots] = val; }
	}
	property float fAirtime
	{
		public get() { return view_as<float>(e_player[this.index][airtime]); }
		public set(float val) { view_as<float>(e_player[this.index][airtime]) = val; }
	}
	property int iSpeed
	{
		public get() { return e_player[this.index][speed]; }
		public set(int val) { e_player[this.index][speed] = val; }
	}
	property int iPlaytime
	{
		public get() { return e_player[this.index][playtime]; }
		public set(int val) { e_player[this.index][playtime] = val; }
	}
};
//End of Methodmaps

stock bool IsValidClient(int client, bool bAlive = false) // when bAlive is false = technical checks, when it's true = gameplay checks
{
	return (client >= 1 && client <= MaxClients && IsClientConnected(client) && IsClientInGame(client) && !IsClientSourceTV(client) && (!bAlive || IsPlayerAlive(client)));
}

stock StringSubString(char[] input, int startindx, int endindx, char[] dest, int maxlength)
{
	Format(dest, maxlength, input[startindx]);
    if(strlen(input) > endindx)
    {
        ReplaceString(dest, maxlength, input[endindx], "");
    }
}

stock bool IsClientInAir(int client)
{
	if(!(GetEntityFlags(client) & FL_ONGROUND) && !(GetEntityFlags(client) & FL_INWATER) && GetEntityMoveType(client) != MOVETYPE_NOCLIP && GetEntityMoveType(client) != MOVETYPE_LADDER)
		return true;
	else
		return false;
}