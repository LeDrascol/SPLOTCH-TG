/datum/quirk/breathless
	name = "Breathless"
	desc = "You no longer require air to function. This also means that administering life-saving maneuvers such as CPR are impossible."
	value = 6
	gain_text = span_notice("You no longer need to breathe.")
	lose_text = span_notice("You need to breathe again...")
	medical_record_text = "Patient demonstrates no requirement for oxygen intake."
	mob_trait = TRAIT_NOBREATH
	hardcore_value = -4
	icon = FA_ICON_BAN_SMOKING
	hidden_quirk = TRUE

// Check if this quirk is valid for the species
/datum/quirk/breathless/is_species_appropriate(datum/species/mob_species)
	// Define species traits
	var/datum/species_traits = GLOB.species_prototypes[mob_species].inherent_traits

	// Check for no hunger
	if(TRAIT_NOBREATH in species_traits)
		return FALSE

	// Return default
	return ..()
