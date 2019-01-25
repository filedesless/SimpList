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
	stack ghci src/SimpList.hs

---

# SimpList

The SimpList data type

```haskell
data SimpList α = EmptyList
	            | List α (SimpList α)
```

A "SimpList of α" is defined by either

- an empty list
- or a list with an "α" followed by another "SimpList of α"

where "α" is another type, could be `Int`, `String`, `Bool`, or even another SimpList!

.footnote[
#### Example:

```haskell
λ> empty = EmtyList
λ> single = List "singleton" EmptyList
λ> multiple = List "a" (List "linked" (List "list" EmptyList))
```
]

---

# (++)

The append function, as an infix operator

```haskell
(++) :: SimpList a -> SimpList a -> SimpList a
(++) (EmptyList) other = other
(++) (List x xs) other = List x (xs ++ other)
```

First line is the type signature; (++) is a function which takes two "SimpList of a" as arguments and returns another "SimpList of a", in particular, their concatenation.

It is defined partially as "The concatenation of ..."
- an empty list and another list is the other list
- some (x followed by other xs) and another list is also
  - a list starting with x and followed by the concatenation of the xs and the other list

.footnote[
#### Example:

```haskell
λ> List 1 (List 2 EmptyList) ++ List 3 (List 4 EmptyList)
List 1 (List 2 (List 3 (List 4 EmptyList)))
```
]
