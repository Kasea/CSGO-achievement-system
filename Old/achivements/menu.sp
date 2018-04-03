/*
*Creates menu from !achivement
*Upon selection of either Achivements, completed/uncompleted achivements it display the appropriate achivements
*/

public void Achivement_Menu(int client)
{
	Handle menu = CreateMenu(Menu_Achivement);
	SetMenuTitle(menu, "Achivements completed: %i(%.2f%%)\nTotal achivements: %i\nYour current points: %i", g_nPlayer[client][completed], float(g_nPlayer[client][completed]/g_iTotalAchivements*100), g_iTotalAchivements, g_nPlayer[client][points]);
	AddMenuItem(menu, "0", "Achivements");
	AddMenuItem(menu, "1", "Completed Achivements");
	AddMenuItem(menu, "2", "Uncompleted Achivements");
	SetMenuExitButton(menu, true);
	DisplayMenu(menu, client, 0);
}

public Menu_Achivement(Handle menu, MenuAction action, int client, int itemNum)
{
	if (action == MenuAction_Select)
	{
		DisplayMenuToClient(client, GetMenuSelectionPosition());
		char num[8]; //num
		GetMenuItem(menu, itemNum, num, sizeof(num));
		DisplayAchivements(client, StringToInt(num));
	}
}

public void DisplayAchivements(int client, int choice)
{
	Handle menu = CreateMenu(Menu_Achivement_Info);
	for (int i = 0; i < MAX_ACHIVEMENTS;i++)
	{
		if(!g_nAchivements[i][count_as_achivement])
			continue;
		//Loops every achivement
		switch(choice)
		{
			case 0:
			{
				SetMenuTitle(menu, "Achivements:");
				AddMenuItem(menu, i, g_nAchivements[i][name]);
			}
			case 1:
			{
				SetMenuTitle(menu, "Complete achivements:");
				if(achivement_finished(client, g_nAchivements[i][name]))
					AddMenuItem(menu, i, g_nAchivements[i][name]);
			}
			case 2:
			{
				SetMenuTitle(menu, "Incomplete achivements:");
				if(!achivement_finished(client, g_nAchivements[i][name]))
					AddMenuItem(menu, i, g_nAchivements[i][name]);
			}
			default:
			{
				SetMenuTitle(menu, "Achivements:");
				AddMenuItem(menu, i, g_nAchivements[i][name]);
			}
		}
	}
	AddMenuItem(menu, "but1", "1", ITEMDRAW_NOTEXT);
	AddMenuItem(menu, "but3", "3", ITEMDRAW_RAWLINE);
	DisplayMenu(menu, client, 0);
}

//Displays information about any achivement
public Menu_Achivement_Info(Handle menu, MenuAction action, int client, int itemNum)
{
	if (action == MenuAction_Select)
	{
		DisplayMenuToClient(client, GetMenuSelectionPosition());
		char num[8]; //num
		GetMenuItem(menu, itemNum, num, sizeof(num));
		int achivement = StringToInt(num)
		char status[16]; //You have ****** this achivement
		if(achivement_finished(client, g_nAchivements[achivement][name]))
			Format(status, sizeof(status), "achived");
		else
			Format(status, sizeof(status), "not achived");
		CPrintToChat(client, "%t", "Has client achived this achivement", status);
		if(g_nAchivements[achivement][jump] != 0)
			CPrintToChat(client, "%t", "Jumps for achivement",g_nAchivements[achivement][jump]);
			
		if(g_nAchivements[achivement][death] != 0)
			CPrintToChat(client, "%t", "Deaths for achivement", g_nAchivements[achivement][death]);
			
		if(g_nAchivements[achivement][map] != 0)
			CPrintToChat(client, "%t", "Map completion for achivement", g_nAchivements[achivement][map]);
			
		if(g_nAchivements[achivement][Achivement_Finish] != 0)
			CPrintToChat(client, "%t", "Achivement count for achivement", g_nAchivements[achivement][Achivement_Finish]);
			
		if(g_nAchivements[achivement][Achivement_Points] != 0)
			CPrintToChat(client, "%t", "Points for achivement", g_nAchivements[achivement][Achivement_Points]);
			
		CPrintToChat(client, "%t", "To achive achivement");
		
		DisplayMenuAtItem(menu, client, itemNum, 0);
	}
}