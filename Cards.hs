module Cards where

import Trains

data CardType = TrainC | RailC | StationC | ActionC | PointsC | WasteC

type Cards = [Card]

data Card = Card
    { typ :: CardType
    , value :: Value
    , cost :: Value
    , vp :: VP
    , effect :: Maybe CardEffect
    , name :: String
    }


data CardEffect = Action Action | MakeStation | LayRail { lrEff :: CardEffect }

data Action = Then { first :: Action, second :: Action }
            | WasteA
            | Draw Int
            | GuessDraw
            | WantNext
            | ChooseFromRet { choose :: Int, from :: Int }
            | RetWaste (Maybe Int)
            | RetWasteValue
            | DiscardDraw Int
            | DiscardDrawAny
            | Discard Int
            | DiscardVal
            | UpgradeTrain { valDiff :: Int }
            | GainVal Int
            | Either3 Action Action Action
            | TurnEffect [TurnEffect]
            | RetFromPlay (Maybe CardType)
            | GainFromDisc (Maybe CardType)
            | DupAction
            | DupTrainVal
            | SearchDiscard CardType Int
            | GainVP Int
            | DupTrain
    
cards = []

amusementPark = Card ActionC 1 4 0 (Just . Action $ DupTrainVal) "Amusement Park"
commandCentral = Card ActionC 0 3 0 (Just . Action $ Draw 1 `Then` GuessDraw) "Command Central"
landfill = Card ActionC 0 2 0 (Just . Action $ RetWaste Nothing) "Landfill"

normalTrain = Card TrainC 1 1 0 Nothing "Normal Train"
expressTrain = Card TrainC 2 3 0 Nothing "Express Train"
limexTrain = Card TrainC 3 6 0 Nothing "Limited Express Train"

earlyTrain = Card TrainC 2 5 0 (Just . Action $ TurnEffect [RetBought]) "Early Train"
freightTrain = Card TrainC 1 4 0 (Just . Action $ RetWasteValue) "Freight Train"
mailTrain = Card TrainC 1 4 0 (Just . Action $ RetWasteValue) "Mail Train" -- Cost ?
touristTrain = Card TrainC 1 4 0 (Just . Action $ GainVP 1) "Tourist Train"