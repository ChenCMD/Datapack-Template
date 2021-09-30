#> core:handler/first_join
#
# 初回Join時に実行される
#
# @within function core:tick/player

#> UserIDのIndex
# @private
    #declare score_holder $UserIDIndex

# 固有ユーザーID
    scoreboard players add $UserIDIndex Global 1
    scoreboard players operation @s UserID = $UserIDIndex Global
# リスポーンイベントが初回に発火しないように
    scoreboard players set @s RespawnEvent 81