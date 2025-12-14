/// Multiplier on hunger rate for Undeath users
#define UNDEATH_HUNGER_MULT 1.1
/// Traits to be added in addition to the hallowen zombie ones
#define UNDEATH_TRAITS_ADD list(TRAIT_NOTHIRST)
/// Traits inherit to halloween zombie that shouldn't be in a free quirk
#define UNDEATH_TRAITS_REMOVE list(\
		TRAIT_LIVERLESS_METABOLISM,\
		TRAIT_NOBREATH,\
		TRAIT_NODEATH,\
		TRAIT_NOCRITDAMAGE,\
		TRAIT_RADIMMUNE,\
		TRAIT_RESISTCOLD,\
		TRAIT_RESISTHIGHPRESSURE,\
		TRAIT_RESISTLOWPRESSURE,\
		TRAIT_TOXIMMUNE,\
	)
/// Full list of traits that should be added and removed
#define UNDEATH_TRAITS_LIST (UNDEATH_TRAITS_ADD + /datum/species/zombie::inherent_traits - UNDEATH_TRAITS_REMOVE)

/datum/quirk/undead
	name = "Undeath"
	desc = "You have risen as a lesser undead, gaining many boons and afflictions similar to a high-functioning zombie."
	value = 0
	gain_text = span_notice("The life has left your body, but you haven't stopped moving yet.")
	lose_text = span_notice("By some miracle, you've been brought back to life!")
	medical_record_text = "Patient is listed as deceased in medical records."
	mob_trait = TRAIT_UNDEAD
	icon = FA_ICON_HEAD_SIDE_VIRUS

// Check if this quirk is valid for the species
/datum/quirk/undead/is_species_appropriate(datum/species/mob_species)
	// Check if holder is inorganic
	if(!(mob_species.inherent_biotypes & MOB_ORGANIC))
		return FALSE

	// Check if holder is already undead
	if(mob_species.inherent_biotypes & MOB_UNDEAD)
		return FALSE

	// Return default
	return ..()

/datum/quirk/undead/add(client/client_source)
	// Define quirk holder mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Replace biotypes
	quirk_mob.mob_biotypes -= MOB_ORGANIC
	quirk_mob.mob_biotypes += MOB_UNDEAD

	// Add undead traits
	// Inherits most of the halloween-exclusive zombie species traits
	// As a free quirk, this should not grant the same widespread immunities
	quirk_mob.add_traits(UNDEATH_TRAITS_LIST, TRAIT_UNDEAD)

	// Add fake health HUD
	quirk_holder.apply_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, TRAIT_UNDEAD)

	// Increase hunger rate
	//quirk_mob.physiology.hunger_mod *= UNDEATH_HUNGER_MULT

/datum/quirk/undead/remove()
	// Define quirk holder mob
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	if(QDELETED(quirk_mob))
		return

	// Revert biotypes
	quirk_mob.mob_biotypes += MOB_ORGANIC
	quirk_mob.mob_biotypes -= MOB_UNDEAD

	// Remove undead traits
	quirk_mob.remove_traits(UNDEATH_TRAITS_LIST, TRAIT_UNDEAD)

	// Remove fake health HUD
	quirk_holder.remove_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy, TRAIT_UNDEAD)

	// Decrease hunger rate
	//quirk_mob.physiology.hunger_mod /= UNDEATH_HUNGER_MULT

#undef UNDEATH_HUNGER_MULT
#undef UNDEATH_TRAITS_ADD
#undef UNDEATH_TRAITS_REMOVE
#undef UNDEATH_TRAITS_LIST
