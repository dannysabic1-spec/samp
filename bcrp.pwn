#include <a_samp>

#define BCRP_NAME "Balkan Country RP"
#define BCRP_MODE_TEXT "Igranje uloga | Bosna i Hercegovina"
#define COLOR_BCRP_INFO 0xB9E7FFFF

main()
{
}

public OnGameModeInit()
{
    SetGameModeText(BCRP_MODE_TEXT);
    ShowPlayerMarkers(1);
    ShowNameTags(1);
    SetWorldTime(12);
    SetWeather(10);

    // Osnovna klasa služi samo za provjeru da se GameMode može učitati.
    AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 270.0, 0, 0, 0, 0, 0, 0);

    printf("%s: GameMode je pokrenut.", BCRP_NAME);
    print("Status: osnovna Faza A; RP sistemi još nisu implementirani.");
    return 1;
}

public OnGameModeExit()
{
    printf("%s: GameMode je ugašen.", BCRP_NAME);
    return 1;
}

public OnPlayerConnect(playerid)
{
    // Pawn šalje bajtove koje koriste SA-MP/open.mp klijenti.
    // \x9A je š, a \xE8 je č u Windows-1250 kodnoj stranici.
    SendClientMessage(playerid, COLOR_BCRP_INFO, "Dobro do\x9Aao na Balkan Country RP!");

    new ime[MAX_PLAYER_NAME];
    GetPlayerName(playerid, ime, sizeof(ime));
    printf("Igra\xE8 %s se povezao na server.", ime);
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    new ime[MAX_PLAYER_NAME];
    GetPlayerName(playerid, ime, sizeof(ime));
    printf("Igra\xE8 %s je napustio server (razlog: %d).", ime, reason);
    return 1;
}
