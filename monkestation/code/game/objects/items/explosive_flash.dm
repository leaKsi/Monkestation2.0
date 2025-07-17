/obj/item/assembly/flash/explosive
	desc = "A powerful and versatile flashbulb device, with applications ranging from disorienting attackers to \
	acting as visual receptors in robot production. This one seems slightly heavier than usual."

	var/mob/living/activated_by

/obj/item/assembly/flash/explosive/attack(mob/living/M, mob/living/user)
	prepare_boom(user)

/obj/item/assembly/flash/explosive/attack_self(mob/living/carbon/user, flag, emp)
	prepare_boom(user)

/obj/item/assembly/flash/explosive/proc/prepare_boom(mob/living/user)
	if(!istype(user) || QDELETED(user))
		return

	activated_by = user
	user.visible_message("[user] presses a button on top of the flash... [span_red("what was that sound?")]")
	playsound(src, 'sound/machines/beep.ogg', 100, TRUE)
	addtimer(CALLBACK(src, PROC_REF(detonate), src), 1.5 SECONDS)
	burn_out()

/obj/item/assembly/flash/explosive/proc/detonate()
	message_admins("[ADMIN_LOOKUPFLW(activated_by)] detonated an explosive flash!")
	activated_by?.log_message("detonated an explosive flash.", LOG_GAME)
	explosion(src, devastation_range = 0, heavy_impact_range = 2, light_impact_range = 4, flame_range = 2, flash_range = 7)
	qdel(src)
