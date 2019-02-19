# SimpList

Simple haskell list look-alike for learning purpose, requires [stack](https://docs.haskellstack.org/en/stable/README/)

## Play with the lib

	stack exec ghci

## Build and serve the slides

	gem install bundler
	bundle install
	bundle exec jekyll serve

## Building project

	stack build

## Running driver program

	stack run

## Running test suite

	stack test
	
---

# Challenge 1

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

# Chal2

Implement the 2 following functions

```haskell
-- factorial function (n!)
-- 1*2*3*4...*n-1*n
fact :: Int -> Integer

-- nth element of the fibonacci sequence
-- {1,1,2,3,5,8...}
fib :: Int -> Integer
```

Again, check out `src/Chal2.hs` and `test/Chal2Spec.hs`

Verify with `stack test --ta '-m "/Chal2/"'`

---

# Chal2'

Re-implement `sigma`, `len` and `fact` with folds

Modify your sources in `src/Chal{1,2}.hs` and make sure the tests still pass

---

# Chal3

Write a function `sine m n` that returns an infinite list of elements going up and down like a sine wave between `m` and `n`

```haskell
sine :: Int -> Int -> [Int]
-- Examples:
--   sine 0 3 yields [0,1,2,3,2,1,0,2,3,2,1,...]
--   sine 4 8 yields [4,5,6,7,8,7,6,5,4,5,6,...]
--   sine 3 1 yields [3,2,1,2,3,2,1,2,3,2,1,...]
```

---

# Chal2''

What is the 10000th element of the fibonacci sequence?

Memoize `fib` to cache computation and speed up the process

