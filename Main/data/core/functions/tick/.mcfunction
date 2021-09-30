#> core:tick/
#
# #tick時に毎回実行される処理群
#
# @within tag/function minecraft:tick

# プレイヤー処理部
    execute as @a at @s run function core:tick/player

# tick処理後のプレイヤー処理部
    execute as @a at @s run function core:tick/post-tick-proc_player

# 0-0-0-0-0消失警告
    execute unless entity 0-0-0-0-0 run tellraw @a [{"storage":"global","nbt":"Prefix.ERROR"},{"text":"0-0-0-0-0が参照できません。システム内で重大な問題が発生する可能性があります。"}]