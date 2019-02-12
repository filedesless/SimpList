
# SimpList

## a gentle introduction to

<br /><br />
.center[
![haskell](https://www.haskell.org/static/img/haskell-logo.svg)<br />
An advanced, purely functional programming language]

---

# Whoami

Félix Larose-Gervais, aka filedesless

Nerd with interests in security, algorithmics, and functional programming

Finishing my bachelor's degree in computer science @ Université Laval

Working as a system administrator / IT analyst there

---

# Haskell

Haskell is a computer programming language

In particular, it is a polymorphically statically typed, lazy, purely functional language

The language is named for Haskell Brooks Curry, whose work in mathematical logic serves as a foundation for functional languages

Haskell is based on the lambda calculus, hence the lambda used in the logo

---

# Stack

Stack is a cross-platform program for developing Haskell projects

### Installing

	curl https://get.haskellstack.org | sh

### Following along

	git clone https://github.com/filedesless/SimpList
	cd SimpList
	stack exec ghci

---

# A haskell primer

A program is a set of expression
(`True`, `False`, `42`, `2.5`, `'h'`, `"hello world"`, etc...)

Expressions are categorized into types
(`Bool`, `Int`, `Float`, `Char`, `String`, etc...)

We can see a type as a set of possible values for a given expression

Types are bound by functions, which are the definition of a computation required to produce values of a certain type given another type

---

# Functions

A function is a relation that associates each element `x` of a set `X`, to a single element `y` of another set `Y` (possibly the same set)

```haskell
odd :: Int -> Bool
abs :: Int -> Int
words :: String -> [String]
length :: [a] -> Int
```

.center[![](https://upload.wikimedia.org/wikipedia/commons/d/df/Function_color_example_3.svg)]

---

# Simple application

fire up GHCi, The Glorious Glasgow Haskell Compilation System (interpreter)

`$ stack exec ghci`

- `:h` for help
- `:t` for type introspection
- `:{\n ... lines ... \n:}\n` for multiline input

```haskell
Prelude> odd 2
False
Prelude> abs (-2)
2
Prelude> length [1,2,3,4,5]
5
Prelude> words "hello world"
["hello","world"]
Prelude> 2 + 2
4
```

---

# Algebraic Data Types

Types constructed from "algebraic" operations, in particular with "sum" and "product"

```haskell
-- "sum" is alternation (A | B, meaning A or B but not both)
data Boolean = False | True
data Suit = Club | Diamond | Heart | Spade
	deriving (Show, Eq)

data Value = Two | Three | Four | Five | Six
		   | Seven | Eight | Nine | Ten
		   | Jack | Queen | King | Ace
	deriving (Show, Eq)

-- "product" is combination (A B, meaning A and B together)
data Card = C Value Suit
	deriving (Show, Eq)


Prelude> C Two Club
C Two Club
Prelude> :t C Two Club
C Two Club :: Card
```

---

# Polymorphic Data Types

Also called parametrized data types, they allow functions to be reused on multiple types

```haskell
-- Sum types
-- Expressive way to declare something as "Nullable"
data Maybe a = Nothing | Just a

-- Generally used to return a normal value, or an error of different type
data Either a b = Left a | Right b

-- Product types
-- Double ended queue
data Deque a = Deque [a] [a]

-- Rose tree
data Tree a = Node a [Tree a]

-- Sum and product of types
-- Linked list
data List a = Nil | Cons a (List a)
```

---

# Lists

```haskell
data List a = Nil | Cons a (List a)
```

To save typing, we have the syntactic sugar `Nil = []` and the infix operator `:` for `Cons`

Few examples:

```haskell
Prelude> 1 : 2 : 3 : 4 : []
[1,2,3,4]
Prelude> [1,2,3,4,5,6]
[1,2,3,4,5,6]
Prelude> [1..10]
[1,2,3,4,5,6,7,8,9,10]
Prelude> [5,10..20]
[5,10,15,20]
Prelude> [1..]
[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24 ...
Prelude> [ toEnum x :: Char | x <- [66..90] ++ [98..122], even x ]
"BDFHJLNPRTVXZbdfhjlnprtvxz"
```

---

# Map / Reduce

```haskell
Prelude> :t fmap
fmap :: Functor f => (a -> b) -> f a -> f b


Prelude> :t foldl
foldl :: Foldable t => (b -> a -> b) -> b -> t a -> b
```

```haskell
λ> fmap odd [1,2,3,4,5]
[True,False,True,False,True]
λ> foldl (+) 0 [1,2,3,4,5]
15
```

---

# Typeclasses - Eq

For types that support an (in)equality test

```haskell
class Eq a where
  (==) :: a -> a -> Bool
  (/=) :: a -> a -> Bool
  {-# MINIMAL (==) | (/=) #-}
```

---

# Typeclasses - Ord

For types that support full ordering of elements

```haskell
class Eq a => Ord a where
  compare :: a -> a -> Ordering
  (<) :: a -> a -> Bool
  (<=) :: a -> a -> Bool
  (>) :: a -> a -> Bool
  (>=) :: a -> a -> Bool
  max :: a -> a -> a
  min :: a -> a -> a
  {-# MINIMAL compare | (<=) #-}
```

---

# Typeclasses - Functor

For types that support mapping

```haskell
class Functor (f :: * -> *) where
  fmap :: (a -> b) -> f a -> f b
  (<$) :: a -> f b -> f a
  {-# MINIMAL fmap #-}
```

---

# Typeclasses - Foldable

For types that support reducing

```haskell
class Foldable (t :: * -> *) where
  Data.Foldable.fold :: Monoid m => t m -> m
  foldMap :: Monoid m => (a -> m) -> t a -> m
  foldr :: (a -> b -> b) -> b -> t a -> b
  Data.Foldable.foldr' :: (a -> b -> b) -> b -> t a -> b
  foldl :: (b -> a -> b) -> b -> t a -> b
  Data.Foldable.foldl' :: (b -> a -> b) -> b -> t a -> b
  foldr1 :: (a -> a -> a) -> t a -> a
  foldl1 :: (a -> a -> a) -> t a -> a
  Data.Foldable.toList :: t a -> [a]
  null :: t a -> Bool
  length :: t a -> Int
  elem :: Eq a => a -> t a -> Bool
  maximum :: Ord a => t a -> a
  minimum :: Ord a => t a -> a
  sum :: Num a => t a -> a
  product :: Num a => t a -> a
  {-# MINIMAL foldMap | foldr #-}
```

---

# Composition

```haskell
Prelude> :t (.)
(.) :: (b -> c) -> (a -> b) -> a -> c

Prelude> numWords = length . words
Prelude> numWords "tasty test of some words"
5

Prelude> sumOdds = sum . filter odd
Prelude> sumOdds [1..20]
100

Prelude> import Data.List
Prelude Data.List> sortWords = unwords . sort . words
Prelude Data.List> sortWords "some words are better sorted"
"are better some sorted words"
```

---

# Problem solving

Tells if a list is empty

(stupid version)

```haskell
Prelude> empty xs = length xs == 0 -- or
Prelude> empty = (== 0) . length
```

(better answer)

```haskell
Prelude> :{
Prelude| empty [] = True
Prelude| empty xs = False
Prelude| :}
Prelude> empty []
True
Prelude> empty ["some", "elements"]
False
```

---

# Problem solving

Get the difference between the smallest and largest element of a list

```haskell
Prelude> diffMinMax l = maximum l - minimum l
Prelude> diffMinMax [10..42]
32
```

Find the first element that is smaller than its predecessor in a list

```haskell
Prelude> :{
Prelude| firstSmaller (a:b:rest)
Prelude|   | b < a = b
Prelude|   | otherwise = firstSmaller (b : rest)
Prelude| :}
Prelude> firstSmaller [ x * x | x <- [-5..5] ]
16
```

---

# Chal1

Implement the 3 following functions

```haskell
-- sum of a list
sigma :: Num a => [a] -> a
-- length of a list
len :: Num p => [a] -> p
-- average of a list
avg :: Fractional a => [a] -> a
```

Check out `src/Chal1.hs`, and `test/Chal1Spec.hs`

run all the tests with

`stack test`

or particular tests with

`stack test --ta '-m "/Chal1/sigma/"'`

`stack test --ta '-m "/Chal1/sigma/behaves like sum/"'`

---

# Chal1

Solution:

```haskell
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
```

---

# conclusion

that's all folks!

some resources to learn haskell:

- https://wiki.haskell.org/Haskell
- http://learnyouahaskell.com

but practice makes perfect:

- https://adventofcode.com
- https://projecteuler.net
- https://www.codewars.com
