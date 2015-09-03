module Trains where

type Value = Int
type VP = Int

data TurnEffect = NoWaste
                | FreeMtn
                | FreeRiver
                | FreeCity
                | FreePeople
                | RetBought
                | ValForRail Int

data TurnAction = PlayCard Int
                | BuyCard Int
                | Pass


