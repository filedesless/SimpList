module Chal3Spec where

import Test.Hspec
import Test.QuickCheck

import Chal3

expected =
  [ ((2, 4), [2,3,4,3,2,3,4,3,2,3,4,3,2,3,4,3,2,3,4,3])
  , ((0, 8), [0,1,2,3,4,5,6,7,8,7,6,5,4,3,2,1,0,1,2,3])
  , (((-5), 5), [-5,-4,-3,-2,-1,0,1,2,3,4,5,4,3,2,1,0,-1,-2,-3,-4])
  , ((2, 3), [2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3])
  , ((1, 1), take 20 $ repeat 1)
  , ((8, 3), [8,7,6,5,4,3,4,5,6,7,8,7,6,5,4,3,4,5,6,7])
  ]

spec :: Spec
spec = do

  describe "sine" $ do
    it "works with the given examples" $
      map (take 20 . uncurry sine) (map fst expected) `shouldBe` map snd expected
