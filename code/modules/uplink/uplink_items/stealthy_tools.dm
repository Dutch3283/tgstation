/datum/uplink_category/stealthy_tools
	name = "Stealth Gadgets"
	weight = 18

/datum/uplink_item/stealthy_tools
	category = /datum/uplink_category/stealthy_tools
	uplink_item_flags = SYNDIE_ILLEGAL_TECH


/datum/uplink_item/stealthy_tools/agent_card
	name = "Agent Identification Card"
	desc = "Agent cards prevent artificial intelligences from tracking the wearer, and hold up to 12 new common accesses, 6 command, and 3 captain. \
			from other identification cards. In addition, they can be forged to display a new assignment, name and trim. \
			This can be done an unlimited amount of times. Some Syndicate areas and devices can only be accessed \
			with these cards."
	item = /obj/item/card/id/advanced/chameleon
	cost = 3

/datum/uplink_item/stealthy_tools/ai_detector
	name = "Artificial Intelligence Detector"
	desc = "A functional multitool that turns red when it detects an artificial intelligence watching it, and can be \
			activated to display their exact viewing location. Knowing when \
			an artificial intelligence is watching you is useful for knowing when to maintain cover, and finding nearby \
			blind spots can help you identify escape routes."
	item = /obj/item/multitool/ai_detect
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)
	cost = 1

/datum/uplink_item/stealthy_tools/chameleon
	name = "Chameleon Kit"
	desc = "A set of items that contain chameleon technology allowing you to disguise as pretty much anything on the station, and more! \
			Due to budget cuts, the shoes don't provide protection against slipping and skillchips are sold separately. \
			However, we've managed to improve this chameleon set over the years to support plasmamen."
	item = /obj/item/storage/box/syndie_kit/chameleon
	cost = 2
	purchasable_from = ~UPLINK_NUKE_OPS //clown ops are allowed to buy this kit, since it's basically a costume, loneops can purchase it to blend in.

/datum/uplink_item/stealthy_tools/syndigaloshes
	name = "No-Slip Chameleon Shoes"
	desc = "These shoes will allow the wearer to run on wet floors and slippery objects without falling down. \
			They do not work on heavily lubricated surfaces."
	item = /obj/item/clothing/shoes/chameleon/noslip
	cost = 2
	purchasable_from = ~(UPLINK_ALL_SYNDIE_OPS)

/datum/uplink_item/stealthy_tools/chameleon_proj
	name = "Chameleon Projector"
	desc = "Projects an image across a user, disguising them as an object scanned with it, as long as they don't \
			move the projector from their hand. Disguised users move slowly, and projectiles pass over them."
	item = /obj/item/chameleon
	cost = 7

/datum/uplink_item/stealthy_tools/codespeak_manual
	name = "Codespeak Manual"
	desc = "Syndicate agents can be trained to use a series of codewords to convey complex information, which sounds like random concepts and drinks to anyone listening. \
			This manual teaches you this Codespeak. You can also hit someone else with the manual in order to teach them. Can only be used once. \
			Be warned that Codespeak usually just gives you away as a potential syndicate agent."
	item = /obj/item/language_manual/codespeak_manual
	cost = 1
	purchasable_from = ~(UPLINK_ALL_SYNDIE_OPS)

/datum/uplink_item/stealthy_tools/emplight
	name = "EMP Flashlight"
	desc = "A small, self-recharging, short-ranged EMP device disguised as a working flashlight. \
			Useful for disrupting headsets, cameras, doors, lockers and borgs during stealth operations. \
			Attacking a target with this flashlight will direct an EM pulse at it and consumes a charge."
	item = /obj/item/flashlight/emp
	cost = 4
	surplus = 30

/datum/uplink_item/stealthy_tools/emplight/New()
	..()
	if(HAS_TRAIT(SSstation, STATION_TRAIT_CYBERNETIC_REVOLUTION))
		cost *= 3

/datum/uplink_item/stealthy_tools/mulligan
	name = "Mulligan"
	desc = "Screwed up and have security on your tail? This handy syringe will give you a completely new identity \
			and appearance. Pair with an Agent ID for maximum effectiveness. A chameleon kit is also extremely handy \
			to have when using a Mulligan."
	item = /obj/item/reagent_containers/syringe/mulligan
	cost = 2
	surplus = 30
	purchasable_from = ~(UPLINK_ALL_SYNDIE_OPS)

/datum/uplink_item/stealthy_tools/jammer
	name = "Radio Jammer"
	desc = "This device will disrupt any nearby outgoing radio communication when activated. Does not affect binary chat."
	item = /obj/item/jammer
	cost = 5

/datum/uplink_item/stealthy_tools/smugglersatchel
	name = "Smuggler's Satchel"
	desc = "This satchel is thin enough to be hidden in the gap between plating and tiling; great for stashing \
			your stolen goods. Comes with a crowbar, a floor tile and some contraband inside. Its contents cannot be detected by contraband scanners."
	item = /obj/item/storage/backpack/satchel/flat/with_tools
	cost = 1
	surplus = 30
	uplink_item_flags = NONE

/datum/uplink_item/stealthy_tools/mail_counterfeit
	name = "GLA Brand Mail Counterfeit Device"
	desc = "A device capable of counterfeiting NT's mail. Can be used to store items within as an easy means of smuggling contraband. \
			Additionally, you may choose to \"arm\" the item inside, causing the item to be used the moment the mail is opened as if the person had just used it in hand. \
			The most common usage of this feature is with grenades, as it forces the grenade to prime. Bonus points if the grenade is set to instantly detonate. \
			Comes with an integrated micro-computer for configuration purposes."
	item = /obj/item/storage/mail_counterfeit_device
	cost = 1
	surplus = 30

/datum/uplink_item/stealthy_tools/forensics_spofer
	name = "Forensics Spoofing Kit"
	desc = "A box that contains the forensics spoofer (and instructions) which can scan and replicate fingerprints and fibers \
			and apply them to a target object. Helpful for framing crew. Recommend buying soap with your purchase."
	item = /obj/item/storage/box/syndie_kit/forensics_spoofer
	cost = 5
