// Original comments imply hunger changes are designed
// to encourage the quirk holder to seek a 'partner'
#define QUIRK_HUNGER_CONCUBUS 1.1 // 10% hungrier

/datum/quirk/concubus
	name = "Concubus"
	desc = "Your seducer-like metabolism has adapted to digest both breast milk and semen into nourishment. This has a side effect of making you slightly hungrier."
	value = 0
	gain_text = span_purple("You feel a craving for certain bodily fluids.")
	lose_text = span_purple("Your bodily fluid cravings fade back away.")
	medical_record_text = "Patient claims to subsist entirely on lactose and reproductive fluids."
	mob_trait = TRAIT_CONCUBUS
	icon = FA_ICON_GLASS_CHEERS
	erp_quirk = TRUE
	mail_goodies = list (
		/obj/item/reagent_containers/cup/soda_cans/carbonatedcum = 1,
		/obj/item/reagent_containers/condiment/milk = 1
	)

/datum/quirk/concubus/add(client/client_source)
	// Define quirk holder
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Check for valid holder
	if(!istype(quirk_mob))
		return

	// Increase hunger rate
	quirk_mob.physiology.hunger_mod *= QUIRK_HUNGER_CONCUBUS

	/*
	// Prevent consuming normal food
	ADD_TRAIT(quirk_mob, TRAIT_LIVERLESS_METABOLISM, TRAIT_CONCUBUS)
	ADD_TRAIT(quirk_mob,TRAIT_NOTHIRST,QUIRK_TRAIT)
	*/

	// Register special reagent interactions
	RegisterSignals(quirk_holder, list(COMSIG_REAGENT_ADD_CUM, COMSIG_REAGENT_ADD_BREASTMILK), PROC_REF(handle_fluids))

/datum/quirk/concubus/remove()
	// Define quirk holder
	var/mob/living/carbon/human/quirk_mob = quirk_holder

	// Check for valid holder
	if(!istype(quirk_mob))
		return

	// Revert hunger rate change
	quirk_mob.physiology.hunger_mod /= QUIRK_HUNGER_CONCUBUS

	/*
	// Revert quirk traits
	REMOVE_TRAIT(quirk_mob, TRAIT_LIVERLESS_METABOLISM, TRAIT_CONCUBUS)
	REMOVE_TRAIT(quirk_mob,TRAIT_NOTHIRST,QUIRK_TRAIT)
	*/

	// Unregister special reagent interactions
	UnregisterSignal(quirk_holder, COMSIG_REAGENT_ADD_CUM)
	UnregisterSignal(quirk_holder, COMSIG_REAGENT_ADD_BREASTMILK)


/// Proc to handle gaining nutrition from compatible bodily fluids
/datum/quirk/concubus/proc/handle_fluids(mob/living/target, datum/reagent/handled_reagent, amount)
	SIGNAL_HANDLER

	// Add Notriment
	// This increases the target's nutrition
	quirk_holder.reagents.add_reagent(/datum/reagent/consumable/notriment, amount)

#undef QUIRK_HUNGER_CONCUBUS
