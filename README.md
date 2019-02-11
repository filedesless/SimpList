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
