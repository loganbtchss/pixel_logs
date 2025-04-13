--[[
    Weapon Name Lookup System
    Version: 1.04122025
    Supports: FiveM and RedM
]]

local WeaponNames = {
    -- Common Weapons (Both FiveM and RedM)
    [tostring(GetHashKey('WEAPON_UNARMED'))] = 'Unarmed',
    [tostring(GetHashKey('WEAPON_KNIFE'))] = 'Knife',
    [tostring(GetHashKey('WEAPON_MELEE_KNIFE'))] = 'Knife',
    [tostring(GetHashKey('WEAPON_MELEE_KNIFE_JAWBONE'))] = 'Jawbone Knife',
    [tostring(GetHashKey('WEAPON_MELEE_LANTERN'))] = 'Lantern',
    [tostring(GetHashKey('WEAPON_MELEE_DAVY_LANTERN'))] = 'Davy Lantern',
    [tostring(GetHashKey('WEAPON_MELEE_TORCH'))] = 'Torch',
    [tostring(GetHashKey('WEAPON_MELEE_MACHETE'))] = 'Machete',
    [tostring(GetHashKey('WEAPON_MELEE_HATCHET'))] = 'Hatchet',
    [tostring(GetHashKey('WEAPON_MELEE_ANCIENT_HATCHET'))] = 'Ancient Hatchet',
    [tostring(GetHashKey('WEAPON_MELEE_CLEAVER'))] = 'Cleaver',
    [tostring(GetHashKey('WEAPON_MELEE_HAMMER'))] = 'Hammer',
    [tostring(GetHashKey('WEAPON_MELEE_BROKEN_SWORD'))] = 'Broken Sword',
    
    -- FiveM Specific Weapons
    [tostring(GetHashKey('WEAPON_NIGHTSTICK'))] = 'Nightstick',
    [tostring(GetHashKey('WEAPON_BAT'))] = 'Baseball Bat',
    [tostring(GetHashKey('WEAPON_GOLFCLUB'))] = 'Golf Club',
    [tostring(GetHashKey('WEAPON_CROWBAR'))] = 'Crowbar',
    [tostring(GetHashKey('WEAPON_PISTOL'))] = 'Pistol',
    [tostring(GetHashKey('WEAPON_COMBATPISTOL'))] = 'Combat Pistol',
    [tostring(GetHashKey('WEAPON_APPISTOL'))] = 'AP Pistol',
    [tostring(GetHashKey('WEAPON_PISTOL50'))] = 'Pistol .50',
    [tostring(GetHashKey('WEAPON_MICROSMG'))] = 'Micro SMG',
    [tostring(GetHashKey('WEAPON_SMG'))] = 'SMG',
    [tostring(GetHashKey('WEAPON_ASSAULTSMG'))] = 'Assault SMG',
    [tostring(GetHashKey('WEAPON_ASSAULTRIFLE'))] = 'Assault Rifle',
    [tostring(GetHashKey('WEAPON_CARBINERIFLE'))] = 'Carbine Rifle',
    [tostring(GetHashKey('WEAPON_ADVANCEDRIFLE'))] = 'Advanced Rifle',
    [tostring(GetHashKey('WEAPON_MG'))] = 'MG',
    [tostring(GetHashKey('WEAPON_COMBATMG'))] = 'Combat MG',
    [tostring(GetHashKey('WEAPON_PUMPSHOTGUN'))] = 'Pump Shotgun',
    [tostring(GetHashKey('WEAPON_SAWNOFFSHOTGUN'))] = 'Sawed-Off Shotgun',
    [tostring(GetHashKey('WEAPON_ASSAULTSHOTGUN'))] = 'Assault Shotgun',
    [tostring(GetHashKey('WEAPON_BULLPUPSHOTGUN'))] = 'Bullpup Shotgun',
    [tostring(GetHashKey('WEAPON_SNIPERRIFLE'))] = 'Sniper Rifle',
    [tostring(GetHashKey('WEAPON_HEAVYSNIPER'))] = 'Heavy Sniper',
    [tostring(GetHashKey('WEAPON_REMOTESNIPER'))] = 'Remote Sniper',
    [tostring(GetHashKey('WEAPON_GRENADELAUNCHER'))] = 'Grenade Launcher',
    [tostring(GetHashKey('WEAPON_GRENADELAUNCHER_SMOKE'))] = 'Smoke Grenade Launcher',
    [tostring(GetHashKey('WEAPON_RPG'))] = 'RPG',
    [tostring(GetHashKey('WEAPON_MINIGUN'))] = 'Minigun',
    [tostring(GetHashKey('WEAPON_GRENADE'))] = 'Grenade',
    [tostring(GetHashKey('WEAPON_STICKYBOMB'))] = 'Sticky Bomb',
    [tostring(GetHashKey('WEAPON_SMOKEGRENADE'))] = 'Tear Gas',
    [tostring(GetHashKey('WEAPON_BZGAS'))] = 'BZ Gas',
    [tostring(GetHashKey('WEAPON_MOLOTOV'))] = 'Molotov',
    [tostring(GetHashKey('WEAPON_FIREEXTINGUISHER'))] = 'Fire Extinguisher',
    [tostring(GetHashKey('WEAPON_PETROLCAN'))] = 'Jerry Can',
    [tostring(GetHashKey('WEAPON_BALL'))] = 'Ball',
    [tostring(GetHashKey('WEAPON_FLARE'))] = 'Flare',
    [tostring(GetHashKey('WEAPON_STUNGUN'))] = 'Stun Gun',
    
    -- RedM Specific Weapons
    [tostring(GetHashKey('WEAPON_REVOLVER_CATTLEMAN'))] = 'Cattleman Revolver',
    [tostring(GetHashKey('WEAPON_REVOLVER_CATTLEMAN_MEXICAN'))] = 'Mexican Cattleman',
    [tostring(GetHashKey('WEAPON_REVOLVER_DOUBLEACTION'))] = 'Double Action Revolver',
    [tostring(GetHashKey('WEAPON_REVOLVER_SCHOFIELD'))] = 'Schofield Revolver',
    [tostring(GetHashKey('WEAPON_REVOLVER_LEMAT'))] = 'LeMat Revolver',
    [tostring(GetHashKey('WEAPON_PISTOL_MAUSER'))] = 'Mauser Pistol',
    [tostring(GetHashKey('WEAPON_PISTOL_SEMIAUTO'))] = 'Semi-Auto Pistol',
    [tostring(GetHashKey('WEAPON_PISTOL_VOLCANIC'))] = 'Volcanic Pistol',
    [tostring(GetHashKey('WEAPON_RIFLE_VARMINT'))] = 'Varmint Rifle',
    [tostring(GetHashKey('WEAPON_RIFLE_SPRINGFIELD'))] = 'Springfield Rifle',
    [tostring(GetHashKey('WEAPON_RIFLE_BOLTACTION'))] = 'Bolt Action Rifle',
    [tostring(GetHashKey('WEAPON_RIFLE_ELEPHANT'))] = 'Elephant Rifle',
    [tostring(GetHashKey('WEAPON_SHOTGUN_DOUBLEBARREL'))] = 'Double Barrel Shotgun',
    [tostring(GetHashKey('WEAPON_SHOTGUN_SAWEDOFF'))] = 'Sawed-Off Shotgun',
    [tostring(GetHashKey('WEAPON_SHOTGUN_REPEATING'))] = 'Repeating Shotgun',
    [tostring(GetHashKey('WEAPON_SHOTGUN_PUMP'))] = 'Pump Shotgun',
    [tostring(GetHashKey('WEAPON_SHOTGUN_SEMIAUTO'))] = 'Semi-Auto Shotgun',
    [tostring(GetHashKey('WEAPON_SNIPERRIFLE_ROLLINGBLOCK'))] = 'Rolling Block Rifle',
    [tostring(GetHashKey('WEAPON_SNIPERRIFLE_CARCANO'))] = 'Carcano Rifle',
    [tostring(GetHashKey('WEAPON_BOW'))] = 'Bow',
    [tostring(GetHashKey('WEAPON_BOW_IMPROVED'))] = 'Improved Bow',
    [tostring(GetHashKey('WEAPON_LASSO'))] = 'Lasso',
    [tostring(GetHashKey('WEAPON_LASSO_REINFORCED'))] = 'Reinforced Lasso',
    [tostring(GetHashKey('WEAPON_MELEE_LANTERN_ELECTRIC'))] = 'Electric Lantern',
    [tostring(GetHashKey('WEAPON_THROWN_DYNAMITE'))] = 'Dynamite',
    [tostring(GetHashKey('WEAPON_THROWN_MOLOTOV'))] = 'Molotov',
    [tostring(GetHashKey('WEAPON_THROWN_THROWING_KNIVES'))] = 'Throwing Knives',
    [tostring(GetHashKey('WEAPON_THROWN_TOMAHAWK'))] = 'Tomahawk',
    [tostring(GetHashKey('WEAPON_THROWN_POISONBOTTLE'))] = 'Poison Bottle'
}

-- Helper function to safely get weapon name
function GetWeaponName(weaponHash)
    if not weaponHash then return 'Unknown' end
    
    local hashString = tostring(weaponHash)
    local weaponName = WeaponNames[hashString]
    
    if not weaponName then
        -- Try to get the weapon name from the game
        local success, name = pcall(function()
            return GetWeaponNameFromHash(weaponHash)
        end)
        
        if success and name and name ~= 'WEAPON_UNARMED' then
            -- Format the weapon name
            name = name:gsub('WEAPON_', ''):gsub('_', ' '):lower()
            name = name:gsub('(%l)(%w*)', function(a,b) return a:upper()..b end)
            return name
        end
    end
    
    return weaponName or 'Unknown'
end

-- Export the function
exports('GetWeaponName', GetWeaponName)