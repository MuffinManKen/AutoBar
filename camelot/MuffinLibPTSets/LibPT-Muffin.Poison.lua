--
-- LibPT-Muffin.Poison
--
-- Forever (Camelot) uses the classic rogue poison items.
-- Lethal:    Instant Poison I-VI (6947, 6949, 6950, 8926, 8927, 8928),
--            Deadly Poison I-V (2892, 2893, 8984, 8985, 20844)
-- Nonlethal: Crippling Poison I-II (3775, 3776), Mind-numbing Poison I-III (5237, 6951, 9186),
--            Wound Poison I-IV (10918, 10920, 10921, 10922), 202316
--
if not LibStub("LibPeriodicTable-3.1", true) then error("PT3 must be loaded before data") end
LibStub("LibPeriodicTable-3.1"):AddData("Muffin.Poison", "Rev: 5",
{
	["Muffin.Poison.Lethal"] = "2892, 2893, 6947, 6949, 6950, 8926, 8927, 8928, 8984, 8985, 20844",
	["Muffin.Poison.Nonlethal"] = "3775, 3776, 5237, 6951, 9186, 10918, 10920, 10921, 10922, 202316",
})
