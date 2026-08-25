-- What you get for butchering a coyote.
--
-- Required, not decorative: vanilla's setAnimalBodyData reads this table at
-- ButcheringUtil.lua:18, checks it for nil on line 19, and then indexes it
-- unguarded on line 27. An animal missing from here throws "attempted index:
-- feather of non-table: null" every time one dies, and the corpse silently
-- loses BloodQty, leather, head, skeleton and meatRatio. The long version of
-- this note is in KnoxLifeFoxes/.../KWC_FoxParts.lua.
--
-- Keys are animal type concatenated with breed name, exactly as vanilla builds
-- them. No leather, head or skull: we ship no coyote pelt item, and vanilla
-- treats their absence correctly. The biggest of the four addon species, so it
-- yields the most, and it is the only one worth more butchering XP than a
-- raccoon.

AnimalPartsDefinitions = AnimalPartsDefinitions or {};
AnimalPartsDefinitions.animals = AnimalPartsDefinitions.animals or {};

-- Female, 8 to 14 kg.
local kwc_coyotefemaledefault = AnimalPartsDefinitions.animals["kwc_coyotefemaledefault"] or {};
kwc_coyotefemaledefault.parts = kwc_coyotefemaledefault.parts or {};
table.insert(kwc_coyotefemaledefault.parts, {item = "Base.Smallanimalmeat", minNb = 8, maxNb = 11})
kwc_coyotefemaledefault.bones = kwc_coyotefemaledefault.bones or {};
table.insert(kwc_coyotefemaledefault.bones, {item = "Base.SmallAnimalBone", minNb = 5, maxNb = 8})
kwc_coyotefemaledefault.noSkeleton = true;
kwc_coyotefemaledefault.xpPerItem = 12;
AnimalPartsDefinitions.animals["kwc_coyotefemaledefault"] = kwc_coyotefemaledefault;

-- Male, 10 to 16 kg.
local kwc_coyotemaledefault = AnimalPartsDefinitions.animals["kwc_coyotemaledefault"] or {};
kwc_coyotemaledefault.parts = kwc_coyotemaledefault.parts or {};
table.insert(kwc_coyotemaledefault.parts, {item = "Base.Smallanimalmeat", minNb = 9, maxNb = 13})
kwc_coyotemaledefault.bones = kwc_coyotemaledefault.bones or {};
table.insert(kwc_coyotemaledefault.bones, {item = "Base.SmallAnimalBone", minNb = 5, maxNb = 8})
kwc_coyotemaledefault.noSkeleton = true;
kwc_coyotemaledefault.xpPerItem = 12;
AnimalPartsDefinitions.animals["kwc_coyotemaledefault"] = kwc_coyotemaledefault;

-- Pup, 1 to 4 kg.
local kwc_coyotepupdefault = AnimalPartsDefinitions.animals["kwc_coyotepupdefault"] or {};
kwc_coyotepupdefault.parts = kwc_coyotepupdefault.parts or {};
table.insert(kwc_coyotepupdefault.parts, {item = "Base.Smallanimalmeat", minNb = 3, maxNb = 5})
kwc_coyotepupdefault.bones = kwc_coyotepupdefault.bones or {};
table.insert(kwc_coyotepupdefault.bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 5})
kwc_coyotepupdefault.noSkeleton = true;
kwc_coyotepupdefault.xpPerItem = 8;
AnimalPartsDefinitions.animals["kwc_coyotepupdefault"] = kwc_coyotepupdefault;
