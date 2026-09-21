-- DemonicPact Announce -- emotes the spell power Demonic Pact just granted,
-- plus the weakest/strongest seen this fight. Pure observer: reads state,
-- emotes, does nothing else.

local SHADOW_SCHOOL = 6

-- Demonic Pact is a Demonology talent. Gate on the spec's capstone
-- (Metamorphosis) rather than tracking spec any other way. Checked live in
-- the handler, not cached at load, so a respec takes effect on the very next
-- proc.
local METAMORPHOSIS = 47241

local DEMONIC_PACT = GetSpellInfo(48090) or "Demonic Pact"
local DEMONIC_PACT_SHARE = 0.10 -- of the warlock's own spell power

-- The grant is computed, not read: the buff's tooltip carries no number, its
-- UnitBuff count reads 0, and the combat log carries no amount.
--
-- GetSpellBonusDamage already includes the buff being measured (we get our
-- own raid buff too), so the naive share overstates it:
--   spd = base + share*base  ->  granted = spd * share / (1 + share)
-- At 10% that's spd/11, not spd/10. Measured: 2794 -> 3074, grant = 280.
-- spd/11 = 279.5, ceil -> 280 (correct); spd/10 = 307.4 (wrong by 27).

---What the Pact landing right now locks in.
local function demonicPactGranted()
	local spd = GetSpellBonusDamage(SHADOW_SCHOOL)
	if not spd or spd <= 0 then
		return nil
	end
	return math.ceil(spd * DEMONIC_PACT_SHARE / (1 + DEMONIC_PACT_SHARE))
end

-- Weakest/strongest Pact applied this fight. Cleared on entering combat, not
-- on leaving, so the marks survive being read after the pull ends.
local pactFightMin, pactFightMax

---Split report: range is nil until two different values have been seen.
local function pactReportParts(granted)
	local range
	if pactFightMin and pactFightMax and pactFightMin ~= pactFightMax then
		range = string.format("%d - %d", pactFightMin, pactFightMax)
	end
	return range, string.format("+%d spell power", granted)
end

---Plain text, no colour codes -- this goes out to the whole raid.
local function pactReport(granted)
	local range, value = pactReportParts(granted)
	if range then
		-- "||" not "|": a bare "|" is an escape lead-in and throws "Invalid
		-- escape code in chat message". Doubling it prints one "|".
		return string.format("[Demonic Pact] %s || %s", range, value)
	end
	return string.format("[Demonic Pact] %s", value)
end

local function announce()
	local granted = demonicPactGranted()
	if not granted then
		return
	end
	if not pactFightMin or granted < pactFightMin then
		pactFightMin = granted
	end
	if not pactFightMax or granted > pactFightMax then
		pactFightMax = granted
	end

	-- Emote the raid in an instance; outside one it's just a solo debug
	-- read, so keep it local instead of spamming the open world.
	if IsInInstance() then
		SendChatMessage(pactReport(granted), "EMOTE")
	else
		print(pactReport(granted))
	end
end

-- Only our own proc counts. It shows as the Pact landing on our pet, cast by
-- our pet. The copy on us is no proof: with a second Demonology warlock in
-- the raid the two Pacts push each other off, and ours lands on us again
-- without any proc behind it. Another warlock's Pact on our pet comes from
-- their pet, so it never passes the source check.
local function onCombatLog(...)
	-- the cheapest test first: this runs for every event in the raid
	local _, sub, srcGUID, _, _, dstGUID, _, _, _, spellName = ...
	if spellName ~= DEMONIC_PACT then
		return
	end
	if sub ~= "SPELL_AURA_APPLIED" and sub ~= "SPELL_AURA_REFRESH" then
		return
	end
	local petGUID = UnitGUID("pet")
	if not petGUID or dstGUID ~= petGUID or srcGUID ~= petGUID then
		return
	end
	if not IsSpellKnown(METAMORPHOSIS) then
		return
	end
	announce()
end

local events = CreateFrame("Frame")
events:SetScript("OnEvent", function(self, event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		onCombatLog(...)
	elseif event == "PLAYER_REGEN_DISABLED" then
		pactFightMin, pactFightMax = nil, nil
	elseif event == "PLAYER_LOGIN" then
		-- only a warlock can own a Pact; everyone else never reads the combat log
		local _, class = UnitClass("player")
		if class ~= "WARLOCK" then
			return
		end
		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		self:RegisterEvent("PLAYER_REGEN_DISABLED")
	end
end)
events:RegisterEvent("PLAYER_LOGIN")
