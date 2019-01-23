module SimpList where

import Prelude hiding (
  (++), head, last, tail, init, null, length,
  map, reverse, foldl, sum, product, take,
  drop, elem, filter, (!!), zip, sort)

data SimpList a = EmptyList | List a (SimpList a)
  deriving (Show, Eq)

(++) :: SimpList a -> SimpList a -> SimpList a
(++) (EmptyList) other = other
(++) (List x xs) other = List x (xs ++ other)

head :: SimpList a -> a
head (EmptyList) = error "head EmptyList"
head (List x _ ) = x

last :: SimpList a -> a
last (List x EmptyList) = x
last (List _ xs) = last xs

tail :: SimpList a -> SimpList a
tail (EmptyList) = error "tail EmptyList"
tail (List _ xs) = xs

init :: SimpList a -> SimpList a
init (EmptyList) = error "init EmptyList"
init (List x EmptyList) = EmptyList
init (List x xs) = List x (init xs)

null :: SimpList a -> Bool
null (EmptyList) = True
null lst = False

length :: SimpList a -> Int
length (EmptyList) = 0
length (List _ xs) = 1 + length xs

map :: (a -> b) -> SimpList a -> SimpList b
map f (EmptyList) = EmptyList
map f (List x xs) = List (f x) (map f xs)

reverse :: SimpList a -> SimpList a
reverse l = rev l EmptyList
  where
    rev (EmptyList) l = l
    rev (List x xs) l = rev xs (List x l)

foldl :: (b -> a -> b) -> b -> SimpList a -> b
foldl _ acc (EmptyList) = acc
foldl f acc (List x xs) = foldl f (f acc x) xs

sum :: Num a => SimpList a -> a
sum (EmptyList) = 0
sum (List x xs) = x + sum xs

product :: Num a => SimpList a -> a
product (EmptyList) = 1
product (List x xs) = x * product xs

take :: Int -> SimpList a -> SimpList a
take 0 _ = EmptyList
take n (List x xs) = List x (take (n - 1) xs)

drop :: Int -> SimpList a -> SimpList a
drop _ EmptyList = EmptyList
drop 0 l = l
drop n (List _ xs) = drop (n - 1) xs

elem :: Eq a => a -> SimpList a -> Bool
elem _ EmptyList = False
elem needle (List current haystack) =
  needle == current || elem needle haystack

filter :: (a -> Bool) -> SimpList a -> SimpList a
filter predicate (EmptyList) = EmptyList
filter predicate (List x xs)
  | predicate x = List x rest
  | otherwise   = rest
  where rest = filter predicate xs

(!!) :: SimpList a -> Int -> a
(!!) lst n
  | n < 0 = error "negative index"
  | otherwise = go lst n
  where
    go (EmptyList) _ = error "index too large"
    go (List x _ ) 0 = x
    go (List _ xs) n = xs !! (n - 1)

zip :: SimpList a -> SimpList b -> SimpList (a, b)
zip (EmptyList) _ = EmptyList
zip _ (EmptyList) = EmptyList
zip (List x xs) (List y ys) = List (x, y) (zip xs ys)

sort :: Ord a => SimpList a -> SimpList a
sort (EmptyList) = EmptyList
sort (List x xs) = sort lesser ++ List x EmptyList ++ sort higher
  where
    lesser = filter (<  x) xs
    higher = filter (>= x) xs
