module Main where

import           FRP.Helm
import qualified FRP.Helm.Keyboard as Keyboard
import qualified FRP.Helm.Window as Window
import           FRP.Elerea.Simple
import           FRP.Helm.Time

data State = State { mx :: Double, my :: Double }

sz = 50
mag = 250
n = 5
slowDown = 3000

sinT :: Double -> Double
sinT a = sin (turns a)

render' :: (Int, Int) -> Time -> Element
render' (w,h) t = centeredCollage w h ((filled red $ circle ((mag+sz/2)*1.1)): (squares t))

squares :: Time -> [Form]
squares t = map (\a -> squareAnim a t) [0,step..1/2-step]
  where step = 1 / (2*fromIntegral n)

squareAnim :: Double -> Time -> Form
squareAnim a t =  move (rot a' (mag*sinT (t/slowDown + a), 0)) $ rotate a' $  filled white $ square sz
  where a' = turns a

rot :: Double -> (Double, Double) -> (Double, Double)
rot a (x,y) = (x*cos a - y*sin a, x*sin a + y*cos a)

main :: IO ()
main = do
    engine <- startup defaultConfig
    run engine $ render' <~ Window.dimensions engine ~~ running