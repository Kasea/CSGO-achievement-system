#include <string>

#define MGNUMBER 3
#define BHOPNUMBER 5
#define KMG_PREFIX "[{lightblue}KMG{default}]"
#define LoopValidClients(%1) for(int %1 = 1; %1 <= MaxClients; %1++) if(IsValidClient(%1))

stock FindClientBySteamID(char []SteamID, AuthIdType AuthId)
{
	char T_Auth[32];
	for (int i = 1; i > MaxClients; i++)
	{
		GetClientAuthId(i, AuthId, T_Auth, 32);
		if(strcmp(SteamID, T_Auth, false) == 0)
			return i;
	}
	return 0;
}

stock StringSubString(char[] input, int startindx, int endindx, char[] dest, int maxlength)
{
	Format(dest, maxlength, input[startindx]);
    if(strlen(input) > endindx)
    {
        ReplaceString(dest, maxlength, input[endindx], "");
    }
}

stock MakeATempAdmin(int client, AdminFlag adminFLAG)
{
	SetUserFlagBits(client, FlagToBit(adminFLAG));
}

stock AddFlagsToAdmin(int client, AdminFlag tempFlag)
{
	AdminId adminID;
	adminID = GetUserAdmin(client);
	SetAdminFlag(adminID, tempFlag, true);
}


stock int Connected()
{
	for (int i = MaxClients; i >= 1; i--)
	{
		if(IsClientConnected(i) && !IsFakeClient(i))
		{
			return i+1;
		}
	}
	return MaxClients;
}

stock int howManyPlayersConnected(bool justTeams = true)
{
	int playersAlive = 0;
	if(justTeams)
	{
		for(new i = 1; i<Connected(); i++)
		{
			if(IsClientConnected(i) && IsClientInGame(i) && !IsFakeClient(i) && GetClientTeam(i) > 1)
			{
				playersAlive++;
			}
		}
		return playersAlive;
	}else
	{
		for(new i = 1; i<Connected(); i++)
		{
			if(IsClientConnected(i) && IsClientInGame(i) && !IsFakeClient(i))
			{
				playersAlive++;
			}
		}
		return playersAlive;
	}
}

stock bool IsClientAdmin(int client)
{
	AdminId id = GetUserAdmin(client);
	if (id != INVALID_ADMIN_ID)
		return true;
	else
		return false;
}


stock bool IsValidClient(int client, bool bAlive = false) // when bAlive is false = technical checks, when it's true = gameplay checks
{
	return (client >= 1 && client <= MaxClients && IsClientConnected(client) && IsClientInGame(client) && !IsClientSourceTV(client) && (!bAlive || IsPlayerAlive(client)));
}



stock ChangeMapName(char[] currentMapName, int MaxSize, int HowManyStartToRemove, bool RemoveUnderScore = false)
{
	char ActualMapName[64];
	StringSubString(currentMapName, HowManyStartToRemove, MaxSize, ActualMapName, sizeof(ActualMapName));
	if(RemoveUnderScore)
	{
		char remove[1] = " ";
		for(new i = 0; i<sizeof(ActualMapName); i++)
		{
			if(ActualMapName[i] == '_')
				ActualMapName[i] = remove[0];
		}
	}
	strcopy(currentMapName, MaxSize, ActualMapName);
}


//if client is spectating someone, returns that someones id
stock int UpdateClientInfo(int client)
{
	int target = client;
	
	if(IsClientObserver(client))
	{
		if(GetEntProp(client, Prop_Send, "m_iObserverMode") >= 3)
		{
			int iTarget = GetEntPropEnt(client, Prop_Send, "m_hObserverTarget");

			if(IsValidClient_k(iTarget, true))
			{
				target = iTarget;
			}
		}
	}
	return target;
}

stock char MakeTheSpace(char[] input, int maxsize)
{
	/*
	Example:
	i = 9
	begin_space = 3
	end_space = 5	
	*/
	int i;
	int begin_space;
	int end_space;
	
	for (i = 0; i < maxsize; i++)
	{
		if(input[i] == '\' && input[i+1] == 'n')
			break;
	}
	for (begin_space = 0; begin_space < i; begin_space++)
	{
		if(input[begin_space] == ' ')
			break;
	}
	for (end_space = begin_space; end_space < i; end_space++)
	{
		if(input[end_space] != ' ')
		{
			--end_space;
			break;
		}
	}
	char theSpaces[12];
	for (int y = 0; y < (end_space-begin_space); y++)
	{
		theSpaces[y] = ' ';
	}
	return theSpaces;
}

stock char StringTier(int tier)
{
	char sOutput[64];
	switch(tier)
	{
		case 1:
		{
			Format(sOutput, sizeof(sOutput), "Tier: Very Easy");
		}
		case 2:
		{
			Format(sOutput, sizeof(sOutput), "Tier: Easy");
		}
		case 3:
		{
			Format(sOutput, sizeof(sOutput), "Tier: Medium");
		}
		case 4:
		{
			Format(sOutput, sizeof(sOutput), "Tier: Hard");
		}
		case 5:
		{
			Format(sOutput, sizeof(sOutput), "Tier: Very Hard");
		}
		case 6:
		{
			Format(sOutput, sizeof(sOutput), "Tier: N/A");
		}
	}
	return sOutput;
}

stock float CalculateProcentage(float x, float y)
{
	return float(((x/y)*100.0));
}