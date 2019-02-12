module Chal2Spec where

import Test.Hspec
import Test.QuickCheck

import Chal2

spec :: Spec
spec = do

  describe "fact" $ do
    it "works with the base case" $
      map fact [0, 1, 2] `shouldBe` [1, 1, 2]
    it "works with arbitrary examples" $
      property $ (\n -> (n :: Int) < 1 || fact n == product [1..n])

  describe "fib" $ do
    it "works with the base case" $
      map fib [1..10] `shouldBe` [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
