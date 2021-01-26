#include <sourcemod>
#include <basecomm>

public Plugin:myinfo = 
{
	name = "Mute Prisoners",
	author = "Lawyn#5015",
	description = "Official plugin made by Lawyn#5015 | JB.NEVERGO.RO",
	version = "1.0",
	url = "https://nevergo.ro"
}

public OnPluginStart()
{
	HookEvent("player_spawn", Event_PlayerSpawn);
	HookEvent("player_death", Event_PlayerDeath);
}

public OnClientPostAdminCheck(client)
{
	if((GetUserFlagBits(client) & ADMFLAG_CUSTOM2) && BaseComm_IsClientMuted(client) == false)
	{
		BaseComm_SetClientMute(client, false);
	}
	else
	{
		BaseComm_SetClientMute(client, true);
	}
}

public Action:Event_PlayerSpawn(Handle:event, const String:name[], bool:dontBroadcast) 
{
	new client = GetClientOfUserId(GetEventInt(event, "userid"))
	if(GetClientTeam(client) == 3 && BaseComm_IsClientMuted(client) == false)
	{
		BaseComm_SetClientMute(client, false)
	}
	
	else if(GetClientTeam(client) == 2)
	{
		if((GetUserFlagBits(client) & ADMFLAG_CUSTOM2) && BaseComm_IsClientMuted(client) == false)
		{
			BaseComm_SetClientMute(client, false)
		}
		else
		{
			BaseComm_SetClientMute(client, true)
		}
	}
}

public Action:Event_PlayerDeath(Handle:event, const String:name[], bool:dontBroadcast) 
{
	new client = GetClientOfUserId(GetEventInt(event, "userid"))
	if((GetUserFlagBits(client) & ADMFLAG_CUSTOM2 || GetClientTeam(client) == 3) && BaseComm_IsClientMuted(client) == false)
	{
		BaseComm_SetClientMute(client, false)
	}
	else
	{
		BaseComm_SetClientMute(client, true)
	}
}
