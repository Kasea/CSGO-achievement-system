Handle g_hSQL;

public void ConnectSQL()
{
	char errorbuffer[128];
	g_hSQL = INVALID_HANDLE;
	g_hSQL = SQL_Connect("achivement", true, errorbuffer, sizeof(errorbuffer));
	if(g_hSQL == INVALID_HANDLE)
		CreateTimer(0.5, Timer_RetryDB);
	else
	{
		//Create db n the good shiat
	}
}

public Action Timer_RetryDB(Handle timer)
{
	ConnectSQL();
	return Plugin_Stop;
}