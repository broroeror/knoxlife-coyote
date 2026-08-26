-- Knox Life: Coyote -- registration.
--
-- The whole spawning side of this mod. There is no generator here and no map
-- analysis: Coyote_RouteData.lua is baked offline by the base mod's
-- tools/gen_routes.py from habitats.json, and hands its pool over with
-- registerRoutePool. All that is left is to say what this animal is and how
-- common it was.
--
-- ITS OWN GROUND. An addon species that declares no habitat inherits whichever
-- base pool its bucket falls back to, which is fine for something shaped like a
-- raccoon and wrong for this. Declaring `habitat` against a pool of our own
-- means it inherits nothing: its own terrain, its own geometry, no sharing.

if not KnoxLife or (KnoxLife.API_VERSION or 0) < 1 then
    print("[KnoxLifeCoyotes] KnoxLife not found (or too old); "
        .. "this addon needs API_VERSION 1. Not loading.")
    return
end

local KW = KnoxLife
local ID = "kwc_coyote"

-- Density is the only number that decides how common this animal is. The base
-- mod turns it into routes with
--
--     routes = density * habitat area / mean group size * realism fraction
--
-- so nothing here competes with any other species or mod. Change it and only
-- this animal moves.
--
-- Still colonising Kentucky in 1993 rather than settled, which is why it sits below the fox despite being the more conspicuous animal today.
local DENSITY = 1.5

-- The animal definitions come from tools/write_definitions.py. If one failed to
-- load, registering anyway would put a group in the spawn pool whose animal does
-- not exist, so check the FEMALE first: ID is the migration GROUP and was never
-- an animal id.
if AnimalDefinitions and AnimalDefinitions.animals
    and AnimalDefinitions.animals["kwc_coyotefemale"] == nil then
    print("[KnoxLifeCoyotes] no animal definition for kwc_coyotefemale; not registering. "
        .. "Its Definitions/animal file did not load.")
    return
end

if KW.registerSpecies(ID, {
    female = "kwc_coyotefemale", male = "kwc_coyotemale", baby = "kwc_coyotepup",
    possibleBreed = "default",
    minAnimal = 1, maxAnimal = 3, maxMale = 1,
    babyChance = 50,
    -- ⚠️ A PREDATOR MUST OUTPACE ITS PREY. This was 0.09, against a rabbit's
    -- 0.03 and a deer's 0.07, so a hunting animal closed on its target at a
    -- stroll and a provoked one walked up to the player. The food chain worked
    -- and looked absurd.
    --
    -- `speed` is a flat multiplier on the migration group and there is NO
    -- runtime speed control: IsoAnimal exposes none, and BaseAnimalBehavior's
    -- wanderMulMod is referenced only by its own declaration. So a predator
    -- cannot sprint only while hunting -- this lifts its pace generally, which
    -- suits an animal that patrols a territory rather than grazing across one.
    -- Vanilla's own (unfinished) "predator" group runs 0.5, so this is modest.
    trackSize = "medium", speed = 0.20,
    density = DENSITY,
    habitat = ID,
    enabledOption = "KnoxLifeCoyotes.Enabled",
    routeOption  = "KnoxLifeCoyotes.Routes",
    groupOption  = "KnoxLifeCoyotes.GroupSize",
}) then
    -- The bucket decides only the FALLBACK pool, and this declares its own
    -- habitat, so the weight is vestigial. Passed because addToBucket is public
    -- API from version 1 and an addon written then supplies one.
    KW.addToBucket("small", ID, 50)
    print("[KnoxLifeCoyotes] registered on its own habitat (API v" .. KW.API_VERSION .. ")")
end
