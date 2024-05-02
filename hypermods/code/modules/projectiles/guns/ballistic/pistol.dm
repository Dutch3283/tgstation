/obj/item/gun/ballistic/automatic/pistol/viper
	name = "\improper Viper"
	desc = "A classic 10mm handgun with a small magazine capacity. It's capable of automatic fire."
	icon = 'hypermods/icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "Viper"
	inhand_icon_state = "viper"
	lefthand_file = 'hypermods/icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'hypermods/icons/mob/inhands/weapons/guns_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	accepted_magazine_type = /obj/item/ammo_box/magazine/m10mm
	mag_display = TRUE
	can_suppress = FALSE
	bolt_type = BOLT_TYPE_LOCKING
	fire_delay = 0
	fire_sound = 'sound/weapons/gun/pistol/shot_alt.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'

/obj/item/gun/ballistic/automatic/pistol/viper/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.2 SECONDS)

/obj/item/gun/ballistic/automatic/pistol/viper/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/viper/implant
	name = "viper implant"
	desc = "A modified version of the viper pistol placed inside of the forearm, allows for easy concealment."

/obj/item/gun/ballistic/automatic/pistol/cobra
	name = "\improper Cobra"
	desc = "A classic .45 handgun with a small magazine capacity. It makes very little noise at all when firing."
	icon = 'hypermods/icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "Cobra"
	inhand_icon_state = "cobra"
	lefthand_file = 'hypermods/icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'hypermods/icons/mob/inhands/weapons/guns_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	accepted_magazine_type = /obj/item/ammo_box/magazine/m45
	mag_display = TRUE
	can_suppress = FALSE
	bolt_type = BOLT_TYPE_LOCKING
	fire_sound = 'sound/weapons/gun/pistol/shot_suppressed.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	fire_sound_volume = 5

/obj/item/gun/ballistic/automatic/pistol/cobra/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/cobra/caseless
	spawn_magazine_type = /obj/item/ammo_box/magazine/m45/cs

/obj/item/gun/ballistic/automatic/pistol/cobra/implant
	name = "cobra implant"
	desc = "A modified version of the cobra pistol placed inside of the forearm, allows for easy concealment."

/obj/item/gun/ballistic/automatic/pistol/implant
	name = "Makarov implant"
	desc = "A modified version of the Makarov pistol placed inside of the forearm, allows for easy concealment."

/obj/item/gun/ballistic/automatic/pistol/m1911/implant
	name = "m1911 implant"
	desc = "A modified version of the m1911 pistol placed inside of the forearm, allows for easy concealment."

/obj/item/gun/ballistic/automatic/pistol/deagle/implant
	name = "desert eagle implant"
	desc = "A modified version of the desert eagle placed inside of the forearm, allows for easy concealment."


/obj/item/gun/ballistic/automatic/pistol/mk58
	name = "\improper Mk58"
	desc = "A classic .38 handgun with a small magazine capacity."
	icon = 'hypermods/icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "Mk58"
	inhand_icon_state = "mk58"
	lefthand_file = 'hypermods/icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'hypermods/icons/mob/inhands/weapons/guns_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	accepted_magazine_type = /obj/item/ammo_box/magazine/v38
	mag_display = TRUE
	can_suppress = FALSE
	bolt_type = BOLT_TYPE_LOCKING
	fire_sound = "sound/weapons/pistolshotsmall.ogg"
	custom_price = 2500

/obj/item/gun/ballistic/automatic/pistol/mk58/nopin
	pin = null

/obj/item/gun/ballistic/automatic/pistol/mk58/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/mk58/rubber
	spawn_magazine_type = /obj/item/ammo_box/magazine/m45/cs

/obj/item/gun/ballistic/automatic/pistol/mk58/no_mag/nopin
	spawnwithmagazine = FALSE
	pin = null
