--!Type(Module)

local CardManager = {}

local allCards = {}

local function CreateCard(color, value)
    return {
        id = (color or "wild") .. "_" .. value,
        color = color or "wild",
        value = tostring(value),
        image = "Assets/Downloads/UI Stuff/Cards/" .. (color or "wild") .. "_" .. value .. ".png"
    }
end

function GenerateDeck()
    print("[CardManager] Generating full deck...")

    allCards = {}

    local colors = { "red", "blue", "green", "yellow" }
    local values = { 1,2,3,4,5,6,7,8,9 }

    -- Add colored cards
    for _, color in ipairs(colors) do
        -- Add one 0 card
        table.insert(allCards, CreateCard(color, 0))

        -- Two of each 1–9, skip, reverse, draw2
        for _, value in ipairs(values) do
            table.insert(allCards, CreateCard(color, value))
            table.insert(allCards, CreateCard(color, value))
        end

        for _, special in ipairs({ "skip", "reverse", "draw2" }) do
            table.insert(allCards, CreateCard(color, special))
            table.insert(allCards, CreateCard(color, special))
        end
    end

    -- Add 4 wild and 4 wild draw4 cards
    for i = 1, 4 do
        table.insert(allCards, CreateCard(nil, "wild"))
        table.insert(allCards, CreateCard(nil, "draw4"))
    end

    ShuffleDeck()
end

function ShuffleDeck()
    math.randomseed(os.time())
    for i = #allCards, 2, -1 do
        local j = math.random(1, i)
        allCards[i], allCards[j] = allCards[j], allCards[i]
    end
end

function DealHand(cardCount)
    local hand = {}
    for i = 1, cardCount do
        if #allCards == 0 then break end
        table.insert(hand, table.remove(allCards, 1))
    end
    return hand
end

function GetDeck()
    return allCards
end

return CardManager
