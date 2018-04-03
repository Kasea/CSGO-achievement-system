public Action Event_Death(Handle event,const char[] name,bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event,"userid"));
	int attacker = GetEventInt(event, "attacker");
	if(IsValidClient(attacker))
	{
		Player player2 = Player(attacker);
		player2.iKills++;
	}
	Player player = Player(client);
	player.iDeaths++;
}

public Action Event_Jump(Handle event,const char[] name,bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event,"userid"));
	Player player = Player(client);
	player.iJumps++;
}

public Action Event_Shoot(Handle event,const char[] name,bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event,"userid"));
	Player player = Player(client);
	player.iShots++;
}