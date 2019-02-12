module Chal1 where

-- sum of a list
sigma :: Num a => [a] -> a
sigma [] = 0
sigma (h:t) = h + sigma t

-- length of a list
len :: Num p => [a] -> p
len [] = 0
len (_:t) = 1 + len t

-- average of a list
avg :: Fractional a => [a] -> a
avg l = sigma l / len l
