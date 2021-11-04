--------Auto Update-------- https://aimware.net/forum/thread/151605
local SCRIPT_FILE_NAME = GetScriptName();
local SCRIPT_FILE_ADDR = "https://raw.githubusercontent.com/OwlMan42069/Aimware-Luas/main/Hentai%20Killsay%20Deathsay.lua";
local VERSION_FILE_ADDR = "https://raw.githubusercontent.com/OwlMan42069/Aimware-Luas/main/Versions/Hentai%20Killsay%20Deathsay%20Version.txt";
local VERSION_NUMBER = "2.3";
local version_check_done = false;
local update_downloaded = false;
local update_available = false;
local up_to_date = false;
local updaterfont1 = draw.CreateFont("Bahnschrift", 18);
local updaterfont2 = draw.CreateFont("Bahnschrift", 14);
local updateframes = 0;
local fadeout = 0;
local spacing = 0;
local fadein = 0;

callbacks.Register( "Draw", "handleUpdates", function()
	if updateframes < 5.5 then
		if up_to_date or updateframes < 0.25 then
			updateframes = updateframes + globals.AbsoluteFrameTime();
			if updateframes > 5 then
				fadeout = ((updateframes - 5) * 510);
			end
			if updateframes > 0.1 and updateframes < 0.25 then
				fadein = (updateframes - 0.1) * 4500;
			end
			if fadein < 0 then fadein = 0 end
			if fadein > 650 then fadein = 650 end
			if fadeout < 0 then fadeout = 0 end
			if fadeout > 255 then fadeout = 255 end
		end
		if updateframes >= 0.25 then fadein = 650 end
		for i = 0, 600 do
			local alpha = 200-i/3 - fadeout;
			if alpha < 0 then alpha = 0 end
			draw.Color(15,15,15,alpha);
			draw.FilledRect(i - 650 + fadein, 0, i+1 - 650 + fadein, 30);
			draw.Color(0, 180, 255,alpha);
			draw.FilledRect(i - 650 + fadein, 30, i+1 - 650 + fadein, 31);
		end
		draw.SetFont(updaterfont1);
		draw.Color(0,180,255,255 - fadeout);
		draw.Text(7 - 650 + fadein, 7, "RetardAlert's");
		draw.Color(225,225,225,255 - fadeout);
		draw.Text(7 + draw.GetTextSize("RetardAlert's ") - 650 + fadein, 7, "Script");
		draw.Color(0,180,255,255 - fadeout);
		draw.Text(7 + draw.GetTextSize("RetardAlert's Script  ") - 650 + fadein, 7, "\\");
		spacing = draw.GetTextSize("RetardAlert's Script  \\  ");
		draw.SetFont(updaterfont2);
		draw.Color(225,225,225,255 - fadeout);
	end

    if (update_available and not update_downloaded) then
		draw.Text(7 + spacing - 650 + fadein, 9, "Downloading latest version.");
        local new_version_content = http.Get(SCRIPT_FILE_ADDR);
        local old_script = file.Open(SCRIPT_FILE_NAME, "w");
        old_script:Write(new_version_content);
        old_script:Close();
        update_available = false;
        update_downloaded = true;
	end
	
    if (update_downloaded) and updateframes < 5.5 then
		draw.Text(7 + spacing - 650 + fadein, 9, "Update available, please reload the script.");
    end

    if (not version_check_done) then
        version_check_done = true;
		local version = http.Get(VERSION_FILE_ADDR);
		version = string.gsub(version, "\n", "");
		if (version ~= VERSION_NUMBER) then
            update_available = true;
		else 
			up_to_date = true;
		end
	end
	
	if up_to_date and updateframes < 5.5 then
		draw.Text(7 + spacing - 650 + fadein, 9, "Successfully loaded latest version: v" .. VERSION_NUMBER);
	end
end)

--------GUI Stuff--------
local misc_ref = gui.Reference("Misc")
local tab = gui.Tab(misc_ref, "RetardAlert", ("ThighHighs.club v" .. VERSION_NUMBER))
local misc_left = gui.Groupbox(tab, "Killsay / Deathsay", 10, 15, 310, 400)
local misc_left2= gui.Groupbox(tab, "Clantags", 10, 160, 310, 400)
local misc_left3 = gui.Groupbox(tab, "Grenade Throwsay", 10, 305, 310, 400)
local misc_right = gui.Groupbox(tab, "Message Events", 325, 15, 305, 400)
local misc_right2 = gui.Groupbox(tab, "Misc", 325, 160, 305, 400)

local enable_killsays = gui.Checkbox(misc_left, "enable.killsays", "Enable Killsay Deathsay", true)
local killsay_mode = gui.Combobox( misc_left, "killsay.mode", "Select Killsay Mode", "Hentai", "Lewd", "Apologetic", "Edgy", "EZfrags", "AFK")

local enable_clantags = gui.Checkbox(misc_left2, "enable.clantags", "Enable Premade Clantags", false)
local clantag_mode = gui.Combobox( misc_left2, "clantag.mode", "Select clantag", "Sussy Baka", "UwU Rawr xD!", "Sorry Not Sorry", "No Lives Matter", "EZFrags.co.uk")
local set_clantag = ffi.cast('int(__fastcall*)(const char*, const char*)', mem.FindPattern("engine.dll", "53 56 57 8B DA 8B F9 FF 15"))
local clantagset = 0

local enable_throwsay = gui.Checkbox(misc_left3, "enable.throwsay", "Enable Grenade Throwsay", true)
local grenade_throwsay = gui.Multibox(misc_left3, "Select Grenades")
local enable_hegrenade = gui.Checkbox(grenade_throwsay, "enable.hegrenade", "HE Grenade", true)
local enable_flashbang = gui.Checkbox(grenade_throwsay, "enable.flashbang", "Flashbang", true)
local enable_smokegrenade = gui.Checkbox(grenade_throwsay, "enable.smokegrenade", "Smoke", true)
local enable_molotov = gui.Checkbox(grenade_throwsay, "senable.molotov", "Molotov/Incendiary", true)

local EngineRadar = gui.Checkbox(misc_right2, "engineradar", "Engine Radar", true)
local ForceCrosshair = gui.Checkbox(misc_right2, "forcecrosshair", "Force Crosshair", true)
local RecoilCrosshair = gui.Checkbox(misc_right2, "recoilcrosshair", "Recoil Crosshair", false)
local laffmode = gui.Checkbox(misc_right2, "laffmode", "Laff Mode", true)

local enable_msgevents = gui.Checkbox(misc_right, "enable.msgevents", "Enable Message Events", false)
local msgevents_mode = gui.Combobox( misc_right, "msgevents.mode", "Select Message Mode", "Copy Player Messages", "Chat Breaker")

EngineRadar:SetDescription("Displays enemies on your in-game radar.")
ForceCrosshair:SetDescription("Displays your in-game crosshair while holding snipers.")
RecoilCrosshair:SetDescription("Displays your recoil using your in-game crosshair.")
laffmode:SetDescription("Replaces lol with laff in chat :laff:")


--------Draw Image--------
local function OnUnload()
	client.Command("toggleconsole", true)

	client.Command('echo "⠄⠄⠄⢰⣧⣼⣯⠄⣸⣠⣶⣶⣦⣾⠄⠄⠄⠄⡀⠄⢀⣿⣿⠄⠄⠄⢸⡇⠄⠄"', true)
	client.Command('echo "⠄⠄⠄⣾⣿⠿⠿⠶⠿⢿⣿⣿⣿⣿⣦⣤⣄⢀⡅⢠⣾⣛⡉⠄⠄⠄⠸⢀⣿⠄"', true)
	client.Command('echo "⠄⠄⢀⡋⣡⣴⣶⣶⡀⠄⠄⠙⢿⣿⣿⣿⣿⣿⣴⣿⣿⣿⢃⣤⣄⣀⣥⣿⣿⠄"', true)
	client.Command('echo "⠄⠄⢸⣇⠻⣿⣿⣿⣧⣀⢀⣠⡌⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⣿⣿⣿⠄"', true)
	client.Command('echo "⠄⢀⢸⣿⣷⣤⣤⣤⣬⣙⣛⢿⣿⣿⣿⣿⣿⣿⡿⣿⣿⡍⠄⠄⢀⣤⣄⠉⠋⣰"', true)
	client.Command('echo "⠄⣼⣖⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⢇⣿⣿⡷⠶⠶⢿⣿⣿⠇⢀⣤"', true)
	client.Command('echo "⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⣿⣿⡇⣿⣿⣿⣿⣿⣿⣷⣶⣥⣴⣿⡗"', true)
	client.Command('echo "⢀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠄"', true)
	client.Command('echo "⢸⣿⣦⣌⣛⣻⣿⣿⣧⠙⠛⠛⡭⠅⠒⠦⠭⣭⡻⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠄"', true)
	client.Command('echo "⠘⣿⣿⣿⣿⣿⣿⣿⣿⡆⠄⠄⠄⠄⠄⠄⠄⠄⠹⠈⢋⣽⣿⣿⣿⣿⣵⣾⠃⠄"', true)
	client.Command('echo "⠄⠘⣿⣿⣿⣿⣿⣿⣿⣿⠄⣴⣿⣶⣄⠄⣴⣶⠄⢀⣾⣿⣿⣿⣿⣿⣿⠃⠄⠄"', true)
	client.Command('echo "⠄⠄⠈⠻⣿⣿⣿⣿⣿⣿⡄⢻⣿⣿⣿⠄⣿⣿⡀⣾⣿⣿⣿⣿⣛⠛⠁⠄⠄⠄"', true)
	client.Command('echo "⠄⠄⠄⠄⠈⠛⢿⣿⣿⣿⠁⠞⢿⣿⣿⡄⢿⣿⡇⣸⣿⣿⠿⠛⠁⠄⠄⠄⠄⠄"', true)
	client.Command('echo "⠄⠄⠄⠄⠄⠄⠄⠉⠻⣿⣿⣾⣦⡙⠻⣷⣾⣿⠃⠿⠋⠁⠄⠄⠄⠄⠄⢀⣠⣴"', true)
	client.Command('echo "⣿⣿⣿⣶⣶⣮⣥⣒⠲⢮⣝⡿⣿⣿⡆⣿⡿⠃⠄⠄⠄⠄⠄⠄⠄⣠⣴⣿⣿⣿"', true)

	if clantagset == 1 then
		set_clantag("", "")
	end
end

--------Miscellaneous--------
client.Command("+right", true)
client.Command("+left", true)
client.Command("snd_menumusic_volume 0", true)
client.Command("cl_timeout 0 0 0 7", true)

--------Engine Radar--------
callbacks.Register('CreateMove', function()
	local isEngineRadarOn = EngineRadar:GetValue() and 1 or 0

	for _, Player in ipairs(entities.FindByClass('CCSPlayer')) do
		Player:SetProp('m_bSpotted', isEngineRadarOn)
	end
end)

--------Force Crosshair--------
client.AllowListener('item_equip')
callbacks.Register('FireGameEvent', function(e)
	if not ForceCrosshair:GetValue() or e:GetName() ~= 'item_equip' then
		if not client.GetConVar('weapon_debug_spread_show') == '3' then
			client.SetConVar('weapon_debug_spread_show', 0, true)
		end
		return
	end

	local LocalPlayerIndex = client.GetLocalPlayerIndex()
	local PlayerIndex = client.GetPlayerIndexByUserID( e:GetInt('userid') )
	local WeaponType = e:GetInt('weptype')

	if LocalPlayerIndex == PlayerIndex then
		if WeaponType == 5 then
			client.SetConVar('weapon_debug_spread_show', 3, true)
		end
	end
end)

--------Recoil Crosshair--------
local function CrosshairRecoil()
	if RecoilCrosshair:GetValue() and not gui.GetValue("rbot.master") then
		client.SetConVar("cl_crosshair_recoil", 1, true)
	else
		client.SetConVar("cl_crosshair_recoil", 0, true)
	end
end

--------Inventory Unlocker--------
local function UnlockInventory()
	panorama.RunScript('LoadoutAPI.IsLoadoutAllowed = () => true');
end

--------Laff Mode--------
callbacks.Register('SendStringCmd', function(cmd)
	if laffmode:GetValue() and string.find(cmd:Get(), 'say "lol"') then
		cmd:Set('say "laff"')
	end
end)

--------Message Events--------
local function for_msgevents( msg )
    if not enable_msgevents:GetValue() then
        return
    end

    if msg:GetID() ~= 6 then
        return
    end

    local index = msg:GetInt( 1 )
    local message = msg:GetString( 4, 1 )

    if msgevents_mode:GetValue() == 0 then
        client.ChatSay(message)
    elseif msgevents_mode:GetValue() == 1 then
        client.ChatSay("﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽")
    end
end


--Throwsays
local ThrowSays = {
	hegrenade = {
		'Pegue o retardado!',
		'Atenção!',
		'Isto vai doer.',
	},

	flashbang = {
		'Olha um pássaro!',
		'Olha um avião!',
		'GRANADA DE LUZ!',
		'Bang bang bangity bang Eu disse bang bang bangity bang bang bang bang bang',
	},

	molotov = {
		'Fogo retardado!',
		'QUEIMAR BEBÊ QUEIMAR!',
	},

	incgrenade = {
		'Fogo retardado!',
		'QUEIMAR BEBÊ QUEIMAR!',
	},

	smokegrenade = {
		'Eu sou um ninja',
		'Homem muito sorrateiro',
		'NINJA DEFUSE!',
	},
}

local function for_throwsay(e)
	if not enable_throwsay:GetValue() then
		return
	end

	if e:GetName() ~= 'grenade_thrown' then
		return
	end

	if client.GetPlayerIndexByUserID( e:GetInt('userid') ) ~= client.GetLocalPlayerIndex() then
		return
	end

	local wep = e:GetString('weapon')
	local says = ThrowSays[wep]
	local say_msg =
	   (wep == 'hegrenade' and enable_hegrenade:GetValue()) or 
	   (wep == 'flashbang' and enable_flashbang:GetValue()) or
	   ((wep == 'molotov' or wep == 'incgrenade') and enable_molotov:GetValue()) or
	   (wep == 'smokegrenade' and enable_smokegrenade:GetValue())

	if say_msg then
		client.ChatSay( says[math.random(#says)] )
	end
end


--ClanTags
local ClanTags = {
	['Sussy Baka'] = {
		"                  ",
		"S                 ",
		"S^                ",
		"Su                ",
		"Su|               ",
		"Su                ",
		"Sus               ",
		"Suss              ",
		"Suss(>ω<)         ",
		"Sussy             ",
		"Sussy |           ",
		"Sussy             ",
		"Sussy B           ",
		"Sussy B@          ",
		"Sussy Ba          ",
		"Sussy Ba(>ω<)     ",
		"Sussy Bak         ",
		"Sussy Baka        ",
		"Sussy Baka|       ",
		"Sussy Baka        ",
		"Sussy Baka|       ",
		"Sussy Baka        ",
		"Sussy Baka|       ",
		"Sussy Baka        ",
		"Sussy Bak         ",
		"Sussy Ba^         ",
		"Sussy Ba          ",
		"Sussy B@          ",
		"Sussy B           ",
		"Sussy |           ",
		"Sussy             ",
		"Sussy |           ",
		"Sussy             ",
		"Sussy|            ",
		"Sussy             ",
		"Suss(>ω<)         ",
		"Suss              ",
		"Sus|              ",
		"Sus               ",
		"Su                ",
		"S^                ",
		"S|                ",
		"S                 ",
		"|                 "
	},

	['UwU Rawr xD!'] = {
		"                  ",
		"U                 ",
		"Uw                ",
		"UwU               ",
		"(>ω<)             ",
		"UwU R             ",
		"UwU Ra            ",
		"UwU Raw           ",
		"UwU Rawr          ",
		"UwU Rawr x        ",
		"UwU Rawr xD       ",
		"UwU Rawr xD!      ",
		"UwU Rawr xD!      ",
		"UwU Rawr xD!      ",
		"UwU Rawr xD!      ",
		"UwU Rawr xD!      ",
		"UwU Rawr xD       ",
		"UwU Rawr x        ",
		"UwU Rawr          ",
		"UwU Raw           ",
		"UwU Ra            ",
		"UwU R             ",
		"(>ω<)             ",
		"UwU               ",
		"Uw                ",
		"U                 ",
		"                  ",
		"                  "
	},

	['Sorry Not Sorry'] = {
		"                  ",
		"$                 ",
		"S                 ",
		"So                ",
		"Sor               ",
		"Sorr              ",
		"Sorry             ",
		"Sorry N           ",
		"Sorry No          ",
		"Sorry No^         ",
		"Sorry Not         ",
		"Sorry Not $       ",
		"Sorry Not S@      ",
		"Sorry Not So      ",
		"Sorry Not Sor     ",
		"Sorry Not Sorr    ",
		"Sorry Not Sorr^   ",
		"Sorry Not Sorry   ",
		"Sorry Not Sorry   ",
		"$@rry Not $@rry   ",
		"Sorry Not Sorry   ",
		"Sorry Not Sorry   ",
		"Sorry Not Sorr^   ",
		"Sorry Not Sorr    ",
		"Sorry Not Sor     ",
		"Sorry Not So      ",
		"Sorry Not S@      ",
		"Sorry Not $       ",
		"Sorry Not         ",
		"Sorry No^         ",
		"Sorry No          ",
		"Sorry N           ",
		"Sorry             ",
		"Sorr              ",
		"Sor               ",
		"So                ",
		"S                 ",
		"$                 ",
		"                  "
	},

	['No Lives Matter'] = {
		"                  ",
		"N                 ",
		"No                ",
		"No L              ",
		"No Li             ",
		"No Liv            ",
		"No Live           ",
		"No Lives          ",
		"No Lives M        ",
		"No Lives Ma       ",
		"No Lives Mat      ",
		"No Lives Matt     ",
		"No Lives Matte    ",
		"No Lives Matter   ",
		"No Lives Matter   ",
		"No Lives Matter   ",
		"No Lives Matter   ",
		"o Lives Matter    ",
		"Lives Matter      ",
		"ives Matter       ",
		"ves Matter        ",
		"es Matter         ",
		"s Matter          ",
		"Matter            ",
		"atter             ",
		"tter              ",
		"ter               ",
		"er                ",
		"r                 ",
		"                  "
	},

	['EZFrags.co.uk'] = {
		"                  ",
		"E                 ",
		"EZ                ",
		"EZf               ",
		"EZfr              ",
		"EZfra             ",
		"EZfrag            ",
		"EZfrags           ",
		"EZfrags.          ",
		"EZfrags.c         ",
		"EZfrags.co        ",
		"EZfrags.co.       ",
		"EZfrags.co.u      ",
		"EZfrags.co.uk     ",
		"EZfrags.co.uk     ",
		"EZfrags.co.uk     ",
		"EZfrags.co.uk     ",
		"EZfrags.co.uk     ",
		"EZfrags.co.u      ",
		"EZfrags.co.       ",
		"EZfrags.co.       ",
		"EZfrags.co        ",
		"EZfrags.c         ",
		"EZfrags.          ",
		"EZfrags           ",
		"EZfrag            ",
		"EZfra             ",
		"EZfr              ",
		"EZf               ",
		"EZ                ",
		"E                 ",
		"                  "
	},
}


local function for_clantags()
	if not enable_clantags:GetValue() then
		if clantagset == 1 then
			set_clantag("", "")
			clantagset = 0
		end

		return
	end

	local mode = clantag_mode:GetString()
	local tag = ClanTags[mode]
	local curtime = math.floor(globals.CurTime() * 2.3)

	if old_time ~= curtime then
		local t = tag[curtime % #tag+1]
		set_clantag(t, t)
	end

	old_time = curtime
	clantagset = 1
end

-- KillSays
local KillSays = {
	Hentai = {
		Kill = {
			"S-desculpe onii-chan p-por favor d-me faça mais forte; w;",
			"V-Você me deixou toda molhada agora Senpai!",
			"N-não me toque aí Senpai",
			"P-Por favor, me ame mais oniichan ohh grrh aahhhh ~!",
			"Dê-me todo o seu esperma Senpai ahhhhh ~",
			"F-me fode com mais força, chan!",
			"Oh meu Deus, eu te odeio tanto Senpai, mas por favor, continue me fodendo mais forte! Ahhh ~",
			"D-Você gosta da minha calcinha despojada ficando encharcada por você e seu pau duro? Ehhh mestre você é tão obsceno ^ 0 ^ ~",
			"Kun, seu pau bonitinho entre os lábios da minha buceta parece muito fofo, estou corando",
			"M-Mestre, é bom quando eu deslizo pelos peitos para cima e para baixo em sua parte masculina fofa?",
			"O-Oniichan, meus dedos do pé estão tão quentes com sua porra em cima deles uwu ~",
			"Vamos tirar esse maiô já <3 vou beber seu suco derretido desconhecido",
			"S-pare a Senpai se continuarmos fazendo esses sons obscenos eu vou gozar ~~",
			"Você é um pervertido por me encher com sua massa de bebê Senpai ~~",
			"Encha o meu quarto do bebê com seu sêmen kun ^ - ^",
			"M-Mestre n-não bata na minha bunda tão forte ahhhH ~~~ você está me deixando tão m-molhado ~",
			"Senpai, seu pau já está latejando dos meus peitos enormes ~",
			"Ei kun, posso comer sêmen?",
			"M-Meu quarto do bebê está transbordando com seu sêmen M-Mestre",
			"Encha minha boceta da garganta com seu kun de sêmen",
			"Não é gay se você está usando meias M-Master",
			"E-eu preciso de um lugar para estourar minha carga. Posso pegar seu bussy emprestado?",
			"A-ah merda ... V-seu pau é grande e está na minha bunda - já ~ ?!",
			"Vou engolir sua essência pegajosa junto com você ~!",
			"B-Baka, por favor, deixe-me ser sua vagabunda femboy maricas!",
			"Esse é um pênis UwU você me rebocou, você me deu um giww !!",
			"Ahhhh ... É como um sonho que se tornou realidade ... Eu consigo enfiar meu pau dentro da sua bunda ...!",
			"Ei, quem quer um pedaço dessa buceta gorda de 19 anos? Arquivo único, rapazes, venham buscar enquanto está quente!",
			"M-Mestre, se você continuar empurrando com tanta força, meus seios vão cair!",
			"Quando você quer se encontrar de novo? Eu realmente gostei do seu pau! (,, ◠∇◠) Eu quero que você e somente você bata na minha boceta todos os dias! (≧ ∇ ≦)",
			"Tudo que eu fiz foi jogar cruzado porque achei que seria divertido ... Mas agora sou apenas uma garotinha que goza de paus grandes!",
			"N-não fique com a ideia errada !!! Eu não quero que você foda minha b-buceta porque eu te amo ou algo assim! D-definitivamente não!",
			"E-eu sei que disse que você podia ser tão rude quanto quisesse ... Mas fisting surpresa não era o que eu tinha em mente !!",
			"P-porque é que ultimamente ... V-você não tem brincado com a minha bunda !!?",
		},

		Death = {
			"Hehe não me toque aí Onii-chann UwU",
			"Seu esperma está em todo o meu clitóris molhado M-Master",
			"Parece que você está me batendo com a força de mil sóis Senpai",
			"S-Sim, ali mesmo S-Sempai hooyah",
			"P-Por favor, continue enchendo meu quarto de bebê S-Sempai",
			"O-Onii-chan, foi tão bom quando você mexe na minha buceta",
			"P-Por favor, Onii-chan, continue enchendo meu quarto de bebê com seu suco derretido",
			"O-Onii-chan você só um tiro no meu quarto de bebê",
			"Eu-eu não sou nada além de uma vagabunda de merda para sua merda de monstro!",
			"Domine meus ovários com seus nadadores ferozes!",
			"Y-seu separador de carne penetrou no meu buraco apertado de menino",
			"Mnn MAIS RÁPIDO ... MAIS DIFÍCIL! Transforme-me em sua vagabunda femboy ~!",
			"Mmmm- me acalma, me acaricia, me fode, me procrie!",
			"Sonde o seu pau grosso, molhado e latejante cada vez mais fundo na minha boipussy ~ !!",
			"Hya! Meus ouvidos não! Ah ... Faz cócegas! Ah!",
			"Kouta ... Não acredito como ele é GRANDE ... Espere! Esqueça isso !! Nyuu-chan está realmente dando um caralho nele !?",
			"Senpai enfie mais fundo seu pênis na m-minha buceta (> ω <) por favor",
			"Estou indo com você fwuking meu cuzinho mmyyy!",
			"P-Por favor, seja gentil, S-Senpai!",
			"N-Não me leve a mal !! Eu não desisti da minha viginity para você porque gosto de você nem nada !!",
			"Deixe-me provar seu pau futa com minha buceta ~",
		}
	},

	Lewd = {
		Kill = {
			"Oh, você quer comer? Quer tomar banho? Ou você me quer!",
			"Não é gay se você engolir as evidências!",
			"Esse é um pênis UwU você me rebocou, você me deu um giww !!",
			"Você está cordialmente convidado para foder minha bunda!",
			"Agarre-os, aperte-os, belisque-os, puxe-os, lamba-os, morda-os, chupe-os!",
			"Parece que seu pau está escorregando em uma pilha viscosa de macarrão!",
			"Este é o policial do bloqueio do galo! Espere aí!",
			"Ohoo, enlouquecer fez você gozar? Que vadia nojenta você é!",
			"Eu me masturbei todos os dias ... dei à luz incontáveis ​​caracóis ... Tudo enquanto fantasiava sobre o dia em que te foderia!",
			"Você está vendo pornografia quando, em vez disso, poderia estar usando sua irmãzinha!",
			"Umm ... não quero parecer rude, mas você já tomou banho? Sua calcinha está meio amarelada ...",
			"Papai, seu mentiroso! Como você pode dizer isso tendo uma ereção tão ENORME.",
			"E-eu só quero seu pau emprestado ...",
			"Se um homem colocar sua mangueira no buraco negro de outro homem, eles podem fazer um bebê?",
			"E-eu tive uma coceira lá embaixo ... e eu só precisava de algo para - para ficar lá dentro!",
			"Você tem uma calcinha gostosa aí ...",
			"Você é meu balde de porra pessoal !!",
			"E-estou gozando, estou gozando, goze comigo também!",
			"Sua resistência só torna meu pênis mais duro!",
			"Porra, seu pau safado! Faça isso! Faça isso! FAÇA !!!",
			"Os meninos simplesmente não podem se considerar adultos ... até que tenham a chance de gozar com um ampito de menina.",
			"Nós dois vamos foder sua boceta ao mesmo tempo!",
			"Quando todo mundo já foi para casa e a sala está vazia, você não tem escolha a não ser se expor e se masturbar, certo?",
		},

		Death = {
			"Domine meus ovários com seus nadadores ferozes!",
			"Impregnem-me com seus genes reprodutores virais!",
			"M-meu corpo anseia por seu doce leite de pau",
			"Meus mamilos estão sendo atormentados",
			"Penetre-me até eu estourar!",
			"Mmmm- me acalma, me acaricia, me fode, me procrie!",
			"Eu sou seu balde de porra pessoal !!",
			"Você pode mesmo me culpar por ficar com tesão depois de ver isso?",
			"Nós dois cobriremos minha irmã com nosso esperma!",
			"Isso ... Isso é quase como ... como se de alguma forma fosse eu quem o estuprava!",
			"Você está impregnando minhas bolas !?",
			"Se você não fosse um pervertido, não ia gostar de ter uma garota que te faz na bunda, não é?",
			"Bem, bem ... Que fofura você é! Vou reclamar a sua virgindade!",
			"Oh, yeahh! Você quer foder?",
			"Estou ficando chateado e horrível agora!",
		}
	},

	Apologetic = {
		Sorry = {"sinto muito por", "estou triste depois de", "estou angustiado porque", "estou chateado comigo mesmo porque", "fui diagnosticado com depressão porque", "estou com o coração partido por", "peço desculpas por isso" , "gostaria de me desculpar porque", "sinto muito remorso porque", "tenho vergonha de mim mesmo porque"},
		Kill = {"morto", "destruído", "acabar com", "encerrado", "assassinado", "encerrado", "eliminado", "executado", "abatido", "massacrado", "baleado e morto "},
		Regret = {":(", "Por favor, me perdoe", "Não era minha intenção.", "Sou um fracasso", "Vou pegar leve com você da próxima vez.", "Foi minha culpa" , "Por favor, desculpe meu comportamento"}
	},

	Edgy = {
		Kill = {
			"Deixe meu K / D falar",
			"louco porque é mau",
			"Sem Aimware sem conversa",
			"Erro de configuração, usuário banido, thread bloqueado.",
			"Erro de QI",
			"Eu sou a razão de seu pai ser gay",
			"Como está sua mãe depois de ontem à noite?",
			"Pessoas mortas não podem falar nn",
			"Calor, amor e carinho. Estas são as coisas que tirei de você.",
			"Fiz um contrato com o diabo, por isso não posso ser amiga de um deus.",
			"Cadáveres são bons. Eles não balbuciam.",
			"Os fracos estão destinados a mentir sob as botas dos fortes.",
			"Opções -> Como jogar",
			"O mundo é melhor sem você",
			"A vida é um sofrimento sem fim ...",
			"Estou apenas matando as aranhas para salvar as borboletas.",
			"O medo é o que cria ordem.",
			"Não importa o quanto você chore, eu não vou parar.",
			"Excluído",
			"*MORTO*",
			"Resolvido",
			"Destruído",
			"Se GD quisesse que você vivesse, ele não teria me criado.",
			"Ganhe sua danação",
			"A vingança é minha",
			"Se a princípio você não conseguir ... tente, tente novamente.",
			"Cuidado com a cabeça",
			"Quando você estiver pronto, ligue para mim",
			"Eu me tornei o destruidor da morte de mundos",
			"Assim como vem, também vai",
			"Eu fico você vai",
			"Fim da linha para você",
			"Talvez amanhã.",
			"Eu sou invencível pra caralho.",
			"Vejo você em alguns minutos.",
			"Você é uma criança forte, mas eu estou além das forças",
		},

		Morte = {
			"Você só me matou porque eu fiquei sem saúde ..",
			"Aposto que pessoas mortas são mais fáceis de conviver.",
			"O verdadeiro inferno está dentro da pessoa.",
			"Aqueles que matam devem estar preparados para serem mortos.",
			"Eu te dei aquele",
			"Parabéns! Você está no scoarboard agora.",
			"As emoções são um transtorno mental",
			"Curta o momento",
			"Passado mas não esquecido",
			"Eu voltarei",
			"Implantando a contra-medida",
			"Não existem fins, apenas novos começos",
		},

		Death = {
			"Você só me matou porque eu fiquei sem saúde ..",
			"Aposto que pessoas mortas são mais fáceis de conviver.",
			"O verdadeiro inferno está dentro da pessoa.",
			"Aqueles que matam devem estar preparados para serem mortos.",
			"Eu te dei aquele",
			"Parabéns! Você está no scoarboard agora.",
			"As emoções são um transtorno mental",
			"Curta o momento",
			"Passado mas não esquecido",
			"Eu voltarei",
			"Implantando a contra-medida",
			"Não existem fins, apenas novos começos",
		}
	},

	EZfrags = {
		Kill = {
			"Visite www.EZfrags.co.uk para os melhores cheats públicos e privados de CS: GO",
			"Pare de ser um novato! Fique bem com www.EZfrags.co.uk",
			"Não estou usando www.EZfrags.co.uk, você é simplesmente ruim",
			"Você acabou de ser pego por EZfrags, o cheat # 1 CS: GO",
			"Se eu estivesse trapaceando, usaria www.EZfrags.co.uk",
			"Acha que poderia fazer melhor? Não sem www.EZfrags.co.uk",
		},

		Death = {
			"Você só me matou porque não estou usando www.EZfrags.co.uk",
			"Você tem sorte de eu não estar usando www.EZfrags.co.uk",
			"Eu teria destruído você se estivesse usando www.EZfrags.co.uk",
			"Você só me matou porque está usando www.EZfrags.co.uk o melhor cheat público e privado de CS: GO",
		}
	},

    AFK = {
        AfkSorry = {"Desculpe",},
        Kill = {"Estou AFK. Isto é um bot. Você morreu para um",},  
        Death = {"Você só me matou porque estou AFK.",}
    },
}


local function for_chatsay(e)
	if not enable_killsays:GetValue() then
		return
	end

	if e:GetName() ~= 'player_death' then
		return
	end

	local mode = killsay_mode:GetString()
	local lp = client.GetLocalPlayerIndex()
	local victim = client.GetPlayerIndexByUserID(e:GetInt('userid'))
	local attacker = client.GetPlayerIndexByUserID(e:GetInt('attacker'))
	local say = KillSays[mode]

	if attacker == lp and victim ~= lp then
		local msg = say.Kill[math.random(#say.Kill)]

		if mode == 'Apologetic' then
			local victim_name = client.GetPlayerNameByIndex(victim)

			local sry1 = say.Sorry[ math.random(#say.Sorry) ]
			local sry3 = say.Regret[ math.random(#say.Regret) ]

			msg = ('%s, I %s I %s you. %s'):format(victim_name, sry1, msg, sry3)
		end

        if mode == 'AFK' then
            local victim_name = client.GetPlayerNameByIndex(victim)
            local attacker_weapon = e:GetString('weapon')

            local afk1 = say.AfkSorry[ math.random(#say.AfkSorry) ]

            msg = ('%s %s, %s %s.'):format(afk1, victim_name, msg, attacker_weapon)
        end

		client.ChatSay( msg )
	elseif attacker ~= lp and victim == lp then
		if say.Death then
			client.ChatSay( say.Death[math.random(#say.Death)] )
		end
	end
end


--------Lua Callbacks & Listeners--------
client.AllowListener('player_death')
client.AllowListener('grenade_thrown')
callbacks.Register('FireGameEvent', for_chatsay)
callbacks.Register('FireGameEvent', for_throwsay)
callbacks.Register('Draw', for_clantags)
callbacks.Register("DispatchUserMessage", for_msgevents)
callbacks.Register('CreateMove', CrosshairRecoil)
callbacks.Register("Draw", UnlockInventory)
callbacks.Register("Unload", OnUnload)
