#> core:load_once
#
# #load時に一回のみ実行される処理群
#
# @within function core:load

#> バージョン情報の設定と通知
data modify storage global Version set value 1
tellraw @a [{"text": "Updated load version to ", "color": "green"},{"storage": "global","nbt":"Version","color": "aqua"}]


#> forceload chunks
execute in overworld run forceload add -1 -1 0 0
execute in overworld run forceload add 10000 10000


#> gameruleの設定
function core:define_gamerule


#> Datapackの順序の明示的設定
# 0: Main
# 1: ScoreToHealth
# 2: OhMyDat
datapack disable "OhMyDat"
datapack disable "ScoreToHealth"
datapack enable "ScoreToHealth" after "Main"
datapack enable "OhMyDat" after "ScoreToHealth"


#> エイリアスの登録とシャルカーボックスのsetblock
# @public
    #alias vector shulkerA 10000 0 10000
    #alias vector shulkerB 10000 1 10000
execute in overworld run setblock 10000 0 10000 lime_shulker_box{Lock:"lock"}
execute in overworld run setblock 10000 1 10000 lime_shulker_box{Lock:"lock"}


#> グローバルstorageの設定
# @public
#declare storage global


#> リセット必須オブジェクト類の削除
scoreboard objectives remove FirstJoinEvent
kill 0-0-0-0-0


#> ベクトル用等のシステム内汎用Entityのエイリアスの登録とsummon
# @public
#alias entity commonEntity 0-0-0-0-0
summon marker 0.0 0.0 0.0 {UUID:[I;0,0,0,0]}


#> スコアボード類
    #> 1tickで消す一時変数の保存用スコアボード
    # @public
        scoreboard objectives add Temporary dummy

    #> 常に値が設定される変数用スコアボード
    # @public
        scoreboard objectives add Global dummy
    # 乱数値の設定
        #> Private
        # @private
            #declare tag Random
        summon minecraft:area_effect_cloud ~ ~ ~ {Age:-2147483648,Duration:-1,WaitTime:-2147483648,Tags:["Random"]}
        execute store result score $Random.Base Global run data get entity @e[tag=Random,limit=1] UUID[1]
        execute store result score $Random.Carry Global run data get entity @e[tag=Random,limit=1] UUID[3]
        kill @e[tag=Random,limit=1]

    #> 定数類用スコアボード **変更厳禁**
    # @public
        scoreboard objectives add Const dummy
    function core:define_const

    #> UserID
    # @public
        scoreboard objectives add UserID dummy {"text":"汎用固有ユーザーID"}

    #> イベントハンドラ用スコアボード
    # @within function
    #   core:load_once
    #   core:handler/*
    #   core:tick/*
        scoreboard objectives add FirstJoinEvent custom:play_time {"text":"イベント: 初回Join"}
        scoreboard objectives add RejoinEvent custom:leave_game {"text":"イベント: 再Join"}
        scoreboard objectives add DeathEvent deathCount {"text":"イベント: 死亡"}
        scoreboard objectives add RespawnEvent custom:time_since_death {"text":"イベント: リスポーン"}
        scoreboard objectives add ClickCarrotEvent used:carrot_on_a_stick {"text":"イベント: クリック 人参棒"}
        scoreboard objectives add Sneak custom:sneak_time {"text":"イベント: スニーク"}

    #> Library用スコアボード
    # @public
        scoreboard objectives add Lib dummy {"text":"ライブラリの引数/返り値用"}

    #> Library用スコアボード - PrivateUse
    # @within * api:**
        scoreboard objectives add ScoreToHPFluc dummy


#> Scheduleループの初期化(replace)
    schedule function core:tick/4_interval 4t