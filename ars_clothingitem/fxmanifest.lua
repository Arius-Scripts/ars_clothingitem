fx_version "cerulean"
game "gta5"
lua54 "yes"

author "Arius Development"
description "Item based clothing"
version "1.0.0"

client_scripts {"client/*.lua", "shop/client/*.lua"}
server_scripts {'@oxmysql/lib/MySQL.lua', "shop/server/*.lua"}
shared_scripts {"@ox_lib/init.lua", "config.lua","shop/shared/*.lua"}
