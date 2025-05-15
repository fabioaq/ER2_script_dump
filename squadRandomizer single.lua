local soldier = myself()

local sq = soldier.getSquad()

----------------------------------------------------
--          DEFINITIONS SECTION                   --
----------------------------------------------------

--Helmet and Uniform selection
local uniform = {
	uniforms = {
		"ger_ss_uniform_1",
		"ger_ss_uniform_2",
		"ger_ss_uniform_3",
		"ger_ss_uniform_2b",
		"ger_ss_uniform_4",
		"ger_m42_smock_b_bloused",
		"ger_m42_smock_b_gaiters",
		"ger_m42_smock_u_bloused",
		"ger_m42_smock_u_gaiters",
		"ger_m42_smock_ub_bloused",
		"ger_m42_smock_ub_gaiters",
	},

	headgear = {
		"ger_ss_helmet_2",
		"ger_ss_helmet_1",
		"ger_m40_sidecap_ss",
		"ger_m43_feldmutze_camo",
	}
}
----------------------------------------------------

-- Random seed init
math.randomseed(os.clock())
-- Throwaway for better RNG
math.random()

-- set Soldier uniform

--remove us_infantry_uniform_1
soldier.addNewItem(uniform.uniforms[math.random(#uniform.uniforms)], true)
soldier.removeItem("us_infantry_uniform_1", 1)
--set headgear
soldier.addNewItem(uniform.headgear[math.random(#uniform.headgear)], true)
