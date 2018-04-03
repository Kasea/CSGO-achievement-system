public Action cmd_achivement(int client, int args)
{
	AchievementMenu(client);
}

public Action cmd_addachivement(int client, int args)
{
	if(args == 6)
	{
		char achiv_name[256], type[32], temp[32];
		int iPoints, IScore, ICredits, BHidden;
		GetCmdArg(1, achiv_name, sizeof(achiv_name));
		GetCmdArg(2, type, sizeof(type));
		GetCmdArg(3, temp, sizeof(temp));
		iPoints = StringToInt(temp);
		GetCmdArg(4, temp, sizeof(temp));
		IScore = StringToInt(temp);
		GetCmdArg(5, temp, sizeof(temp));
		ICredits = StringToInt(temp);
		GetCmdArg(6, temp, sizeof(temp));
		BHidden = StringToInt(temp);
		CreateAchivement(achiv_name, type, iPoints, IScore, ICredits, BHidden);
	}else
		ReplyToCommand(client, "sm_addachivement \"achivname\" \"type\" points score credits hidden");
	return Plugin_Handled;
}