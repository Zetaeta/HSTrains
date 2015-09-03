module Turn where

import Control.Monad.State
import Control.Monad.Trans.Error
import Trains
import Cards

data TurnState = TurnState
           { hand :: Cards
           , deck :: Cards
           , discard :: Cards
           , played :: Cards
           , gained :: Cards
           , value :: Value
           , vpGain :: VP
           , canPass :: Bool
           }

type Turn = ErrorT String (StateT TurnState IO)

whatDo :: Turn TurnAction
whatDo = return $ PlayCard 0

pass :: Turn ()
pass = undefined

invalid :: String -> Turn ()
invalid = undefined

turn :: Turn TurnState
turn = do
    result <- doTurn
    get

doTurn :: Turn TurnState
doTurn = do
    act <- whatDo
    ts <- get
    case act of
        Pass -> if canPass ts then pass else invalid "You cannot pass!"
    get