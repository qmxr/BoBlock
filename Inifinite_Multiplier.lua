
local TimeToLoad = tick()
getgenv()["SecureMode"] = true;
local Rayfield, Window; do
	Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))(); Window = Rayfield:CreateWindow({Name = "Infinite Multipliers", LoadingTitle = "Infinite Multipliers Script", LoadingSubtitle = "by B0NEZ#9706"})
end;

local TeleportService, Replicated, RemoteEvents; do
	TeleportService = game:GetService("TeleportService"); Replicated = game:GetService("ReplicatedStorage"); RemoteEvents = Replicated["RemoteEvents"];
end;

-- // Tabs
local MainTab = Window:CreateTab("Main", 4483362458);

-- // Toggles
local AutoCash, AutoRollC, AutoRollS = false, false, false;
local AutoMulti, FixAutoMulti = false, false;

MainTab:CreateSection("Automatics")
local Multi = MainTab:CreateToggle({Name = "Auto Multi", Callback = function(Value) AutoMulti = Value; end})
local FMulti = MainTab:CreateToggle({Name = "Fix Upgrade with Auto Multi", Callback = function(Value) FixAutoMulti = Value; end})
MainTab:CreateLabel("This will Glitch the Button Auto Multi, but it will still function properly.")
local AC = MainTab:CreateToggle({Name = "Auto Cash Upgrade", Callback = function(Value) AutoCash = Value; end})
local ARC = MainTab:CreateToggle({Name = "Auto Roll Cooldown Upgrade", Callback = function(Value) AutoRollC = Value; end})
local ARS = MainTab:CreateToggle({Name = "Auto Rolls Upgrade", Callback = function(Value) AutoRollS = Value; end})

MainTab:CreateSection("Rebirth Upgrades")
MainTab:CreateButton({Name = "Upgrade Rebirth Points", Callback = function() RemoteEvents["RPUpgradeRE"]:FireServer("RPUpgRP") end})
MainTab:CreateButton({Name = "Upgrade Rebirth Multi", Callback = function() RemoteEvents["RPUpgradeRE"]:FireServer("MultiUpgRP") end})
MainTab:CreateButton({Name = "Upgrade Rebirth Cash", Callback = function() RemoteEvents["RPUpgradeRE"]:FireServer("CashUpgRP") end})

MainTab:CreateSection("Forms")
MainTab:CreateLabel("Please note you will have to stop every toggle to use the following Functions.")
MainTab:CreateButton({Name = "Rebirth", Callback = function() RemoteEvents["RebirthRE"]:FireServer() end})
MainTab:CreateButton({Name = "Reincarnate", Callback = function() RemoteEvents["ReinRE"]:FireServer() end})
MainTab:CreateButton({Name = "Materialize", Callback = function() RemoteEvents["UnlockMaterializeRE"]:FireServer() end})

MainTab:CreateSection("Extras")
MainTab:CreateButton({Name = "Stop all Toggles", Callback = function() FixAutoMulti = false; AutoCash = false; AutoRollC = false; AutoRollS = false; ARS:Set(false) ARC:Set(false) AC:Set(false) FMulti:Set(false) Multi:Set(false) end})
MainTab:CreateButton({Name = "Destroy UI", Callback = function() ARS:Set(false) ARC:Set(false) AC:Set(false) FMulti:Set(false) Multi:Set(false) Rayfield:Destroy() end})
MainTab:CreateButton({Name = "Rejoin Game", Callback = function() TeleportService:TeleportToPlaceInstance(game["PlaceId"], game["JobId"]) end})

local SetToggle = function(Toggle) if FixAutoMulti == true then Multi:Set(Toggle) end; end;

coroutine.wrap(function()
	while true and task.wait() do
		-- // Automatics
		if AutoMulti == true then RemoteEvents["MultiRE"]:FireServer() end;
	
		-- // Upgrades
		task.spawn(function()
			if AutoCash == true then SetToggle(false) RemoteEvents["CashUpgradeRE"]:FireServer("MultiUpgCash") wait(1) SetToggle(true) end;
			if AutoRollS == true then SetToggle(false) RemoteEvents["CashUpgradeRE"]:FireServer("MultiRollPerS") wait(1) SetToggle(true) end;
			if AutoRollC == true then SetToggle(false) RemoteEvents["CashUpgradeRE"]:FireServer("MultiRollCD") wait(1) SetToggle(true) end;
		end)
	end;
end)

Rayfield:Notify({Title = "Script has loaded!", Content = "Took: " .. tostring(tick() - TimeToLoad):sub(1,5) .. "s.", Image = 4483362458, Duration = 5})
