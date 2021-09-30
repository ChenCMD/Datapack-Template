#> core:tick/4_interval
#
# 4tick毎にschedule実行されます
#
# @within function
#   core:load_once
#   core:tick/4_interval

# ループの再設定
    schedule function core:tick/4_interval 4t