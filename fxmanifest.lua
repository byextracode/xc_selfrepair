fx_version 'cerulean'
lua54 'yes'
game 'gta5'

name "xc_selfrepair"
version "1.0.0"
description "Drive-thru self repairs vehicle."
author "wibowo#7184"

shared_script "@es_extended/imports.lua"
shared_script "@ox_lib/init.lua"
shared_script "config.lua"
shared_script "shared.lua"

client_script "client/*.lua"
server_script "server/*.lua"

dependencies {
    "es_extended",
    "ox_lib"
}