--!Type(Client)

local CardManager = require("CardManager")

function self:ClientStart()
    CardManager.GenerateDeck()

    local hand = CardManager.DealHand(8)

    for _, card in ipairs(hand) do
        print("[My Card]", card.color, card.value)
    end
end
