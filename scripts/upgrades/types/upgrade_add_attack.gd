class_name UpgradeAddAttack
extends UpgradeData

@export var attack: AttackData

func apply(_player, manager) -> void:
    var stacks = manager.get_stack(id)

    if stacks <= 0:
        return

    if stacks == 1:
        manager.add_extra_attack(attack)

    # var weapon = player.equipment_manager.get_weapon()
    # if not weapon:
    #     return

    # var final_data = weapon.get_runtime_data()

    # for a in final_data.attacks:
    #     if a.resource_path == attack.resource_path:
    #         return

    # final_data.attacks.append(attack.duplicate(true))