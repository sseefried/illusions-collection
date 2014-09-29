{-# LANGUAGE RecursiveDo #-}
module Main where

import           FRP.Helm
import qualified FRP.Helm.Keyboard as Keyboard
import qualified FRP.Helm.Window as Window
import           FRP.Elerea.Simple as E
import           FRP.Helm.Time
import           Control.Applicative
import           Debug.Trace

type Pt = (Double, Double)
type V = (Double, Double)

initPos :: Pt
initPos = (0,0)

initV :: (Double, Double)
initV = (5,0)

render :: (Int, Int) -> (Double, Double) -> Element
render (w,h) (x,y) = centeredCollage w h [move (x,y) $ filled red $ circle 32]


currentPos :: SignalGen (Signal Pt)
currentPos = do
  rec
      p  <- transfer initPos f v'
      v  <- transfer initV g p
      v' <- E.delay initV v
  return p
  where
    f (x,y) (x0, y0) = (x0 + x, y0 + y)
    g (x,_) v = if x < -400 then (5,0) else (if x > 400 then (-5,0) else v)


main :: IO ()
main = do
  engine <- startup defaultConfig
  run engine $ render <~ Window.dimensions engine ~~ currentPos
