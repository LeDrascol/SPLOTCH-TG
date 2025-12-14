/datum/quirk/choke_slut
	name = "Choke Slut"
	desc = "You are aroused by suffocation."
	value = 0
	gain_text = span_purple("You fantasize about feeling someone's fingers around your neck, choking you until you pass out or make a mess... Maybe both.")
	lose_text = span_purple("You stop feeling aroused by suffocation.")
	medical_record_text = "Patient exhibits an abnormal obsession with restricted breathing."
	mob_trait = TRAIT_CHOKE_SLUT
	icon = FA_ICON_GRIN_BEAM_SWEAT
	erp_quirk = TRUE
	mail_goodies = list (
		/obj/item/reagent_containers/hypospray/medipen = 1 // Fix your oxy loss
	)

// Check if this quirk is valid for the species
/datum/quirk/choke_slut/is_species_appropriate(datum/species/mob_species)
	// Define species traits
	var/datum/species_traits = GLOB.species_prototypes[mob_species].inherent_traits

	// Check for no hunger
	if(TRAIT_NOBREATH in species_traits)
		return FALSE

	// Return default
	return ..()
