#> api:heal/core/player
#
# プレイヤーに対する処理
#
# @within function api:heal/

#> Private
# @private
    #declare score_holder $Fluctuation

# 代入
    execute store result score $Fluctuation Lib run data get storage lib: Argument.Heal 100
# 負数の場合の処理
    execute if score $Fluctuation Lib matches ..-1 run scoreboard players set $Fluctuation Lib 0
# Healthを持つEntityであれば実行
    function api:concurrent_health_manager/fluctuation