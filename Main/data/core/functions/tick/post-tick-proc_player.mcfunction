#> core:tick/post-tick-proc_player
#
# tickの基本的な処理を終えた後に実行されるプレイヤーのtick処理
#
# @within function core:tick/

# プレイヤーの体力の変更Queueの消化
    execute if entity @s[predicate=api:has_health_modify_score] run function api:concurrent_health_manager/proc

# リセット
    scoreboard players reset @s[scores={Sneak=1..},predicate=!lib:is_sneaking] Sneak