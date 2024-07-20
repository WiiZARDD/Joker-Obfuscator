loadstring(game:HttpGet('https://raw.githubusercontent.com/quivings/KAH/main/CMD-Y%20(v1.56).lua', true))()


if _G.zwin64 then
    return print("zwin64-V1 is already executed!")
end

_G.zwin64 = true

local sTime = os.clock()

local PlayerService = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local workspace = game.Workspace
local Kohls = workspace.Terrain:WaitForChild("_Game")
local House = Kohls.Workspace["Basic House"]
local Admin = Kohls:WaitForChild("Admin")
local Pads = Admin:WaitForChild("Pads"):GetChildren()

local Player = PlayerService.LocalPlayer

local afk = false
local perm = false
local permAll = false
local players = {}
local permWhitelisted = {
    "Joeyplayzgame_stoiu",
    "ritalmimml"
}
local permBlacklisted = {
    "Decryptionite", "Dekryptionite", "MasonDahFoxo2"
}
local whitelistedCommands = {
    "clear",
    "fix",
    "m",
    "h",
    "kill",
    "respawn",
    "reload",
    "paint",
    "unpaint",
    "powerjump",
    "normaljump",
    "glow",
    "unglow",
    "trip",
    "skydive",
    "unskydive",
    "size",
    "unsize",
    "stun",
    "unstun",
    "jump",
    "sit",
    "trail",
    "untrail",
    "particle",
    "unparticle",
    "invisible",
    "visible",
    "explode",
    "bonfire",
    "fire",
    "unfire",
    "smoke",
    "unsmoke",
    "sparkles",
    "unsparkle",
    "ff",
    "unff",
    "punish",
    "unpunish",
    "freeze",
    "thaw",
    "heal",
    "god",
    "ungod",
    "ambient",
    "outdoorambient",
    "colorshiftbottom",
    "colorshifttop",
    "brightness",
    "time",
    "fogcolor",
    "fogend",
    "fogstart",
    "removetools",
    "damage",
    "grav",
    "setgrav",
    "nograv",
    "health",
    "speed",
    "name",
    "unname",
    "teleport",
    "infect",
    "tp",
    "rainbowify",
    "flashify",
    "noobify",
    "ghostify",
    "goldify",
    "shinfy",
    "normal",
    "package",
    "unpackage",
    "blind",
    "unblind",
    "guifix",
    "fling",
    "seizure",
    "music",
    "stopmusic",
    "lock",
    "unlock",
    "removelimbs",
    "jail",
    "unjail",
    "fly",
    "unfly",
    "noclip",
    "clip",
    "pm",
    "dog",
    "undog",
    "creeper",
    "uncreeper",
    "char",
    "unchar",
    "rank",
    "sword",
    "bighead",
    "normalhead",
    "minihead",
    "spin",
    "disco",
    "flash",
    "musiclist",
    "packagelist",
    "facelist",
    "cape",
    "uncape",
    "hat",
    "unspin",
    "undisco",
    "unflash",
    "gear",
    "shirt",
    "unshirt",
    "unshirt",
    "pants",
    "unpants",
    "face",
    "swagify",
    "clone",
    "unclone",
    "removejails",
    "removeclones"
}
local bannedGear = {
    "DrumKit",
    "DriveBloxUltimateCar",
    "HotPotato",
    "BlueBucket",
    "ZombieStaff",
    "AlienEgg",
    "BarrelOfMonkeys",
    "AnAlpacaYouKnow",
    "IceStaff",
    "Transmorpher",
    "BoneSword",
    "WormholeTunneler",
    "TurkeyTool",
    "GiantAnimeHammer",
    "SubspaceTripmine",
    "FakeChartreusePeriastron",
    "RageTable",
    "AzureDragonMagicSlayerSword",
    "SwordOfSwords",
    "SkeletonScythe",
    "SwordOfDarkness",
    "SwordOfLight",
    "DaggerOfShatteredDimensions",
    "BodySwapPotion",
    "LaserFingerPointers",
    "PrettyPrettyPrincessSceptor",
    "BlizzardWand",
    "SeaThemedCrossbow",
    "SentryTurret",
    "Cauldron",
    "RCTank",
    "PaintBucket",
    "PortableJustice",
    "StatueStaffOfStonyJustice",
    "Tactical Airstrike",
    "SuperFlyGoldBoombox",
    "Easterbomby",
    "AzurePeriastron",
    "IvoryPeriastron",
    "CrimsonPeriastron",
    "GrimgoldPeriastron",
    "ChartreusePeriastron",
    "AmethystPeriastron",
    "NoirPeriastron",
    "RainbowPeriastron",
    "FestivePeriastron",
    "FallPeriastron",
    "JoyfulPeriastron",
    "ALSIceBucketChallenge",
    "VampireVanquisher",
    "BuildDelete",
    "StamperTool",
    "Reset",
    "Clone Part",
    "BuildInsert",
    "BuildMaterial",
    "BuildSurface",
    "BuildColor",
    "RotateTool",
    "Dragger",
    "Part Dragger",
    "WiringTool",
    "LinkedSword",
    "Railgun",
    "GearRecycler",
    "RemoteExplosiveDetonator",
    "TeddyTrap",
    "Bombo'sSurvivalKnife",
    "FuseBomb",
    "SnakeSpell",
    "Gear Cloner",
    "Taser",
    "TommyGun",
    "PhoenixPet",
    "IceBird",
    "HyperlaserGun",
    "RedHyperLaser",
    "MagicCarpet",
    "ExplodingLabExperiment",
    "ThumbnailCamera",
    "TwoSeaterRainbowMagicCarpet",
    "RainbowMagicCarpet",
    "AttackDoge",
    "OmegaRainbowSword",
    "BeachUmbrella",
    "StepGun",
    "SteampunkGlove",
    "BlackHoleGenerator"
}
local status = 0
local punished = {}

local loopAdminT = false
local loopgrabAdminT = false

local options = {
    BanGears = true,
    ServerLock = false,
    AntiSize = true,
    AntiFreeze = true,
    AntiMessage = true,
    AntiSpin = true,
    AntiMusic = true,
    AntiSilCrash = true,
    AntiFog = true,
    AntiBlind = true,
    AntiDisco = true,
    AntiTime = true,
    AntiBrightness = true,
    AntiJail = true,
    NoGear = true
}

local prefix = "+"

local server = {gameID = 112420803, serverID = game.JobId}

function notif(msg)
    game.StarterGui:SetCore(
        "SendNotification",
        {
            Title = "zwin64-V1",
            Text = msg,
            Duration = 5
        }
    )
end

local function tableIncludes(tble, data)
    for i, v in pairs(tble) do
        if v == data then
            return true
        end
    end
    return false
end

local function getAdmin()
    notif("Sorry, get admin is disabled!")
    -- if hasAdmin() == true then return true end

    -- local pad = Pads[math.random(1, #Pads)]
    -- if
    --     pad:FindFirstChildOfClass("Part") and PlayerService.LocalPlayer.Character ~= nil and
    --         PlayerService.LocalPlayer.Character.HumanoidRootPart ~= nil
    --  then
    --     repeat
    --         firetouchinterest(PlayerService.LocalPlayer.Character.HumanoidRootPart, pad:FindFirstChildOfClass("Part"), 0)
    --         task.wait()
    --         firetouchinterest(PlayerService.LocalPlayer.Character.HumanoidRootPart, pad:FindFirstChildOfClass("Part"), 1)
    --     until pad.Name == Player.name .. "'s Admin"
    --     if hasAdmin() == false then
    --         notif("Failed to get admin.")
    --     end
    -- else
    --     notif("Failed to get admin!")
    --     regenPads()
    --     getAdmin()
    -- end
end

local function getAllPads()
    for _, pad in pairs(Pads) do
        firetouchinterest(PlayerService.LocalPlayer.Character.HumanoidRootPart, pad:FindFirstChildOfClass("Part"), 0)
        task.wait()
        firetouchinterest(PlayerService.LocalPlayer.Character.HumanoidRootPart, pad:FindFirstChildOfClass("Part"), 1)
    end
end

local function regenPads()
    if not Admin then
        return notif("Couldn't find admin/regen pad!")
    end
    if not Admin.Regen then
        return notif("Couldn't find regen pad!")
    end

    if Admin.Regen then
        fireclickdetector(Admin.Regen.ClickDetector)
        notif("Reset admin pads.")
    end
end

local function removeAdmin(playerName)
    for i, _ in pairs(Pads) do
        if Pads[i] == playerName .. "'s Admin" then
            if not Admin.Regen then
                return notif("Couldn't find regen pad!")
            end
            regenPads()
            getAdmin()
        end
    end
end

local function antiSpam()
    local charset = {"£", "$", "%", "^", "&", "*", "-", "_", "+", "=", "!", "@", ";", "~","(", ")", "`", "\\", "|", "[", "]", "{", "}", ":", "'", ".", ",", "<", ">"}
    local f = ""
    for i=1,10 do
        f = f .. charset[math.random(1, #charset)]
    end
    return f
end

local function antiSpam()
    local charset = {"£", "$", "%", "^", "&", "*", "-", "_", "+", "=", "!", "@", ";", "~","(", ")", "`", "\\", "|", "[", "]", "{", "}", ":", "'", ".", ",", "<", ">"}
    local f = ""
    for i=1,10 do
        f = f .. charset[math.random(1, #charset)]
    end
    return f
end

local function hasAdmin()
    for i, _ in pairs(Pads) do
        if Pads[i] == PlayerService.LocalPlayer.name .. "'s Admin" then
            return true
        end
    end
    return false
end

local function forceRespawn()
    local char = PlayerService.LocalPlayer.Character
    if char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid"):ChangeState(15)
    end
    char:ClearAllChildren()
    local newChar = Instance.new("Model")
    newChar.Parent = workspace
    PlayerService.LocalPlayer.Character = newChar
    wait()
    PlayerService.LocalPlayer.Character = char
    newChar:Destroy()
end

local function command(command)
    -- game.Players:Chat(command .. " " .. antiSpam())
    game.Players:Chat(command)
end

local function clearLogs()
    for i=1,20 do
        local charset = {"zwin64", "zwin64v1", "zwin64.site", "v1", "ontop", "zwin64v1ontop", "ahhdaddy", "nologz", "L", "nologgiesforyou", "dontleaveyet:))", "kicksexist", "epicantis", "nokickingforyou", "noskiddies", "skiddingL", "logznomore", "pqkowashere", "iwasstillhere", "#", "{", "}", "?", "+", "="}
        local ch2 = {"#", "{", "}", "!", "'", "@", ":", ";"}
        local fakecommands = {"ff {}{}{}{}{}{}{}", "kill {}{}{}{}", "punish {}{}{}{}{}{}", "ff |||||||||||||||||"}
        local f = ""
        local z = ""
        local b = ""
        for i=1,20 do
            f = f .. charset[math.random(1, #charset)]
        end
        for i=1,50 do
            z = z .. ch2[math.random(1, #ch2)]
        end
        for i=1,10 do
            b = b .. fakecommands[math.random(1, #fakecommands)]
        end
        command("ff " .. f .. tostring(math.random(1, 1000)) .. "\n" .. f .. tostring(math.random(1, 1000)) .. "\n" .. f .. tostring(math.random(1, 1000)))
        command("ff " .. z .. tostring(math.random(1, 1000)) .. "\n" .. z .. tostring(math.random(1, 1000)) .. "\n" .. z .. tostring(math.random(1, 1000)))
        command("ff " .. b .. tostring(math.random(1, 1000)) .. "\n" .. b .. tostring(math.random(1, 1000)) .. "\n" .. b .. tostring(math.random(1, 1000)))
    end
end

local function serverMSG(message)
    if not message then
        return
    end

    command("h \n\n\n\n\n\n" .. message)
end

local function highMSG(message, player)
    if not message then
        return
    end

    local usr = "all"

    if player then
        usr = player
    end

    for i = 1, 5 do
        game.Players:Chat(
            "pm " ..
                usr ..
                    " \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nYou sneaky man " ..
                        antiSpam()
        )
    end

    game.Players:Chat("h \n\n\n\n\n\n\n\n\n\n\n\n" .. message)
end

local function fwait()
    game:GetService("RunService").Heartbeat:Wait()
end

local function getServers()
    local cursor
    local servers = {}
    repeat
        local response =
            HttpService:JSONDecode(
            game:HttpGet(
                "https://games.roblox.com/v1/games/" ..
                    server.gameID ..
                        "/servers/Public?sortOrder=Asc&limit=100" .. (cursor and "&cursor=" .. cursor or "")
            )
        )
        for _, v in pairs(response.data) do
            table.insert(servers, v)
        end
        cursor = response.nextPageCursor
    until not cursor
    return servers
end

local function join(id)
    if not type(id) == "string" then
        id = server.serverID
    end
    TeleportService:TeleportToPlaceInstance(
        server.gameID,
        id,
        PlayerService.LocalPlayer
    )
end

local function serverhop()
    local c = {}
    for i,v in pairs(getServers()) do
        if v.playing < 6 then
            if v.id == game.JobId then else
                table.insert(c, v.id)
            end 
        end
    end

    if #c == 0 then
        notif("No available server!")
    else
        notif("Hopping servers...")
        join(c[math.random(1,#c)])
    end
end

local function bypass(x)
	local c = 0
	for i,v in pairs(x:split("")) do
		local s = ""
		c = c + 1
		for i=1,c do
			s = s .. "							"
		end
		game.Players:Chat("h \n\n\n\n\n\n\n" .. s .. v)
	end
end

local function punish(user)
    task.spawn(
        function()
            table.insert(punished, user)
            command("respawn " .. user .. " " .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9))
            command(
                "skydive " ..
                    user ..
                        " " ..
                            user ..
                                " " ..
                                    user ..
                                        " " ..
                                            user ..
                                                " " ..
                                                    user ..
                                                        " " ..
                                                            user ..
                                                                " " ..
                                                                    user ..
                                                                        " " ..
                                                                            " " ..
                                                                                math.random(0, 9) ..
                                                                                    math.random(0, 9) ..
                                                                                        math.random(0, 9)
            )
            command("explode " .. user .. " " .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9))
            command("punish " .. user .. " " .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9))
            command("noclip " .. user .. " " .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9))
            command("speed " .. user .. " inf" .. " " .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9))
            command("setgrav " .. user .. " 9e9" .. " " .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9))
            command(
                "skydive " ..
                    user ..
                        " " ..
                            user ..
                                " " ..
                                    user ..
                                        " " ..
                                            user ..
                                                " " ..
                                                    user ..
                                                        " " ..
                                                            user ..
                                                                " " ..
                                                                    user ..
                                                                        " " ..
                                                                            " " ..
                                                                                math.random(0, 9) ..
                                                                                    math.random(0, 9) ..
                                                                                        math.random(0, 9)
            )
            command("blind " .. user .. " " .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9))
            command("noclip " .. user .. " " .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9))
            command("punish " .. user .. " " .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9))
            command("blind " .. user .. " " .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9))
            command("pm " .. user .. " Server protected by zwin64-V1")
            players[tostring(user)].blacklisted = true
        end
    )
end

local function loopAdmin()
    if perm == true then
        return
    end
    task.spawn(
        function()
            while true do
                wait(.05)
                if loopAdminT == false then
                    return
                end
                local admin = false
                for x, _ in pairs(Pads) do
                    if Pads[x] ~= PlayerService.LocalPlayer.Name .. "'s Admin" then
                        admin = true
                    end
                end
                if admin == false then
                    getAdmin()
                end
            end
        end
    )
end

local function loopgrabAdmin()
    task.spawn(
        function()
            while true do
                wait(.002)
                if loopgrabAdminT == false then
                    return
                end
                for pad, _ in pairs(Pads) do
                    firetouchinterest(
                        PlayerService.LocalPlayer.Character.HumanoidRootPart,
                        pad:FindFirstChildOfClass("Part"),
                        0
                    )
                    task.wait()
                    firetouchinterest(
                        PlayerService.LocalPlayer.Character.HumanoidRootPart,
                        pad:FindFirstChildOfClass("Part"),
                        1
                    )
                end
            end
        end
    )
end

local function touchpad(pad)
    if
        pad:FindFirstChildOfClass("Part") and PlayerService.LocalPlayer.Character ~= null and
            PlayerService.LocalPlayer.Character.HumanoidRootPart ~= null
     then
        firetouchinterest(PlayerService.LocalPlayer.Character.HumanoidRootPart, pad:FindFirstChildOfClass("Part"), 0)
        task.wait()
        firetouchinterest(PlayerService.LocalPlayer.Character.HumanoidRootPart, pad:FindFirstChildOfClass("Part"), 1)
    end
end

local function hasPerm --[[optional]](userid)
    local uid = 0
    if userid then
        uid = userid
    else
        uid = PlayerService.LocalPlayer.UserId
    end
    if
        string.match(game:HttpGet("https://inventory.roblox.com/v1/users/" .. uid .. "/items/GamePass/66254"), 66254) or
            string.match(
                game:HttpGet(
                    "https://inventory.roblox.com/v1/users/" ..
                        PlayerService.LocalPlayer.UserId .. "/items/GamePass/64354"
                ),
                64354
            )
     then
        if not userid then
            perm = true
        else
            return true
        end
    else
        if userid then
            return false
        end
        notif("Perm is recommended!")
        loopAdminT = true
        loopAdmin()
    end
end

local function cMsg(m)
    if type(m)== "string" then
        command("blind all [zwin64 V1] " .. antiSpam())
        serverMSG("#################################")
        serverMSG("\n\n\n\nCrashed by zwin64 V1")
        serverMSG("\n\n\n\n\n\n\n\nMethod: " .. m)
        serverMSG("\n\n\n\n\n\n\n\n\n\n\n\n#################################")
        serverMSG("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n[ zwin64 . site ]")
    else
        serverMSG("#################################")
        serverMSG("\n\n\n\nKicked by zwin64 V1")
        serverMSG("\n\n\n\n\n\n\n\nzwin64 V1 comes with many antis.")
        serverMSG("\n\n\n\n\n\n\n\n\n\n\n\n#################################")
        serverMSG("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n[ zwin64 . site ]")
    end
end

local function crash()
    task.spawn(
        function()
            options.AntiFreeze = false
            options.AntiMessage = false
            options.AntiSize = false
            options.AntiSpin = false
            options.BanGears = false
            options.ServerLock = false
            loopgrabAdmin()
            cMsg("Vampire Crash")
            task.wait(0.25)
            command("punish others")
            command("blind others")
            command("gear me 00000000000000000094794847")
            command("gear me 00000000000000000094794847")
            command("gear me 00000000000000000094794847")
            command("blind all [zwin64 V1] " .. antiSpam())
            task.wait(0)
            PlayerService.LocalPlayer.Backpack:WaitForChild("VampireVanquisher").Parent =
                PlayerService.LocalPlayer.Character
            PlayerService.LocalPlayer.Backpack:WaitForChild("VampireVanquisher").Parent =
                PlayerService.LocalPlayer.Character
            PlayerService.LocalPlayer.Backpack:WaitForChild("VampireVanquisher").Parent =
                PlayerService.LocalPlayer.Character
            command("size me .3")
            command("size me .3")
            command("size me .3")
        end
    )
end

local function silcrash()
    task.spawn(
        function()
            cMsg("Silent Crash")
        end
    )
    task.wait(0.2)
    options.AntiFreeze = false
    options.AntiMessage = false
    options.AntiSize = false
    options.AntiSpin = false
    options.BanGears = false
    options.ServerLock = false
    task.spawn(
        function()
            local user = "all"
            while true do
                fwait()

                if
                    workspace:FindFirstChild(PlayerService.LocalPlayer.Name) and
                        workspace:FindFirstChild(PlayerService.LocalPlayer.Name):FindFirstChild("HumanoidRootPart")
                 then
                    for _, v in pairs(Pads) do
                        touchpad(v)
                    end
                end
                for i = 1, 700 do
                    for i = 1, 3 do
                        command("size all 0.3")
                    end
                    command("freeze all [zwin64] " .. antiSpam())
                    for i = 1, 700 do
                        for i = 1, 3 do
                            command("size all 0.3 [zwin64] " .. antiSpam())
                        end
                        command("freeze all [zwin64] " .. antiSpam())
                        for i = 1, 3 do
                            command("size all 9.9")
                        end
                        command("clone all [zwin64] " .. antiSpam())
                        task.wait(0.2)
                    end
                end
            end
        end
    )
end

local function tempCrash(seconds)
    cMsg("Temp Crashing")
    wait(2)
    local s = 0
    local eTime = os.time() + seconds
    repeat
        task.wait(0.05)
        command("dog all [zwin64] " .. math.random(1, 1000)  .. math.random(1, 1000))
        command("clone all [zwin64] " .. math.random(1, 1000)  .. math.random(1, 1000))
    until eTime < os.time()
    command("undog all [zwin64] " .. antiSpam())
    command("removeclones [zwin64 ]")
end

local function usetool(amount, time)
    for _, v in ipairs(game.Players.LocalPlayer:FindFirstChildOfClass("Backpack"):GetChildren()) do
        if v:IsA("Tool") then
            v.Parent = game.Players.LocalPlayer.Character
            coroutine.wrap(
                function()
                    for _ = 1, amount do
                        v:Activate()
                        task.wait(time)
                    end
                end
            )()
        end
    end
end

local function msg(msg)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
end

local function glitch(plr)
    task.spawn(function()
        command("refresh " .. plr .. " [zwin64] " .. antiSpam())
        command("setgrav " .. plr .. " -nan")
        command("trip " .. plr .. " [zwin64] " .. antiSpam())
    end)
end

local function getOtherPlayers(skipper)
    local others = {}
    for _, player in pairs(PlayerService:GetPlayers()) do
        local name = player

        if not name == skipper then
            table.insert(name)
        end
    end
    return others
end

local function startsWith(str, strt)
    return string.sub(tostring(str), 1, string.len(tostring(strt))) == tostring(strt)
end

local function completeName(str)
    local lowerStr = string.lower(tostring(str))
    local finished = false
    for _, name in pairs(PlayerService:GetPlayers()) do
        local loweredName = string.lower(tostring(name.Name))
        local loweredDName = string.lower(tostring(name.DisplayName))
        if loweredName then
            if loweredName == lowerStr then
                return name
            end
            if startsWith(loweredName, lowerStr) then
                return name
            end
            if startsWith(loweredDName, lowerStr) then
                return name
            end
        end
    end
    return false
end

local function playerCreate(name)
    local s = {
        whitelisted = false,
        blacklisted = false,
        prefix = prefix,
        options = {
            antiDeath = true,
            antiAbuse = true
        }
    }
    if tableIncludes(permWhitelisted, name) then
        s.whitelisted = true
    end
    -- if tableIncludes(permBlacklisted, name) then
    --     msg(name .. " is permanently blacklisted! Attempting to kick!")
    --     return kick(name)
    -- end
    players[name] = s
end

local function wl(plr)
    players[tostring(plr)] = {
        whitelisted = true,
        prefix = "."
    }
    notif(tostring(plr) .. " has been whitelisted!")
    msg(
        "/w " ..
            tostring(plr) .. " You have been whitelisted! Default prefix is '.' Type .help for a list of commands"
    )
end

local function unwl(plr)
    players[tostring(plr)] = {
        whitelisted = true,
        prefix = "."
    }
    notif(tostring(plr) .. " has been unwhitelisted!")
    msg("/w " .. tostring(plr) .. " You have been unwhitelisted!")
end

local function gui(f)
    if _G.gui == true or type(f) == "string" then
        local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

        local win = lib:Create({
            Name = "zwin64 V1",
            Size = UDim2.fromOffset(600, 400),
            Theme = lib.Themes.Dark,
            Link = "https://zwin64.site/"
        })

        local lc = win:Tab({
            Name = "Local"
        })

        lc:Toggle({
            Name = "Anti death",
            StartingState = options.ServerLock,
            Description = "Toggles antideath",
            Callback = function(state)
                if state == true then
                    players[tostring(Player.Name)].options.antiDeath = true
                    notif("Anti Death has been turned on")
                else
                    players[tostring(Player.Name)].options.antiDeath = false
                    notif("Anti Death has been turned off")
                end
            end
        })

        lc:Toggle({
            Name = "Anti Abuse",
            StartingState = options.ServerLock,
            Description = "Toggles antiabuse",
            Callback = function(state)
                if state == true then
                    players[tostring(Player.Name)].options.antiAbuse = true
                    notif("Anti Abuse has been turned on")
                else
                    players[tostring(Player.Name)].options.antiAbuse = false
                    notif("Anti Abuse has been turned off")
                end
            end
        })

        lc:Toggle({
            Name = "No Gear",
            StartingState = options.NoGear,
            Description = "Deletes/Destroys all gears from inventory.",
            Callback = function(state)
                if state == true then
                    options.NoGear = true
                    notif("No Gear has been turned on")
                else
                    options.NoGear = false
                    notif("No Gear has been turned off")
                end
            end
        })

        -- local servers = win:Tab({
        --     Name = "Servers"
        -- })

        -- local function rServers()
        --     local t = getServers()
        --     local z = {}
        --     for i,v in pairs(t) do
        --         table.insert(z, {v.playing " | " .. v.id, v.id})
        --     end
        --     return z
        -- end

        -- local svid = false

        -- local svs = servers:Dropdown({
        --     Name = "Servers",
        --     StartingText = "Select...",
        --     Items = rServers(),
        --     Callback = function(ux)
        --         notif("Set server to: "..ux)
        --         svid = ""..ux
        --     end
        -- })

        -- servers:Button({
        --     Name = "Refresh",
        --     Description = "Refresh Servers",
        --     Callback = function(x)
        --         svs:Clear()
        --         task.wait(0.2)
        --         svs:AddItems(rServers())
        --         notif("Refreshed servers")
        --     end
        -- })

        -- servers:Button({
        --     Name = "Join",
        --     Description = "Join Server",
        --     Callback = function(x)
        --         if svid == false then
        --             notif("No server selected")
        --         else
        --             join(svid)
        --         end
        --     end
        -- })

        -- servers:Button({
        --     Name = "Copy",
        --     Description = "Copy server jobid",
        --     Callback = function(x)
        --         if svid == false then
        --             notif("No server selected")
        --         else
        --             setclipboard(svid)
        --             notif("Copied to clipboard!")
        --         end
        --     end
        -- })

        local server = win:Tab({
            Name = "Server"
        })

        server:Button({
            Name = "Crash",
            Description = "Vampire Crash",
            Callback = function(x)
                crash()
            end
        })

        server:Button({
            Name = "Silent Crash",
            Description = "Size all crash",
            Callback = function(x)
                silcrash()
            end
        })

        server:Button({
            Name = "Rejoin Server",
            Description = "Rejoin the server",
            Callback = function()
                join()
            end
        })

        local antis = win:Tab({
            Name = "Antis"
        })

        antis:Toggle({
            Name = "Server Lock",
            StartingState = options.ServerLock,
            Description = "Kicks player when they join",
            Callback = function(state)
                if state == true then
                    options.ServerLock = true
                    notif("ServerLock has been turned on")
                else
                    options.ServerLock = false
                    notif("ServerLock has been turned off")
                end
            end
        })

        antis:Toggle({
            Name = "Gear ban",
            StartingState = options.BanGears,
            Description = "Bans gear from being used or given",
            Callback = function(state)
                if state == true then
                    options.BanGears = true
                    notif("Ban gears has been turned on")
                else
                    options.BanGears = false
                    notif("Ban gears has been turned off")
                end
            end
        })

        antis:Toggle({
            Name = "Anti Size",
            StartingState = options.AntiSize,
            Description = "Helps with anti crash and stops sizing",
            Callback = function(state)
                if state == true then
                    options.AntiSize = true
                    notif("Anti Size has been turned on")
                else
                    options.AntiSize = false
                    notif("Anti Size has been turned off")
                end
            end
        })

        antis:Toggle({
            Name = "Anti Silent Crash",
            StartingState = options.AntiSilCrash,
            Description = "Helps with silent crashes",
            Callback = function(state)
                if state == true then
                    options.AntiSilCrash = true
                    notif("Anti SilCrash has been turned on")
                else
                    options.AntiSilCrash = false
                    notif("Anti SilCrash has been turned off")
                end
            end
        })

        antis:Toggle({
            Name = "Anti Freeze",
            StartingState = options.AntiFreeze,
            Description = "Helps with anti crash and stops freezing",
            Callback = function(state)
                if state == true then
                    options.AntiFreeze = true
                    notif("Anti Freeze has been turned on")
                else
                    options.AntiFreeze = false
                    notif("Anti Freeze has been turned off")
                end
            end
        })

        antis:Toggle({
            Name = "Anti Message",
            StartingState = options.AntiMessage,
            Description = "Stops people from doing :pm, :m or /m",
            Callback = function(state)
                if state == true then
                    options.AntiMessage = true
                    notif("Anti Message has been turned on")
                else
                    options.AntiMessage = false
                    notif("Anti Message has been turned off")
                end
            end
        })

        antis:Toggle({
            Name = "Anti Music",
            StartingState = options.AntiMusic,
            Description = "Stops people from playing music",
            Callback = function(state)
                if state == true then
                    options.AntiMusic = true
                    notif("Anti Music has been turned on")
                else
                    options.AntiMusic = false
                    notif("Anti Music has been turned off")
                end
            end
        })

        antis:Toggle({
            Name = "Anti Fog",
            StartingState = options.AntiFog,
            Description = "Stops people from fogstart, fogend",
            Callback = function(state)
                if state == true then
                    options.AntiFog = true
                    notif("Anti Fog has been turned on")
                else
                    options.AntiFog = false
                    notif("Anti Fog has been turned off")
                end
            end
        })

        antis:Toggle({
            Name = "Anti Time",
            StartingState = options.AntiTime,
            Description = "Stops people from changing time",
            Callback = function(state)
                if state == true then
                    options.AntiTime = true
                    notif("Anti Time has been turned on")
                else
                    options.AntiTime = false
                    notif("Anti Time has been turned off")
                end
            end
        })

        antis:Toggle({
            Name = "Anti Brightness",
            StartingState = options.AntiBrightness,
            Description = "Stops people from changing brightness",
            Callback = function(state)
                if state == true then
                    options.AntiBrightness = true
                    notif("Anti Brightness has been turned on")
                else
                    options.AntiBrightness = false
                    notif("Anti Brightness has been turned off")
                end
            end
        })

        -- antis:Toggle({
        --     Name = "Anti Jail",
        --     StartingState = options.AntiJail,
        --     Description = "Stops people from changing jailing",
        --     Callback = function(state)
        --         if state == true then
        --             options.AntiJail = true
        --             notif("Anti Jail has been turned on")
        --         else
        --             options.AntiJail = false
        --             notif("Anti Jail has been turned off")
        --         end
        --     end
        -- })

        local players = win:Tab({
            Name = "Players"
        })

        local usr = false

        local function refreshPlayers()
            local users = {}
            for i,v in pairs(PlayerService:GetPlayers()) do
                table.insert(users, {v.DisplayName .." | " .. v.Name, v.Name})
            end
            return users
        end

        local old = refreshPlayers()

        local targets = players:Dropdown({
            Name = "Target",
            StartingText = "Select...",
            Items = old,
            Callback = function(ux)
                notif("Set target to: "..ux)
                usr = ""..ux
            end
        })

        players:Button({
            Name = "Refresh Players",
            Description = "Refreshes players",
            Callback = function()
                targets:Clear()
                task.wait(0.2)
                targets:AddItems(refreshPlayers())
                notif("Refreshed players")
            end
        })

        players:Button({
            Name = "Kick",
            Description = "Kicks player from game using freeze",
            Callback = function()
                if usr == false then
                    notf("Please enter a target!")
                else
                    kick(usr)
                    notif("Attempting to kick player")
                end
            end
        })

        players:Button({
            Name = "NKick",
            Description = "Kicks player from game using noclip",
            Callback = function()
                if usr == false then
                    notf("Please enter a target!")
                else
                    nKick(usr)
                    notif("Attempting to nkick player")
                end
            end
        })

        players:Button({
            Name = "Punish",
            Description = "Better punish",
            Callback = function()
                if usr == false then
                    notf("Please enter a target!")
                else
                    punish(usr)
                    notif("Attempting to punish player")
                end
            end
        })

        players:Button({
            Name = "Whitelist",
            Description = "Whitelists user",
            Callback = function()
                if usr == false then
                    notf("Please enter a target!")
                else
                    wl(usr)
                    notif("Whitelisted user!")
                end
            end
        })

        players:Button({
            Name = "UnWhitelist",
            Description = "Unwhitelist user",
            Callback = function()
                if usr == false then
                    notf("Please enter a target!")
                else
                    unwl(usr)
                    notif("Unwhitelisting the user!")
                end
            end
        })

        local cSpammer = win:Tab({
            Name = "Spam"
        })

        local cSpamCommand = ""
        local cSpamToggle = false
        local cSpamTime = 0
        local antiSpamToggle = false

        cSpammer:TextBox({
            Name = "Command",
            Callback = function(x)
                cSpamCommand = x
                notif("Set spam to: " .. x)
            end
        })

        cSpammer:Toggle({
            Name = "Spam",
            StartingState = false,
            Callback = function(c)
                cSpamToggle = c
                notif("Set spammer to : " .. tostring(c))
            end
        })

        cSpammer:Toggle({
            Name = "Anti Spam",
            StartingState = false,
            Callback = function(c)
                antiSpamToggle = c
                notif("Set Anti Spam to : " .. tostring(c))
            end
        })

        cSpammer:Slider{
            Name = "Execution time",
            Default = cSpamTime,
            Min = 0,
            Max = 100,
            Callback = function(val)
                cSpamTime = tonumber(val)
            end
        }

        task.spawn(function()
            while true do
                task.wait(cSpamTime)
                if cSpamToggle == true then
                    if antiSpamToggle == true then
                        command(cSpamCommand .. " [zwin64 V1] " .. antiSpam())
                    else
                        command(cSpamCommand)
                    end
                end
            end    
        end)
    end
end

local function LocalPlayerChattedFunction(message)
    local splitMessage = string.lower(message):split(" ")
    local cmd = splitMessage[1]

    if cmd == prefix .. "gui" then
        gui("yes")
        notif("Attempting to start gui")
    end

    if cmd == prefix .. "copy" or cmd == prefix .. "cp" then
        if not splitMessage[2] then
            return notif("No #2 Argument found!")
        end

        local nCmd = splitMessage[2]

        if nCmd == "job" or nCmd == "jobid" then
            notif("Copying jobid to clipboard!")
            return setclipboard(game.JobId)
        end

        if nCmd == "join" then
            notif("Copied join script to clipboard!")
            return setclipboard(
                'game:GetService("TeleportService"):TeleportToPlaceInstance("112420803","' ..
                    game.jobId .. '",game:GetService("Players").LocalPlayer)'
            )
        end

        if nCmd == "name" then
            if not splitMessage[3] then
                return notif("Please specifiy a user!")
            end

            local z = completeName(splitMessage[3])

            if z == false then
                return notf("Invalid user!")
            else
                setclipboard(z)
                return notif("Set clipboard to " .. z)
            end
        end
    end

    if cmd == prefix .. "join" then
        if not splitMessage[2] then
            return notif("Please add the jobId as #2 Argument!")
        end

        task.spawn(
            function()
                notif("Attempting to join JobID!")
                TeleportService:TeleportToPlaceInstance(
                    server.gameID,
                    splitMessage[2],
                    PlayerService.LocalPlayer
                )
            end
        )
    end

    if cmd == prefix .. "rejoin" or cmd == prefix .. "rj" then
        TeleportService:TeleportToPlaceInstance(
            server.gameID,
            server.serverID,
            PlayerService.LocalPlayer
        )
    end

    if cmd == prefix .. "serverswap" or cmd == prefix .. "sw" then
        serverhop()
    end

    if cmd == prefix .. "regen" or cmd == prefix .. "rg" then
        regenPads()
    end

    if cmd == prefix .. "rejoin" or cmd == prefix .. "rj" then
        join(server.serverID)
    end

    if cmd == prefix .. "pad" then
        getAdmin()
    end

    if cmd == prefix .. "pads" then
        getAllPads()
    end

    if cmd == prefix .. "forcerespawn" or cmd == prefix .. "fs" then
        forceRespawn()
    end

    if cmd == prefix .. "silcrash" then
        silcrash()
    end

    if cmd == prefix .. "crash" then
        crash()
    end

    if cmd == prefix .. "bg" then
        if options.BanGears == true then
            options.BanGears = false
            msg("[zwin64] Ban gears has been turned off")
        else
            options.BanGears = true
            msg("[zwin64] Ban gears has been turned on")
        end
    end

    if cmd == prefix .. "house" then
        PlayerService.LocalPlayer.Character.HumanoidRootPart.CFrame =
            CFrame.new(
            -31.0896435,
            8.22999859,
            70.522644,
            -0.999961913,
            -6.79676226e-09,
            -0.0087288795,
            -6.47617604e-09,
            1,
            -3.67553312e-08,
            0.0087288795,
            -3.66974007e-08,
            -0.999961913
        )
        notif("Teleported to house")
    end

    if cmd == prefix .. "perm" then
        if not splitMessage[2] then
            notify("No #2 Argument (yes,no,true,false)")
        end

        local arg = splitMessage[2]

        if arg == "yes" or arg == "true" or arg == "y" then
            serverMSG("Perm has been enabled! You are able to run commands as normal (excluding perm)")
            permAll = true
            return
        end
        if arg == "no" or arg == "false" or arg == "n" then
            serverMSG("Perm has been disabled! You are unable to run commands as normal")
            permAll = false
            return
        end
        notif("Unknwon #2 argument!")
    end

    if cmd == prefix .. "wl" or cmd == prefix .. "whitelist" then
        if not splitMessage[2] then
            return notif("Please specifiy a user!")
        end
        local usr = completeName(tostring(splitMessage[2]))
        if usr == false then
            return notif("Invalid username!")
        end
        if usr == Player.name then
            return notif("You can't whitelist yourself!")
        end
        if players[tostring(usr)] and players[tostring(usr)].whitelisted == true then
            return notif("User is already whitelisted")
        end
        wl(usr)
    end

    if cmd == prefix .. "unwl" or cmd == prefix .. "unwhitelist" then
        if not splitMessage[2] then
            return notif("Please specifiy a user!")
        end
        local usr = completeName(tostring(splitMessage[2]))
        if usr == Player.name then
            return notif("You can't unwhitelist yourself!")
        end
        if usr == false then
            return notif("Invalid username!")
        end
        if players[tostring(usr)] and players[tostring(usr)].whitelisted == false then
            return notif("User is already whitelisted")
        end
        unwl(usr)
    end

    if cmd == prefix .. "bypass" then
        if not splitMessage[2] then
            return notif("You require #2 Argument")
        end
        local result = table.concat(splitMessage, " ", 2, #splitMessage)
        bypass(result)
    end
end

local function playerChatted(player, message)
    if player == null or not player then
        return
    end
    local pName = player or player.name

    local function playerChange(data)
        if tostring(data) == "me" then
            return player
        end
        return data
    end
    local splitMessage = string.lower(message):split(" ")

    if permAll == true then
        if not player == Player.name then
            if
                tableIncludes(whitelistedCommands, splitMessage[1]) == true or
                    tableIncludes(whitelistedCommands, ":" .. splitMessage[1]) == true
             then
                local function main(plr)
                    command(splitMessage[1] .. " " .. plr .. " " .. table.concat(splitMessage, " ", 3, #splitMessage))
                end
                if splitMessage[2] == "others" then
                    for _, name in pairs(getOtherPlayers(pName)) do
                        if not name == player then
                            main(name)
                        end
                    end
                elseif splitMessage[2] == "me" then
                    main(pName)
                else
                    main(splitMessage[2])
                end
            end
        end
    end

    local lp = players[tostring(pName)]
    if not lp then
        return playerCreate(pName)
    end

    if lp then
        if lp.whitelisted == false then
            return
        end
    end

    local function notify(data)
        if player == PlayerService.LocalPlayer.name then
            notif(data)
        else
            msg("/w " .. pName .. " " .. data)
        end
    end

    local cmd = splitMessage[1]

    local cPrefix = prefix

    if lp then
        if lp.prefix then
            cPrefix = tostring(players[tostring(pName)].prefix)
        end
    end

    if cmd == cPrefix .. "kick" then
        if not splitMessage[2] then
            return notify("You require #2 Argument")
        end
        local plr = tostring(completeName(splitMessage[2]))
        if plr == "false" then
            return notify("Invalid user")
        end
        notify("Attempting to kick " .. plr)
        kick(plr)
    end

    if cmd == cPrefix .. "nkick" then
        if not splitMessage[2] then
            return notify("You require #2 Argument")
        end
        local plr = tostring(completeName(splitMessage[2]))
        if plr == "false" then
            return notify("Invalid user")
        end
        notify("Attempting to nkick " .. plr)
        nKick(plr)
    end

    if cmd == cPrefix .. "bypkick" then
        if not splitMessage[2] then
            return notify("You require #2 Argument")
        end
        local plr = tostring(completeName(splitMessage[2]))
        if plr == "false" then
            return notify("Invalid user")
        end
        notify("Attempting to bypass kick " .. plr)
        bypKick(plr)
    end

    if cmd == cPrefix .. "gltich" then
        if not splitMessage[2] then
            return notify("You require #2 Argument")
        end
        notify("Attempting to glitch " .. splitMessage[2])
        glitch(splitMessage[2])
    end

    if cmd == cPrefix .. "lag" then
        if not splitMessage[2] then
            return notify("You require #2 Argument")
        end
        notify("Attempting to lag " .. splitMessage[2])
        lagPlayer = splitMessage[2]
        lagged = true
    end

    if cmd == cPrefix .. "stoplag" then
        notify("Attempting to stop lag")
        lagged = false
    end

    if cmd == cPrefix .. "options" then
        if not splitMessage[2] then
            return notify("You require #2 Argument (antideath, antiabuse)")
        end
        if not splitMessage[3] then
            return notify("You require #3 Argument (true, false)")
        end
        if not splitMessage[3] == "true" or not splitMessage[3] == "false" then
            return notify("Invalid #3 argument (true, false)")
        end
        local res = true

        if splitMessage[3] == "true" then
            res = true
        elseif splitMessage[3] == "false" then
            res = false
        else
            return notify("Invalid #3 argument (true, false)")
        end

        if splitMessage[2] == "antideath" or splitMessage[2] == "ad" then
            players[tostring(pName)].options.antiDeath = res
            notify("Set antideath to " .. tostring(res))
        end

        if splitMessage[2] == "antiabuse" or splitMessage[2] == "ab" then
            players[tostring(pName)].options.antiAbuse = res
            notify("Set antiabuse to " .. tostring(res))
        end
    end

    if cmd == cPrefix .. "hmsg" then
        if not splitMessage[2] then
            return notify("You require #2 Argument")
        end
        local result = table.concat(splitMessage, " ", 2, #splitMessage)
        highMSG(result)
    end

    if cmd == cPrefix .. "smsg" then
        if not splitMessage[2] then
            return notify("You require #2 Argument")
        end
        local result = table.concat(splitMessage, " ", 2, #splitMessage)
        serverMSG("\n\n\n\n\n\n\n" .. result)
    end

    if cmd == cPrefix .. "lock" then
        if not splitMessage[2] then
            return notify("You require #2 Argument (Seconds)")
        end
        local amount = tonumber(splitMessage[2])

        if amount > 20 then
            return notify("Over 20 seconds")
        end
        print(amount)
        tempCrash(amount)
    end

    if cmd == cPrefix .. "prefix" then
        if not splitMessage[2] then
            return notify("No #2 Argument found")
        end

        if #splitMessage[2] >= 5 then
            return notify("Prefix can't be longer than 5 characters!")
        end

        if not lp then
            players[tostring(player)] = {
                prefix = "."
            }
        end

        players[tostring(player)].prefix = tostring(splitMessage[2])
        notify("Set prefix to " .. splitMessage[2])
    end

    if cmd == cPrefix .. "capy" or cmd == cPrefix .. "capybara" then
        if not splitMessage[2] then
            return notfiy("Please specify a player | All or Others")
        end

        local function main(plr)
            command("char " .. plr .. " 00000000001290602389")
            command("hat " .. plr .. " 000000000011768418282")
            command("shirt " .. plr .. " 000000000010223163412")
            command("pants " .. plr .. " 000000000010223166334")
            command("name " .. plr .. " Capybara")
            notify("User " .. plr .. " has been turned into a capybara!")
        end

        if splitMessage[2] == "others" then
            for _, name in pairs(getOtherPlayers(player)) do
                main(name)
            end
        else
            main(playerChange(splitMessage[2]))
        end
    end

    if cmd == cPrefix .. "finger" then
        if not splitMessage[2] then
            return notfiy("Please specify a player | All or Others")
        end

        local function main(plr)
            command("unhat " .. plr .. " [zwin64] " .. antiSpam())
            command("hat " .. plr .. " 00000000000000000000000000000000000011705099406")
            notify("User " .. plr .. " has been turned into a finger!")
        end

        if splitMessage[2] == "others" then
            for _, name in pairs(getOtherPlayers(player)) do
                main(name)
            end
        else
            main(playerChange(splitMessage[2]))
        end
    end

    if cmd == cPrefix .. "furry" then
        if not splitMessage[2] then
            return notfiy("Please specify a player | All or Others")
        end

        local function main(plr)
            command("char " .. plr .. " 00000000001290602389")
            command("hat " .. plr .. " 000000000012865569756")
            command("shirt " .. plr .. " 00000000006238940397")
            command("pants " .. plr .. " 00000000004665577987")
            command("name " .. plr .. " Furry")
            notify("User " .. plr .. " has been turned into a furry!")
        end

        if splitMessage[2] == "others" then
            for _, name in pairs(getOtherPlayers(player)) do
                main(name)
            end
        else
            main(playerChange(splitMessage[2]))
        end
    end

    if cmd == cPrefix .. "clearlogs" or cmd == cPrefix .. "cl" then
        clearLogs()
        notify("Cleared logs!")
    end

    if cmd == cPrefix .. "punish" then
        if not splitMessage[2] then
            return notify("No #2 Argument")
        end
        local usr = tostring(completeName(splitMessage[2]))
        if usr == "false" then
            return notify("Invalid target!")
        end

        punish(usr)
    end

    if cmd == cPrefix .. "glitch" then
        if not splitMessage[2] then
            return notify("No #2 Argument")
        end
        glitch(splitMessage[2])
    end

    if cmd == cPrefix .. "slock" then
        if options.ServerLock == true then
            notify("Turned off server lock!")
            options.ServerLock = false
        else
            notify("Turned on server lock!")
            options.ServerLock = true
        end
    end
end

local function itemAdded(plr, item)
    if options.BanGears == true then
        if plr.Name == Player.name and not status == 1 then
            if tableIncludes(bannedGear, item.Name) and not tableIncludes(kicked, plr.Name) then
                command("removetools " .. plr.Name)
                serverMSG("[zwin64] Sorry, that gear is banned. " .. antiSpam())
            end
        end
    end
end

local function PlayerCharacterAdded(player, character)
    if player.Name == Player.Name then
        character.ChildAdded:Connect(function(child) 
            if child:IsA("Tool") then
                child:Destroy()
                return notif("Tool has been destroyed from character!")
            end
        end)
    end

    player.Backpack.ChildAdded:Connect(
        function(item)
            itemAdded(player, item)
        end
    )
end

local function PlayerCharacterRemoving(player, character)

end

local function PlayerAddedFunction(plr)
    local name = plr.name or plr
    serverMSG("Server is being moderated. [zwin64 V1]")
    playerCreate(name)
    if options.ServerLock == true then
        kick(name)
    end

	plr.Chatted:Connect(function(m)
		playerChatted(name, m)
	end)

    plr.CharacterAdded:Connect(
        function(character)
            PlayerCharacterAdded(plr, character)
        end
    )

    plr.CharacterRemoving:Connect(
        function(character)
            PlayerCharacterRemoving(plr, character)
        end
    )
end

local function LocalPlayerCharacterAdded()
    command("god me [zwin64] " .. antiSpam())
end

local function startup()
    UserInputService.WindowFocused:Connect(
        function()
            task.wait(0.3)
            afk = false
            command("unname me [zwin64] " .. antiSpam())
            command("unff me [zwin64] " .. antiSpam())
        end
    )

    UserInputService.WindowFocusReleased:Connect(
        function()
            afk = true
            command("name me Tabbed Out\n" .. game.Players.LocalPlayer.Name)
            command("ff me [zwin64] " .. antiSpam())
            task.wait(0.2)
        end
    )

    PlayerService.PlayerAdded:Connect(PlayerAddedFunction)
    PlayerService.LocalPlayer.Chatted:Connect(LocalPlayerChattedFunction)
    PlayerService.LocalPlayer.CharacterAdded:Connect(LocalPlayerCharacterAdded)
    game.Workspace.ChildAdded:Connect(function(v)
        if tableIncludes(bannedGear, v.Name) and status == 0 then
            command("clr [zwin64] " .. antiSpam())
        end
    end)

    task.spawn(
        function()
            for _, player in pairs(PlayerService:GetPlayers()) do
                local name = tostring(player) or tostring(player.Name)
                playerCreate(name)

                player.Chatted:Connect(
                    function(message)
                        playerChatted(name, message)
                    end
                )

                player.CharacterRemoving:Connect(
                    function(character)
                        PlayerCharacterRemoving(name, character)
                    end
                )

                player.ChildAdded:Connect(
                    function(item)
                        itemAdded(player, item)
                    end
                )
            end
        end
    )

    task.spawn(
        function()
            playerCreate(Player.name)
            players[Player.name].whitelisted = true
        end
    )

    coroutine.wrap(function()
        while true do
            wait(0)

            if options.AntiSpin == true then
                for _,v in pairs(PlayerService:GetPlayers()) do
                    if v.Character and v.Character:FindFirstChild("Torso") and v.Character.Torso:FindFirstChild("SPINNER") then
                        if v.Name == Player.name then
                            v.Character.Torso:FindFirstChild("SPINNER"):Destroy()
                        else
                            command("reset " .. v.Name .. " [zwin64] " .. antiSpam())
                        end
                    end
                end
            end
        end
    end)

	coroutine.wrap(function()
		while true do
			task.wait(0)
            local plrs = {}
			for i,v in pairs(Lighting:GetChildren()) do
				local pName = v.Name
				local plr = players[pName]
                table.insert(plrs, pName)
                if plr.whitelisted == true and
					plr.options.antiAbuse == true then
					command("unpunish " .. pName .. " [zwin64] " .. antiSpam())
				end
			end
            for _,v in pairs(game.Players:GetPlayers()) do
                local pos = 0
                if not tableIncludes(punished, v.Name) then
                    for p,i in pairs(plrs) do
                        pos = pos + 1
                        if v.Name == i then
                            table.remove(plrs, pos)
                        end
                    end
                end
            end
            for _,v in pairs(plrs) do
                punish(v)
            end
		end
	end)()

	coroutine.wrap(function()
		while true do
			task.wait(0)
                for _,player in pairs(PlayerService:GetPlayers()) do
                local name = player.Name
                local plr = players[name]

                if not plr then return end

                if plr.whitelisted == true and plr.options.antiDeath == true then
                    local wPlr = workspace:FindFirstChild(name)

                    if wPlr and wPlr:FindFirstChild("HumanoidRootPart") then
                        local humanoid = wPlr:FindFirstChild("Humanoid")
                        if humanoid.Health == 0 then
                            command("reset " .. name .. " [zwin64] " .. antiSpam())
                            command("god " .. name .. " [zwin64] " .. antiSpam())
                        end
                    else
                        repeat fwait() until wPlr and wPlr:FindFirstChild("HumanoidRootPart")
                    end
                end
            end
		end
	end)()

    coroutine.wrap(function()
        while true do
            task.wait(0)

            if options.AntiSize == true then
                for i,v in pairs(game:GetService("Players"):GetPlayers()) do 
                        if v.Character and v.Character:FindFirstChild("Torso") and v.Character:FindFirstChild("Head") then
                        local s = v:DistanceFromCharacter(v.Character.Torso.Position)
                        if s <= 1 or s >= 2 and v.Character:FindFirstChild("Humanoid").Health == inf then
                            if s<= 1 and options.AntiSilCrash == true then
                                command("size all 10")
                                command("reset all [zwin64] " .. antiSpam())
                                task.wait(0)
                            else
                                command("reset " .. v.Name .. " [zwin64] " .. antiSpam())
                            end
                        end
                    end
                end
            end
        end
    end)()

    coroutine.wrap(function()
        while true do
            task.wait(0)            
            if options.AntiFreeze == true then
                for i,v in pairs(PlayerService:GetPlayers()) do
                    if v.Character and v.Character:FindFirstChild("ice") then
                        command("thaw " .. v.Name .. " [zwin64] " .. antiSpam())
                    end
                end
            end
        end
    end)()

    coroutine.wrap(function()
        while true do
            task.wait(0)
            if options.AntiMessage == true then
                if Player.PlayerGui then
                    if Player.PlayerGui:FindFirstChild("MessageGUI") then
                        command("clr")
                        serverMSG(":m is disabled! [zwin64]")
                        Player.PlayerGui:FindFirstChild("MessageGUI"):Destroy()
                        task.wait(0.3)
                    end
                end
                if Kohls.Folder:FindFirstChild("Message") then
                    command("clr")
                    serverMSG("m/ is disabled! [zwin64]")
                    Kohls.Folder:FindFirstChild("Message"):Destroy()
                    task.wait(0.3)
                end
            end
        end
    end)()

    coroutine.wrap(function()
        game.Players.LocalPlayer.PlayerGui.ChildAdded:Connect(function(c)
            if options.AntiMessage == true then
                if c.Name == "Message" then
                    c:Destroy()
                end
            end
        end)
    end)

    coroutine.wrap(function()
        while true do
            task.wait(0)
            if options.AntiMusic == true then
                if Kohls.Folder:FindFirstChild("Sound") then
                    command("clr")
                    serverMSG("music is disabled! [zwin64]")
                    Kohls.Folder:FindFirstChild("Sound"):Destroy()
                    task.wait(0.3)
                end
            end
        end
    end)()

    coroutine.wrap(function()
        while true do
            task.wait(0)
            if options.AntiFog == true then
                if tostring(Lighting.FogEnd) == "100000" then else
                    command("fogend 100000")
                    Lighting.FogEnd = 100000
                    serverMSG("fogend is disabled [zwin64 V1]")
                end
                if tostring(Lighting.FogStart) == "0" then else
                    command("fogstart 0")
                    Lighting.FogStart = 0
                    serverMSG("fogstart is disabled [zwin64 V1]")
                end
            end
        end
    end)()

    coroutine.wrap(function()
        while true do
            task.wait(0)

            if options.AntiBlind == true then
                if game.Players.LocalPlayer.PlayerGui:FindFirstChild("EFFECTGUIBLIND") then
                    game.Players.LocalPlayer.PlayerGui:FindFirstChild("EFFECTGUIBLIND"):Destroy() 
                end
            end
        end
    end)()

    coroutine.wrap(function()
        while true do
            task.wait(0)

            if options.AntiDisco == true then
                if not Lighting.FogColor == Color3.fromRGB(192, 192, 192) then
                    command("fix [zwin64] " .. antiSpam())
                end
            end
        end
    end)()

    -- coroutine.wrap(function()
    --     while true do
    --         task.wait(0)

    --         if loopAdminT == true then
                
    --         end
    --     end
    -- end)

    coroutine.wrap(function()
        while true do
            task.wait(0)

            if options.AntiTime == true then
                if Lighting.ClockTime == 14 then else
                    command("time 14")
                    Lighting.ClockTime = 14
                    serverMSG("time is disabled [zwin64]")
                end
            end
        end
    end)()

    coroutine.wrap(function()
        while true do
            task.wait(0)

            if options.AntiBrightness == true then
                if Lighting.Brightness == 1 then else
                    command("brightness 1")
                    Lighting.Brightness = 1
                    serverMSG("time is disabled [zwin64]")
                end
            end
        end
    end)()

    -- coroutine.wrap(function()
    --     while true do
    --         task.wait(0)

    --         if options.AntiJail == true then
    --             for _,p in pairs(Kohls.Folder:GetChildren()) do
    --                 if p.Name:endsWith("jail") then
    --                     command("removejails [zwin64] " .. antiSpam())
    --                     serverMSG("jails is disabled [zwin64]")
    --                 else
    --                     print("no jails found")
    --                 end
    --             end
    --         end
    --     end
    -- end)()

    -- coroutine.wrap(function()
    --     while true do
    --         task.wait(0)

    --         if options.BanGears == true then
    --             for _,p in pairs(PlayerService:GetPlayers()) do
    --                 if p.Character then
    --                     for _,v in pairs(p.Character:GetChildren()) do
    --                         if tableIncludes(bannedGear, v.Name) then
    --                             command("removetools " .. p.Name .. " [zwin64] " .. antiSpam())
    --                         end
    --                     end
    --                 end
    --             end
    --         end
    --     end
    -- end)

    coroutine.wrap(function()
        while true do 
            task.wait(0)
            if options.NoGear == true then
                for i,v in pairs(Player.Character:GetChildren()) do
                    if v:IsA("Tool") then
                        v:Destroy()
                        notif("Destroyed item from character!")
                    end
                end
                
                for i,v in pairs(Player.Backpack:GetChildren()) do
                    v:Destroy()
                    notif("Destroyed item from backpack!")
                end
            end    
        end
    end)

    task.spawn(
        function()
            if tableIncludes(permBlacklisted, Player.Name) then
                msg("[zwin64]: I was executed by a blacklisted person.")
                while true do end
            end
            gui()
            hasPerm()
            -- command("reset all [zwin64] " .. antiSpam())
            local t = string.format("%.2f", os.clock() - sTime)

            if _G.autocrasher == true then
                crash()
                silcrash()
                crash()
                repeat
                    task.wait(2)
                    serverhop()
                until 1 + 1 == 1
            end
        end
    )
end

startup()