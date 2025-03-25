/obj/machinery/vending/wallgene
	name = "\improper NanoGene"
	desc = "Wall-mounted Medical Equipment dispenser."
	icon = 'hypermods/icons/obj/machines/vending.dmi'
	icon_state = "wallgene"
	icon_deny = "wallgene-deny"
	density = FALSE
	products = list(/obj/item/storage/pill_bottle/mannitol = 2,
		            /obj/item/storage/pill_bottle/mutadone = 2,
		            /obj/item/reagent_containers/applicator/pill/multiver = 6,
					/obj/item/clothing/glasses/regular = 5,
					/obj/item/disk/data = 2,
					/obj/item/food/monkeycube = 10)
	contraband = list(/obj/item/reagent_containers/cup/bottle/radium = 1,
					  /obj/item/reagent_containers/cup/bottle/mutagen = 2,
	                  /obj/item/food/monkeycube/gorilla = 1)
	armor = list(MELEE = 100, BULLET = 100, LASER = 100, ENERGY = 100, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 50)
	resistance_flags = FIRE_PROOF
	refill_canister = /obj/item/vending_refill/wallgene
	default_price = 25
	extra_price = 100
	payment_department = ACCOUNT_MED

/obj/item/vending_refill/wallgene
	machine_name = "NanoGene"
	icon_state = "refill_wallgene"

