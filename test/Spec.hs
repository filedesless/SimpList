import Test.Hspec
import Test.QuickCheck

import Chal1

expected =
  [ ([1,2,3], 2)
  , ([1,1,1], 1)
  , ([1..10], 5.5)
  ]

main :: IO ()
main = hspec $ do
  describe "Chal1" $ do

    describe "sigma" $ do
      it "behaves like sum" $
        property $ ((\l -> sum l == sigma l) :: [Int] -> Bool)
      it "equals the sum of the reversed list" $
        property $ ((\l -> sigma l == sigma (reverse l)) :: [Int] -> Bool)

    describe "len" $ do
      it "behaves like length" $
        property $ ((\l -> len l == length l) :: [Int] -> Bool)
      it "equals the length of the reversed list" $
        property $ ((\l -> len l == len (reverse l)) :: [Int] -> Bool)

    describe "avg" $ do
      it "works with basic examples" $
        map avg (map fst expected) `shouldBe` map snd expected
