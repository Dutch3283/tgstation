// .45 (M1911 & C20r)

/obj/projectile/bullet/c45
	name = ".45 bullet"
	damage = 30
	wound_bonus = -10
	wound_falloff_tile = -10

/obj/projectile/bullet/c45/ap
	name = ".45 armor-piercing bullet"
	armour_penetration = 50

/obj/projectile/bullet/c45/hp
	name = ".45 hollow point bullet"
	damage = 50
	weak_against_armour = TRUE

/obj/projectile/bullet/incendiary/c45
	name = ".45 incendiary bullet"
	damage = 15
	fire_stacks = 2

/obj/projectile/bullet/c45/cs
	name = ".45 caseless bullet"
	damage = 27
	speed = 1

/obj/projectile/bullet/c45/sp
	name = ".45 soporific bullet"
	damage = 5
	eyeblur = 20

/obj/projectile/bullet/c45/sp/on_hit(atom/target, blocked = FALSE, pierce_hit)
	if((blocked != 100) && isliving(target))
		var/mob/living/L = target
		L.adjustStaminaLoss(20)
		if(L.getStaminaLoss() >= 100)
			L.Sleeping(400)
	return ..()

/obj/projectile/bullet/c45/emp
	name = ".45 EMP bullet"
	damage = 25

/obj/projectile/bullet/c45/emp/on_hit(atom/target, blocked = FALSE, pierce_hit)
	..()
	empulse(target, heavy_range = 1, light_range = 2) //Heavy EMP on target, light EMP in tiles around

/obj/projectile/bullet/c45/venom
	name = ".45 venom bullet"
	damage = 20

/obj/projectile/bullet/c45/venom/on_hit(atom/target, blocked, pierce_hit)
	if(iscarbon(target))
		var/mob/living/carbon/victim = target
		victim.reagents.add_reagent(/datum/reagent/toxin/venom, 4)
	return ..()

/obj/projectile/bullet/c45/pacify
	name = ".45 pacification bullet"
	damage = 18

/obj/projectile/bullet/c45/pacify/on_hit(atom/target, blocked, pierce_hit)
	if(iscarbon(target))
		var/mob/living/carbon/victim = target
		victim.reagents.add_reagent(/datum/reagent/pax, 1)
	return ..()

/obj/projectile/bullet/c45/delay
	name = ".45 delayed bullet"
	damage = 15

/obj/projectile/bullet/c45/delay/on_hit(atom/target, blocked, pierce_hit)
	if(iscarbon(target))
		var/mob/living/carbon/victim = target
		victim.reagents.add_reagent(/datum/reagent/toxin/amanitin, 5)
	return ..()

/obj/projectile/bullet/c45/tranq
	name = ".45 tranquilizer bullet"
	damage = 4

/obj/projectile/bullet/c45/tranq/on_hit(atom/target, blocked, pierce_hit)
	if(iscarbon(target))
		var/mob/living/carbon/victim = target
		victim.reagents.add_reagent(/datum/reagent/toxin/muscleparalyzers, 3)
	return ..()

// 4.6x30mm (Autorifles)

/obj/projectile/bullet/c46x30mm
	name = "4.6x30mm bullet"
	damage = 20
	wound_bonus = -5
	exposed_wound_bonus = 5
	embed_falloff_tile = -4

/obj/projectile/bullet/c46x30mm/ap
	name = "4.6x30mm armor-piercing bullet"
	damage = 15
	armour_penetration = 40
	embed_type = null

/obj/projectile/bullet/incendiary/c46x30mm
	name = "4.6x30mm incendiary bullet"
	damage = 10
	fire_stacks = 1
