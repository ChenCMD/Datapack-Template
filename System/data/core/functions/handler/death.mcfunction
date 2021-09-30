#> core:handler/death
#
# 死亡時に実行される
#
# @within function core:tick/player

# 死亡時タグを付与
    tag @s add Death
# リセット
    scoreboard players reset @s DeathEvent