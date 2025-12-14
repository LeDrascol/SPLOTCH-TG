// Reagent process: Salt
/datum/reagent/consumable/salt/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()

	SEND_SIGNAL(affected_mob, COMSIG_REAGENT_PROCESS_SALT, src, seconds_per_tick, times_fired)

// Reagent expose: Salt
/datum/reagent/consumable/salt/expose_mob(mob/living/affected_mob, methods, reac_volume)
	. = ..()

	SEND_SIGNAL(affected_mob, COMSIG_REAGENT_EXPOSE_SALT, src, methods, reac_volume)

/datum/reagent/consumable/alienhoney
	name = "Honey (Safe)"
	description = "Sweet, sweet honey that does not decay into sugar."
	color = "#d3a308"
	nutriment_factor = 5 * REAGENTS_METABOLISM
	metabolization_rate = 1 * REAGENTS_METABOLISM
	taste_description = "sweetness"

/datum/reagent/consumable/peanut_butter/packing
	name = "Packing Peanut Butter"
	description = "A tasteless, starchy spread produced by grinding packing peanuts."
	taste_description = "starch"
	color = "#FFB9EA" //pinkut...
	nutriment_factor = 0.5 //absolutely no nutritive value
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	default_container = /obj/item/reagent_containers/condiment/peanut_butter/packing

/datum/reagent/consumable/peanut_butter/packing/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	. = ..()
	var/obj/item/organ/liver/liver = affected_mob.get_organ_slot(ORGAN_SLOT_LIVER)
	if(liver && HAS_TRAIT(liver, TRAIT_CARGO_METABOLISM))
		if(affected_mob.heal_bodypart_damage(brute = 1 * REM * seconds_per_tick, burn = 1 * REM * seconds_per_tick, updating_health = FALSE))
			return UPDATE_MOB_HEALTH
