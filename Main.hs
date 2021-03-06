{-# LANGUAGE Arrows #-}

import FRP.Yampa
import Control.Concurrent

type Pos = Double
type Vel = Double

fallingBall :: Pos -> SF () (Pos, Vel)
fallingBall y0 = (constant (-9.81) >>> integral) >>> ((integral >>^ (+ y0)) &&& identity)

main :: IO ()
main = reactimate (return ()) 
                  (\_ -> threadDelay 100000 >> return (0.1, Nothing)) 
                  (\_ (pos, vel) -> putStrLn ("p: " ++ show pos ++ ", v: " ++ show vel) >> return False)
                  (fallingBall 10.0)