module Game where

import Control.Monad.State
import Cards
import Turn

data PlayerCards = PlayerCards
                 { hand :: Cards
                 , deck :: Cards
                 , discard :: Cards
                 }

data GameState = GameState
               { playerCards :: [PlayerCards]
               , lastTurn :: Int
               }

type Game = StateT GameState IO

mkTurn :: PlayerCards -> TurnState
mkTurn (PlayerCards hand deck discard) = TurnState hand deck discard [] [] 0 0 True

game :: Game ()
game = do
    gs <- get
    let nextTurn = (lastTurn gs) + 1 `mod` 4
    let ts = mkTurn . (!! nextTurn) $ playerCards gs
    ts <- lift $ runStateT turn ts
    game