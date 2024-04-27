/obj/item/clothing/gloves/knifeboxing
	name = "bladed gloves"
	desc = "I'm here to punch people in the face with blades."
	icon = 'hypermods/icons/obj/clothing/gloves.dmi'
	icon_state = "bladed"
	inhand_icon_state = "latex_gloves" // not super obvious this way.

/obj/item/clothing/gloves/knifeboxing
	var/datum/martial_art/knifeboxing/style

/obj/item/clothing/gloves/knifeboxing/Initialize(mapload)
	. = ..()
	style = new()
	style.allow_temp_override = FALSE

/obj/item/clothing/gloves/knifeboxing/Destroy()
	QDEL_NULL(style)
	return ..()

/obj/item/clothing/gloves/knifeboxing/equipped(mob/user, slot)
	. = ..()
	if(slot & ITEM_SLOT_GLOVES)
		style.teach(user, TRUE)

/obj/item/clothing/gloves/knifeboxing/dropped(mob/user)
	. = ..()
	style.fully_remove(user)


/obj/item/clothing/gloves/boxing/blue/rigged
	icon_state = "boxingblue"
	greyscale_colors = "#0074fa"
	inhand_icon_state = "greyscale_gloves"

/obj/item/clothing/gloves/boxing/blue/rigged
	var/datum/martial_art/riggedboxing/stylish

/obj/item/clothing/gloves/boxing/blue/rigged/Initialize(mapload)
	. = ..()
	stylish = new()
	stylish.allow_temp_override = FALSE

/obj/item/clothing/gloves/boxing/blue/rigged/Destroy()
	QDEL_NULL(stylish)
	return ..()

/obj/item/clothing/gloves/boxing/blue/rigged/equipped(mob/user, slot)
	. = ..()
	if(slot & ITEM_SLOT_GLOVES)
		stylish.teach(user, TRUE)

/obj/item/clothing/gloves/boxing/blue/rigged/dropped(mob/user)
	. = ..()
	stylish.fully_remove(user)
