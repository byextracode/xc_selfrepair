Config  = {}

Config.versionCheck = true -- check for updates

Config.Locale = "en"

Config.repairs = {
    {
        coords = { -- repairs location, could be single vector3 or table array contains multiple vector3.
            vector3(-323.02, -132.16, 38.96),
            vector3(-330.93, -131.89, 39.01),
            vector3(-336.04, -130.24, 39.01),
            vector3(-340.83, -128.36, 39.01),
        },
        duration = 10, -- repairs duration in seconds.
        fee = 5000, -- repairs fee.
        blip = { -- optional, blip configuration for current location.
            label = "Self Repair Burton",
            sprite = 446,
            scale = 0.6,
            color = 6
        },
        marker = { -- optional
            type = 24,
            scale = 0.5
        },
        job = { -- job restriction (optional), could be string or table (array, hash or mixed).
            "mechanic"
        }
    },
    -- below is example of minimum required configuration.
    {
        coords = vector3(735.61, -1083.11, 22.17),
        duration = 10,
        fee = 5000,
    },
    -- could add more locations
}

Config.translation = {
    ["en"] = {
        ["success"] = "Success",
        ["attention"] = "Attention",
        ["failure"] = "Failure",
        ["in_progress"] = "Repairing still in progress",
        ["progress_label"] = "Repairing in progress",
        ["progress_canceled"] = "Repairing has been canceled",
        ["repair_finish"] = "Repairing has been finished",
        ["repair_paid"] = "You paid $%s for repair fee",
        ["context_menu"] = "Self Repair",
        ["context_title"] = "Repair vehicle (%s Seconds)",
        ["context_desc"] = "Fee: $%s",
        ["textui"] = "[E] Self Repair",
        ["not_enough_money"] = "Not enough money to pay repair fee",
        ["unauthorized"] = "You are not authorized to repair here",
    }
}