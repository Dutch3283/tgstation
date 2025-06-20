/datum/action/cooldown/mob_cooldown/werewolf_transform
	name = "Transform"
	button_icon = 'hypermods/icons/ui_icons/antags/werewolf/werewolf_ui.dmi'
	button_icon_state = "transform"
	desc = "Begin the process of transforming into a werewolf or begin reverting back into your regular form."
	cooldown_time = 90 SECONDS
	var/specie_to_become = /datum/species/werewolf
	/// Used to store whatever you were before.
	var/specie_to_revert_into = null
	/// Amount of time it takes us to transform back or forth
	var/channel_time = 3 SECONDS

/datum/action/cooldown/mob_cooldown/werewolf_transform/Activate()
	disable_cooldown_actions()
	werewolf_begin_transform()
	StartCooldown()
	enable_cooldown_actions()
	return TRUE

/datum/action/cooldown/mob_cooldown/werewolf_transform/proc/werewolf_begin_transform()
	var/mob/living/my_werewolf = owner
	var/old_transform = my_werewolf.transform

	var/animate_step = channel_time / 6
	playsound(my_werewolf, 'sound/effects/wounds/crack1.ogg', 50)
	animate(my_werewolf, transform = matrix() * 1.1, time = animate_step, easing = SINE_EASING)
	animate(transform = matrix() * 0.9, time = animate_step, easing = SINE_EASING)
	animate(transform = matrix() * 1.2, time = animate_step, easing = SINE_EASING)
	animate(transform = matrix() * 0.8, time = animate_step, easing = SINE_EASING)
	animate(transform = matrix() * 1.3, time = animate_step, easing = SINE_EASING)
	animate(transform = matrix() * 0.1, time = animate_step, easing = SINE_EASING)
	animate(transform = matrix() * 1, time = animate_step, easing = SINE_EASING)

	my_werewolf.balloon_alert(my_werewolf, "transforming...")
	if (!do_after(my_werewolf, delay = channel_time, target = my_werewolf))
		animate(my_werewolf, transform = matrix(), time = 0, easing = SINE_EASING)
		my_werewolf.transform = old_transform
		return FALSE
	playsound(my_werewolf, 'sound/effects/magic/demon_consume.ogg', 50, TRUE)
	playsound(my_werewolf, 'hypermods/sound/mobs/humanoid/werewolf/werewolf_howl.ogg', 70, TRUE)

	werewolf_transform()

/datum/action/cooldown/mob_cooldown/werewolf_transform/proc/werewolf_transform()
	var/mob/living/carbon/human/my_werewolf = owner
	if(!my_werewolf.dna?.species) // Just checkin'
		return

	my_werewolf.regenerate_limbs()

	if(!iswerewolf(my_werewolf)) // Are you not in werewolf form?
		if(specie_to_revert_into == null) // Now you are, we'll store your previous form here.
			my_werewolf.uncuff() // turning into a werewolf breaks any cuffs
			specie_to_revert_into = my_werewolf.dna.species
			var/datum/species/species_type = specie_to_become
			my_werewolf.set_species(species_type)
	else
		my_werewolf.set_species(specie_to_revert_into)
		specie_to_revert_into = null


/datum/action/cooldown/spell/touch/werewolf_maul
	name = "Maul Victim"
	button_icon = 'hypermods/icons/ui_icons/antags/werewolf/werewolf_ui.dmi'
	button_icon_state = "feast"
	desc = "Prepare a stronger attack or pry open an airlock (requires an empty offhand). Can also be used on human corpses to consume their heart, recovering health."
	cooldown_time = 30 SECONDS
	spell_max_level = 1
	overlay_icon_state = "bg_default_border"
	//cast_range = 1 // Touch range
	spell_requirements = NONE
	antimagic_flags = NONE
	background_icon_state = ACTION_BUTTON_DEFAULT_BACKGROUND
	invocation_type = INVOCATION_NONE
	hand_path = /obj/item/melee/touch_attack/werewolf_maul
	draw_message = span_notice("You prepare to maul someone.")
	/// How many hearts has this werewolf eaten?
	var/hearts_eaten = 0

/datum/action/cooldown/spell/touch/werewolf_maul/can_cast_spell(feedback = TRUE)
	. = ..()
	if(!iswerewolf(owner))
		return FALSE

/datum/action/cooldown/spell/touch/werewolf_maul/cast_on_hand_hit(obj/item/melee/touch_attack/hand, mob/living/carbon/victim, mob/living/carbon/caster)
	if(ishuman(victim))
		var/mob/living/carbon/human/human_victim = victim
		if(human_victim.stat != DEAD)
			human_victim.apply_damage(30, BRUTE)
			human_victim.Knockdown(5 SECONDS)
			if(prob(5))
				human_victim.ForceContractDisease(new /datum/disease/transformation/lycanthropy)
			playsound(human_victim, 'sound/effects/wounds/crack1.ogg', 50)
			playsound(human_victim, 'hypermods/sound/mobs/humanoid/werewolf/werewolf_attack1.ogg', 70)
			return TRUE
		else
			playsound(human_victim, 'sound/effects/butcher.ogg', 50)
			if(!do_after(caster, 5 SECONDS, target = human_victim))
				return
			var/obj/item/organ/heart/heart = human_victim.get_organ_slot(ORGAN_SLOT_HEART)
			if(heart)
				if(heart.organ_flags == ORGAN_ROBOTIC)
					to_chat(caster, span_notice("This one's heart is robotic! You can't eat that."))
					return FALSE
				caster.adjustToxLoss(-30, FALSE)
				caster.adjustOxyLoss(-30, FALSE)
				caster.adjustBruteLoss(-30, FALSE)
				caster.adjustFireLoss(-30, FALSE)
				playsound(human_victim, 'sound/effects/wounds/blood1.ogg', 50)
				caster.visible_message(span_warning("[caster] digs out [human_victim]'s heart and eats it whole!"), span_warning("You eat [human_victim]'s heart."), \
				span_hear("You hear a sickening squelch as flesh meets teeth."))
				if(!human_victim.mind)
					to_chat(caster, span_notice("The heart you consumed almost tastes... stale? This won't do at all."))
				else
					hearts_eaten++
				qdel(heart)
			else
				to_chat(caster, span_notice("This one doesn't even have a heart! How disappointing."))
				return FALSE
			return TRUE
	return FALSE

/obj/item/melee/touch_attack/werewolf_maul
	name = "\improper werewolf paw"
	desc = "It's just your paw. Don't think too hard on it."
	icon = 'icons/obj/weapons/hand.dmi'
	icon_state = "greyscale"
	color = COLOR_DARK_MODERATE_ORANGE
	inhand_icon_state = "werewolf" // we don't want visual effects here since it's just your paws.

/obj/item/melee/touch_attack/werewolf_maul/afterattack(atom/target, mob/user, click_parameters)
	..()
	// Thanks to the armblade code for this one.
	if(istype(target, /obj/structure/table))
		var/obj/smash = target
		smash.deconstruct(FALSE)
		playsound(smash, 'hypermods/sound/mobs/humanoid/werewolf/werewolf_attack1.ogg', 70)
		return TRUE
	if(istype(target, /obj/machinery/door/window))
		var/obj/smash = target
		smash.deconstruct(FALSE)
		playsound(smash, 'hypermods/sound/mobs/humanoid/werewolf/werewolf_attack1.ogg', 70)
		return TRUE
	if(istype(target, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/opening = target

		if((!opening.requiresID() || opening.allowed(user)) && opening.hasPower())
			return
		if(opening.locked)
			opening.balloon_alert(user, "bolted!")
			return

		if(opening.hasPower())
			user.visible_message(span_warning("[user] digs their claws into the [opening] and starts prying it open!"), span_warning("You start forcing the [opening] open."), \
			span_hear("You hear a metal screeching sound."))
			playsound(opening, 'hypermods/sound/mobs/humanoid/werewolf/werewolf_attack1.ogg', 70)
			playsound(opening, 'sound/machines/airlock/airlock_alien_prying.ogg', 100, TRUE)
			if(!do_after(user, 8 SECONDS, target = opening))
				return
		user.visible_message(span_warning("[user] forces the airlock to open with [user.p_their()] [src]!"), span_warning("You force the [opening] to open."), \
		span_hear("You hear a metal screeching sound."))
		opening.open(BYPASS_DOOR_CHECKS)
		return TRUE


/datum/action/cooldown/spell/werewolf_pounce
	name = "Pounce"
	desc = "Prepare your hind legs to leap through the air, quickly traversing long distances and slamming into enemies, knocking them down! Slamming into things may result in recoil damage."
	button_icon = 'hypermods/icons/ui_icons/antags/werewolf/werewolf_ui.dmi'
	button_icon_state = "pounce"

	cooldown_time = 10 SECONDS
	spell_max_level = 1
	overlay_icon_state = "bg_default_border"
	spell_requirements = NONE
	antimagic_flags = NONE
	background_icon_state = ACTION_BUTTON_DEFAULT_BACKGROUND
	invocation_type = INVOCATION_NONE
	var/jumpdistance = 8 //-1 from to see the actual distance, e.g 4 goes over 3 tiles
	var/jumpspeed = 5

/datum/action/cooldown/spell/werewolf_pounce/can_cast_spell(feedback = TRUE)
	. = ..()
	if(!iswerewolf(owner))
		return FALSE

/datum/action/cooldown/spell/werewolf_pounce/cast(mob/living/carbon/cast_on)
	if(!isliving(cast_on))
		return

	var/atom/target = get_edge_target_turf(cast_on, cast_on.dir) //gets the user's direction

	ADD_TRAIT(cast_on, TRAIT_MOVE_FLOATING, LEAPING_TRAIT)  //Throwing itself doesn't protect mobs against lava (because gulag).
	if (cast_on.throw_at(target, jumpdistance, jumpspeed, spin = FALSE, diagonals_first = TRUE, callback = TRAIT_CALLBACK_REMOVE(cast_on, TRAIT_MOVE_FLOATING, LEAPING_TRAIT)))
		playsound(src, 'hypermods/sound/mobs/humanoid/werewolf/werewolf_attack2.ogg', 50, TRUE, TRUE)
		cast_on.visible_message(span_warning("[cast_on] leaps into the air at high speed!"))
	else
		to_chat(cast_on, span_warning("Something prevents you from leaping into the air!"))


/datum/action/cooldown/spell/touch/werewolf_tainted_claw
	name = "Tainted Claws"
	button_icon = 'hypermods/icons/ui_icons/antags/werewolf/werewolf_ui.dmi'
	button_icon_state = "tainted-bite"
	desc = "Fill your claws with a random toxin to apply to your target. Successful attacks heal toxin damage and rapidly purge your bloodstream."
	cooldown_time = 90 SECONDS
	spell_max_level = 1
	overlay_icon_state = "bg_default_border"
	//cast_range = 1 // Touch range
	spell_requirements = NONE
	antimagic_flags = NONE
	background_icon_state = ACTION_BUTTON_DEFAULT_BACKGROUND
	invocation_type = INVOCATION_NONE
	hand_path = /obj/item/melee/touch_attack/werewolf_tainted_attack
	draw_message = span_notice("You prepare your claws to poison your next victim.")
	var/r_type = ""

/datum/action/cooldown/spell/touch/werewolf_tainted_claw/can_cast_spell(feedback = TRUE)
	. = ..()
	if(!iswerewolf(owner))
		return FALSE

/datum/action/cooldown/spell/touch/werewolf_tainted_claw/cast_on_hand_hit(obj/item/melee/touch_attack/hand, mob/living/carbon/victim, mob/living/carbon/caster)
	if(ishuman(victim))
		var/mob/living/carbon/human/human_victim = victim
		var/list/r_types = subtypesof(/datum/reagent/toxin/) // get all toxin reagents

		for(var/i in 1 to 1) // get one random toxin reagent
			r_type = pick(r_types)

		if(human_victim.stat != DEAD)
			human_victim.apply_damage(10, BRUTE)
			caster.adjustToxLoss(-20, 0, TRUE)
			human_victim.reagents.add_reagent(r_type, 5)
			caster.reagents.add_reagent(/datum/reagent/medicine/pen_acid, 5)
			if(prob(40))
				human_victim.ForceContractDisease(new /datum/disease/transformation/lycanthropy)
			playsound(human_victim, 'sound/effects/wounds/crack1.ogg', 50)
			playsound(human_victim, 'hypermods/sound/mobs/humanoid/werewolf/werewolf_attack1.ogg', 70)
			return TRUE
	return FALSE

/obj/item/melee/touch_attack/werewolf_tainted_attack
	name = "\improper tainted claws"
	desc = "It's your paw. Not much else to note."
	icon = 'icons/obj/weapons/hand.dmi'
	icon_state = "greyscale"
	color = COLOR_DARK_MODERATE_LIME_GREEN
	inhand_icon_state = "werewolf" // no visual "werewolf" icon doesn't exist -- we don't want one..


/datum/action/cooldown/spell/werewolf_def_howl
	name = "Defensive Howl"
	desc = "Prepare yourself to emit a blood-curdling howl, takes 10 seconds to pull off successfully. \
			While doing so, you'll gain great resistance to all forms of damage, and if successful, you'll gain a minute-long but slow regeneration effect."
	button_icon = 'hypermods/icons/ui_icons/antags/werewolf/werewolf_ui.dmi'
	button_icon_state = "howl"

	cooldown_time = 90 SECONDS
	spell_max_level = 1
	overlay_icon_state = "bg_default_border"
	spell_requirements = NONE
	antimagic_flags = NONE
	background_icon_state = ACTION_BUTTON_DEFAULT_BACKGROUND
	invocation_type = INVOCATION_NONE

/datum/action/cooldown/spell/werewolf_def_howl/can_cast_spell(feedback = TRUE)
	. = ..()
	if(!iswerewolf(owner))
		return FALSE

/datum/action/cooldown/spell/werewolf_def_howl/cast(mob/living/carbon/cast_on)
	if(!isliving(cast_on))
		return

	def_up(cast_on)
	cast_on.adjust_fire_stacks(-20) // self-extinguish
	cast_on.balloon_alert(cast_on, "preparing to howl...")
	cast_on.visible_message(span_warning("[cast_on] lets out a low growl as they stiffen!"), span_warning("You prepare a defensive howl..."), \
	span_hear("You hear a low growl..."))

	if(!do_after(cast_on, 10 SECONDS))
		def_down(cast_on)
		return // Canceled or not, better make sure the def is removed.
	playsound(cast_on, 'hypermods/sound/mobs/humanoid/werewolf/werewolf_howl.ogg', 70, TRUE)
	def_down(cast_on)
	// About 30 brute/burn and 15 tox damage healed over a minute.
	cast_on.apply_status_effect(/datum/status_effect/regenerative_howl)

/datum/action/cooldown/spell/werewolf_def_howl/proc/def_up(mob/living/carbon/cast_on)
	var/mob/living/carbon/human/my_werewolf = cast_on
	my_werewolf.physiology.brute_mod *= 0.3
	my_werewolf.physiology.burn_mod *= 0.3
	my_werewolf.physiology.tox_mod *= 0.3
	my_werewolf.physiology.oxy_mod *= 0.3

/datum/action/cooldown/spell/werewolf_def_howl/proc/def_down(mob/living/carbon/cast_on)
	var/mob/living/carbon/human/my_werewolf = cast_on
	my_werewolf.physiology.brute_mod /= 0.3
	my_werewolf.physiology.burn_mod /= 0.3
	my_werewolf.physiology.tox_mod /= 0.3
	my_werewolf.physiology.oxy_mod /= 0.3


/datum/action/cooldown/spell/werewolf_pounce
	name = "Pounce"
	desc = "Prepare your hind legs to leap through the air, quickly traversing long distances and slamming into enemies, knocking them down! Slamming into things may result in recoil damage."
	button_icon = 'hypermods/icons/ui_icons/antags/werewolf/werewolf_ui.dmi'
	button_icon_state = "pounce"

	cooldown_time = 10 SECONDS
	spell_max_level = 1
	overlay_icon_state = "bg_default_border"
	spell_requirements = NONE
	antimagic_flags = NONE
	background_icon_state = ACTION_BUTTON_DEFAULT_BACKGROUND
	invocation_type = INVOCATION_NONE

/datum/action/cooldown/spell/werewolf_pounce/can_cast_spell(feedback = TRUE)
	. = ..()
	if(!iswerewolf(owner))
		return FALSE

/datum/action/cooldown/spell/werewolf_pounce/cast(mob/living/carbon/cast_on)
	if(!isliving(cast_on))
		return

	var/atom/target = get_edge_target_turf(cast_on, cast_on.dir) //gets the user's direction

	ADD_TRAIT(cast_on, TRAIT_MOVE_FLOATING, LEAPING_TRAIT)  //Throwing itself doesn't protect mobs against lava (because gulag).
	if (cast_on.throw_at(target, jumpdistance, jumpspeed, spin = FALSE, diagonals_first = TRUE, callback = TRAIT_CALLBACK_REMOVE(cast_on, TRAIT_MOVE_FLOATING, LEAPING_TRAIT)))
		playsound(src, 'hypermods/sound/mobs/humanoid/werewolf/werewolf_attack2.ogg', 50, TRUE, TRUE)
		cast_on.visible_message(span_warning("[cast_on] leaps into the air at high speed!"))
	else
		to_chat(cast_on, span_warning("Something prevents you from leaping into the air!"))


/datum/action/cooldown/spell/pointed/werewolf_throw
	name = "Throw"
	desc = "Prepare yourself to throw around a nearby human like a ragdoll, this doesn't require you to grab them. Will be interrupted should be move too quickly after using this ability."
	button_icon = 'hypermods/icons/ui_icons/antags/werewolf/werewolf_ui.dmi'
	button_icon_state = "throw"

	cooldown_time = 30 SECONDS
	spell_max_level = 1
	cast_range = 1 // Important, we don't want command grabs here.
	overlay_icon_state = "bg_default_border"
	spell_requirements = NONE
	antimagic_flags = NONE
	background_icon_state = ACTION_BUTTON_DEFAULT_BACKGROUND
	invocation_type = INVOCATION_NONE

	active_msg = "You prepare to throw a target..."

/datum/action/cooldown/spell/pointed/werewolf_throw/can_cast_spell(feedback = TRUE)
	. = ..()
	if(!iswerewolf(owner))
		return FALSE

/datum/action/cooldown/spell/pointed/werewolf_throw/is_valid_target(atom/cast_on)
	. = ..()
	if(!.)
		return FALSE
	if(!ishuman(cast_on))
		return FALSE

/datum/action/cooldown/spell/pointed/werewolf_throw/cast(mob/living/carbon/human/cast_on)
	. = ..()
	if(!cast_on)
		return
	cast_on.forceMove(owner.loc)
	cast_on.setDir(get_dir(cast_on, owner))

	cast_on.Stun(8 SECONDS)
	cast_on.visible_message(span_danger("[owner] starts spinning around with [cast_on]!"), \
					span_userdanger("You're spun around by [owner]!"), span_hear("You hear aggressive shuffling!"), null, owner)
	to_chat(owner, span_danger("You start spinning around with [cast_on]!"))
	owner.emote("scream")

	for (var/i in 1 to 20)
		var/delay = 5
		switch (i)
			if (18 to INFINITY)
				delay = 0.25
			if (15 to 17)
				delay = 0.5
			if (10 to 14)
				delay = 1
			if (6 to 9)
				delay = 2
			if (1 to 5)
				delay = 3

		if (owner && cast_on)

			if (get_dist(owner, cast_on) > 1)
				to_chat(owner, span_warning("[cast_on] is too far away!"))
				return

			if (!isturf(owner.loc) || !isturf(cast_on.loc))
				to_chat(owner, span_warning("You can't throw [cast_on] from here!"))
				return

			owner.setDir(turn(owner.dir, 90))
			var/turf/T = get_step(owner, owner.dir)
			var/turf/S = cast_on.loc
			var/direction = get_dir(cast_on, owner)
			if ((S && isturf(S) && S.Exit(cast_on, direction)) && (T && isturf(T) && T.Enter(owner)))
				cast_on.forceMove(T)
				cast_on.setDir(direction)
		else
			return

		sleep(delay)

	if (owner && cast_on)
		// These are necessary because of the sleep call.

		if (get_dist(owner, cast_on) > 1)
			to_chat(owner, span_warning("[cast_on] is too far away!"))
			return

		if (!isturf(owner.loc) || !isturf(cast_on.loc))
			to_chat(owner, span_warning("You can't throw [cast_on] from here!"))
			return

		cast_on.forceMove(owner.loc) // Maybe this will help with the wallthrowing bug.

		cast_on.visible_message(span_danger("[owner] throws [cast_on]!"), \
						span_userdanger("You're thrown by [owner]!"), span_hear("You hear aggressive shuffling and a loud thud!"), null, owner)
		to_chat(owner, span_danger("You throw [cast_on]!"))
		playsound(owner.loc, SFX_SWING_HIT, 50, TRUE)
		playsound(owner.loc, 'hypermods/sound/mobs/humanoid/werewolf/werewolf_attack2.ogg', 50, TRUE, TRUE)
		var/turf/T = get_edge_target_turf(owner, owner.dir)
		if (T && isturf(T))
			if (!cast_on.stat)
				cast_on.emote("scream")
			cast_on.throw_at(T, 10, 4, owner, TRUE, TRUE, callback = CALLBACK(cast_on, TYPE_PROC_REF(/mob/living, Paralyze), 20))
	log_combat(owner, cast_on, "has been thrown by a werewolf")
	return TRUE


/datum/action/cooldown/spell/aoe/repulse/werewolf
	name = "Thrash"
	desc = "Spin around, flailing your arms at all adjacent targets, knocking them down for a good while and dealing moderate damage."

	cooldown_time = 120 SECONDS
	spell_max_level = 1
	overlay_icon_state = "bg_default_border"
	spell_requirements = NONE
	antimagic_flags = NONE
	background_icon_state = ACTION_BUTTON_DEFAULT_BACKGROUND
	invocation_type = INVOCATION_NONE

	button_icon = 'hypermods/icons/ui_icons/antags/werewolf/werewolf_ui.dmi'
	button_icon_state = "thrash"
	sound = 'hypermods/sound/mobs/humanoid/werewolf/werewolf_attack1.ogg'

	check_flags = AB_CHECK_CONSCIOUS | AB_CHECK_INCAPACITATED | AB_CHECK_HANDS_BLOCKED | AB_CHECK_IMMOBILE
	aoe_radius = 1

	sparkle_path = /obj/effect/temp_visual/dir_setting/tailsweep/werewolf

/datum/action/cooldown/spell/aoe/repulse/werewolf/can_cast_spell(feedback = TRUE)
	. = ..()
	if(!iswerewolf(owner))
		return FALSE

/datum/action/cooldown/spell/aoe/repulse/werewolf/cast(atom/cast_on)
	if(iscarbon(cast_on))
		var/mob/living/carbon/carbon_caster = cast_on
		playsound(get_turf(carbon_caster), 'hypermods/sound/mobs/humanoid/werewolf/werewolf_attack1.ogg', 20, TRUE, TRUE)
		carbon_caster.spin(0.6 SECONDS, 1)

	return ..()
