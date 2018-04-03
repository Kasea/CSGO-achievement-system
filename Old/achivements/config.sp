#define MAX_ACHIVEMENTS 200

enum enum_Achivements
{
	String:name[64],
	jump,
	death,
	map,
	achivement_finish,
	achivement_points,
	bool:count_as_achivement,
	points,
	credits
}

int g_nAchivements[MAX_ACHIVEMENTS+1][enum_Achivements];

int g_iTotalAchivements;

public void LoadConfig()
{
	char sPath[PLATFORM_MAX_PATH];
	BuildPath(Path_SM, sPath, sizeof(sPath), "configs/achivements.cfg");
	
	Handle kv = CreateKeyValues("Achivements");
	FileToKeyValues(kv, sPath);
	
	if(KvGotoFirstSubKey(kv))
	{
		g_iTotalAchivements = 0;
		int x = 0;
		do{
			KvGetSectionName(kv, g_nAchivements[g_iTotalAchivements], 64);
			g_nAchivements[g_iTotalAchivements][jump] = KvGetNum(kv, "jump", 0);
			g_nAchivements[g_iTotalAchivements][death] = KvGetNum(kv, "death", 0);
			g_nAchivements[g_iTotalAchivements][map] = KvGetNum(kv, "map", 0);
			g_nAchivements[g_iTotalAchivements][achivement_finish] = KvGetNum(kv, "achivement_finish", 0);
			g_nAchivements[g_iTotalAchivements][achivement_points] = KvGetNum(kv, "achivement_points", 0);
			g_nAchivements[g_iTotalAchivements][points] = KvGetNum(kv, "points", 0);
			g_nAchivements[g_iTotalAchivements][credits] = KvGetNum(kv, "credits", 0);
			x = KvGetNum(kv, "count_as_achivement", 0);
			switch(x)
			{
				case 0: g_nAchivements[g_iTotalAchivements][count_as_achivement] = false;
				case 1: g_nAchivements[g_iTotalAchivements][count_as_achivement] = true;
			}
			g_iTotalAchivements++;
		}
		while (KvGotoNextKey(kv));
	}
}