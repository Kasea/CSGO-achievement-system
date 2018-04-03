bool licence = false;
int EpochTime = 1593882099; //This will last until 13 may 2016 @ 14:00:00

stock Verification()
{
	if(GetTime()<EpochTime)
		licence = true;
	else
		licence = false;
	
	if(licence == false)
	{
		Handle hPlugins;
		hPlugins = GetMyHandle();
		char sServer[244];
		GetPluginFilename(hPlugins, sServer, sizeof(sServer));
		ServerCommand("sm plugins unload %s", sServer); 
		ServerCommand("hostname Trial period of %s is over - Contact Kasea", sServer);
	}
}