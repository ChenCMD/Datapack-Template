#> api:damage/core/health_subtract
#
# MobのHealthを減算する
#
# @within function api:damage/core/attack

# 処理
    # Player
        execute if entity @s[type=player] run scoreboard players operation $Fluctuation Lib = $Damage Temporary
        execute if entity @s[type=player] run scoreboard players operation $Fluctuation Lib /= $-100 Const
        execute if entity @s[type=player] run function api:concurrent_health_manager/fluctuation
    # Mob
        execute if entity @s[type=!player] run function api:damage/core/non-player-process
# 演出
    execute if data storage lib: Argument{DisableParticle:0b} at @s run function api:damage/core/damage_indicator