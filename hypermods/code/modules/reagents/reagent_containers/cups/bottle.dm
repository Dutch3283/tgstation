/obj/item/reagent_containers/cup/bottle/omnizine
	name = "omnizine bottle"
	desc = "A small bottle of omnizine. Drink in moderation."
	custom_price = 100
	custom_premium_price = 200
	list_reagents = list(/datum/reagent/medicine/omnizine = 30)

/obj/item/reagent_containers/cup/bottle/probital
	name = "probital bottle"
	list_reagents = list(/datum/reagent/medicine/c2/probital = 30)

/obj/item/reagent_containers/cup/bottle/modafinil
	name = "modafinil bottle"
	list_reagents = list(/datum/reagent/medicine/modafinil = 30)

/obj/item/reagent_containers/cup/bottle/methamphetamine
	name = "methamphetamine bottle"
	custom_price = 50
	custom_premium_price = 100
	list_reagents = list(/datum/reagent/drug/methamphetamine = 30)

/obj/item/reagent_containers/cup/bottle/libital
	name = "libital bottle"
	desc = "A small bottle of libital."
	custom_price = 25
	list_reagents = list(/datum/reagent/medicine/c2/libital = 30)

/obj/item/reagent_containers/cup/bottle/aiuri
	name = "aiuri bottle"
	desc = "A small bottle of aiuri."
	custom_price = 25
	list_reagents = list(/datum/reagent/medicine/c2/aiuri = 30)

/obj/item/reagent_containers/cup/bottle/syriniver
	name = "syriniver bottle"
	list_reagents = list(/datum/reagent/medicine/c2/syriniver = 30)
	custom_price = 25

/obj/item/reagent_containers/cup/bottle/convermol
	name = "convermol bottle"
	list_reagents = list(/datum/reagent/medicine/c2/convermol = 30)
	custom_price = 25

/obj/item/reagent_containers/cup/bottle/stimulants
	name = "stimulants bottle"
	desc = "A small bottle of stimulants."
	list_reagents = list(/datum/reagent/medicine/stimulants = 30)

/obj/item/reagent_containers/cup/bottle/nocturine
	name = "nocturine bottle"
	list_reagents = list(/datum/reagent/toxin/nocturine = 30)

/obj/item/reagent_containers/cup/bottle/nocturine/full
	name = "nocturine bottle"
	list_reagents = list(/datum/reagent/toxin/nocturine = 50)

/obj/item/reagent_containers/cup/bottle/sal_acid
	name = "salicyclic acid bottle"
	list_reagents = list(/datum/reagent/medicine/sal_acid = 30)
	custom_premium_price = 50

/obj/item/reagent_containers/cup/bottle/oxandrolone
	name = "oxandrolone bottle"
	list_reagents = list(/datum/reagent/medicine/oxandrolone = 30)
	custom_premium_price = 50

/obj/item/reagent_containers/cup/bottle/calomel
	name = "calomel bottle"
	list_reagents = list(/datum/reagent/medicine/calomel = 30)
	custom_premium_price = 50

/obj/item/reagent_containers/cup/bottle/salbutamol
	name = "salbutamol bottle"
	list_reagents = list(/datum/reagent/medicine/salbutamol = 30)
	custom_premium_price = 50

/obj/item/reagent_containers/cup/bottle/coagulant
	name = "sanguirite bottle"
	list_reagents = list(/datum/reagent/medicine/coagulant = 30)
	custom_premium_price = 50

/obj/item/reagent_containers/cup/bottle/lavaland
	name = "lavaland extract mix bottle"
	custom_price = 50
	custom_premium_price = 100
	list_reagents = list(/datum/reagent/medicine/tricordrazine = 6, /datum/reagent/medicine/epinephrine = 12, /datum/reagent/medicine/lavaland_extract = 6, /datum/reagent/medicine/omnizine = 6)



/// Red-space flasks of eternal whatever -- expensive traitor shit.

/obj/item/reagent_containers/cup/bottle/eternal
	name = "Eternal Flask"
	desc = "A deceptively stylish glass bottle that's been augmented with redspace technology. It doesn't produce anything, for whatever reason."
	var/generate_reagent = null
	var/last_generate = 0
	var/generate_delay = 50 //deciseconds or 5 seconds

/obj/item/reagent_containers/cup/bottle/eternal/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/reagent_containers/cup/bottle/eternal/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/reagent_containers/cup/bottle/eternal/process()
	if(world.time < last_generate + generate_delay)
		return
	last_generate = world.time
	reagents.add_reagent(generate_reagent, 1)

/obj/item/reagent_containers/cup/bottle/eternal/omnizine
	name = "Eternal Flask of Omnizine"
	desc = "A deceptively stylish glass bottle that's been augmented with redspace technology. It generates an endless supply of it's reagents over time."
	list_reagents = list(/datum/reagent/medicine/omnizine = 50)
	generate_reagent = /datum/reagent/medicine/omnizine

/obj/item/reagent_containers/cup/bottle/eternal/mutagen
	name = "Eternal Flask of Unstable Mutagen"
	desc = "A deceptively stylish glass bottle that's been augmented with redspace technology. It generates an endless supply of it's reagents over time."
	list_reagents = list(/datum/reagent/toxin/mutagen = 50)
	generate_reagent = /datum/reagent/toxin/mutagen

/obj/item/reagent_containers/cup/bottle/eternal/diethylamine
	name = "Eternal Flask of Diethylamine"
	desc = "A deceptively stylish glass bottle that's been augmented with redspace technology. It generates an endless supply of it's reagents over time."
	list_reagents = list(/datum/reagent/diethylamine = 50)
	generate_reagent = /datum/reagent/diethylamine

/obj/item/reagent_containers/cup/bottle/eternal/diseasedblood
	name = "Eternal Flask of Diseased Blood"
	desc = "A deceptively stylish glass bottle that's been augmented with redspace technology. It generates an endless supply of it's reagents over time."
	list_reagents = list(/datum/reagent/diseasedblood = 50)
	generate_reagent = /datum/reagent/diseasedblood

/obj/item/reagent_containers/cup/bottle/eternal/stimpack
	name = "Eternal Flask of Stimulants"
	desc = "A deceptively stylish glass bottle that's been augmented with redspace technology. It generates an endless supply of it's reagents over time."
	list_reagents = list(/datum/reagent/medicine/stimulants = 50)
	generate_reagent = /datum/reagent/medicine/stimulants



/obj/item/reagent_containers/cup/bottle/syndisymptombuffer
	name = "S. Gene culture bottle"
	desc = "A small bottle. Contains a sample of an incredibly refined and powerful virus gene."
	spawned_disease = /datum/disease/advance/syndicate

/obj/item/reagent_containers/cup/bottle/syndisymptombuffer/stealth
	name = "STE. Gene culture bottle"
	spawned_disease = /datum/disease/advance/syndicate/stealth

/obj/item/reagent_containers/cup/bottle/syndisymptombuffer/resist
	name = "SRE. Gene culture bottle"
	spawned_disease = /datum/disease/advance/syndicate/resist

/obj/item/reagent_containers/cup/bottle/syndisymptombuffer/speed
	name = "SPD. Gene culture bottle"
	spawned_disease = /datum/disease/advance/syndicate/speed

/obj/item/reagent_containers/cup/bottle/syndisymptombuffer/trans
	name = "STR. Gene culture bottle"
	spawned_disease = /datum/disease/advance/syndicate/trans
