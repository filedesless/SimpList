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

- polymorphic on any type α
- represented as a simply linked list

```haskell
data SimpList α = EmptyList
	            | List α (SimpList α)
```


.footnote[
#### Example:

```haskell
λ> empty = EmtyList
λ> single = List "singleton" EmptyList
λ> multiple = List "a" (List "linked" (List "list" EmptyList))
```
]

---

# head

returns the first element of a SimpList

```haskell
head :: SimpList a -> a
head (EmptyList) = error "head EmptyList"
head (List x _ ) = x
```

# tail

returns all elements but the head of a SimpList

```haskell
tail :: SimpList a -> SimpList a
tail (EmptyList) = error "tail EmptyList"
tail (List _ xs) = xs
```

---

# (++)

appends to lists, as an infix operator

```haskell
(++) :: SimpList a -> SimpList a -> SimpList a
(++) (EmptyList) other = other
(++) (List x xs) other = List x (xs ++ other)
```

Uses recursion by reduction of the first argument to the base case

.footnote[
#### Example:

```haskell
λ> List 1 (List 2 EmptyList) ++ List 3 (List 4 EmptyList)
List 1 (List 2 (List 3 (List 4 EmptyList)))
```
]


---

# last

returns the last element of a SimpList

```haskell
last :: SimpList a -> a
last (EmptyList) = error "last EmptyList"
last (List x EmptyList) = x
last (List _ xs) = last xs
```

.footnote[
#### Example:

```haskell
λ> last (List 1 (List 2 (List 3 EmptyList)))
3
```
]


---

# init

returns all but the last element of a SimpList

```haskell
init :: SimpList a -> SimpList a
init (EmptyList) = error "init EmptyList"
init (List x EmptyList) = EmptyList
init (List x xs) = List x (init xs)
```

.footnote[
#### Example:

```haskell
λ> init (List 1 (List 2 (List 3 EmptyList)))
List 1 (List 2 EmptyList)
```
]


---

# null

tells if a SimpList is empty

```haskell
null :: SimpList a -> Bool
null (EmptyList) = True
null _ = False
```

.footnote[
#### Example:

```haskell
λ> null (List 1 (List 2 (List 3 EmptyList)))
False
```
]

---

# length

return the number of elements of a SimpList

```haskell
length :: SimpList a -> Int
length (EmptyList) = 0
length (List _ xs) = 1 + length xs
```

.footnote[
#### Example:

```haskell
λ> length (List 1 (List 2 (List 3 EmptyList)))
3
```
]


---

# map

applies a function to all elements of a SimpList and return a SimpList of the results

```haskell
map :: (a -> b) -> SimpList a -> SimpList b
map f (EmptyList) = EmptyList
map f (List x xs) = List (f x) (map f xs)
```

.footnote[
#### Example:

```haskell
λ> map (+ 2) (List 1 (List 2 (List 3 EmptyList)))
List 3 (List 4 (List 5 EmptyList))
```
]

---

# reverse

returns the SimpList in reversed order

```haskell
reverse :: SimpList a -> SimpList a
reverse input = rev input EmptyList
  where
    rev (EmptyList) output = output
    rev (List x xs) output = rev xs (List x output)
```

* _where_ defines an auxiliary recursive function used to prepend to an output list all elements of the input list

.footnote[
#### Example:

```haskell
λ> reverse (List 1 (List 2 (List 3 EmptyList)))
List 3 (List 2 (List 1 EmptyList))
```
]

---

# foldl

folds a SimpList into a single value from a given binary function and a seed

foldl f acc [x1, x2, x3] = f (f (f acc x1) x2) x3

```haskell
foldl :: (b -> a -> b) -> b -> SimpList a -> b
foldl _ acc (EmptyList) = acc
foldl f acc (List x xs) = foldl f (f acc x) xs
```

.footnote[
#### Example:

```haskell
λ> foldl (+) 10 (List 1 (List 2 (List 3 EmptyList)))
16
```
]


---

# reverse (again)

we can now use foldl to implement reverse in a simpler manner

```haskell
reverse :: SimpList a -> SimpList a
reverse = foldl (\acc x -> List x acc) EmptyList
```

arguments are omitted; reverse is the result of foldl's partial application

---

# sum

returns the sum of a numerical SimpList

```haskell
sum :: Num a => SimpList a -> a
sum (EmptyList) = 0
sum (List x xs) = x + sum xs
```

.footnote[
#### Example:

```haskell
λ> sum (List 1 (List 2 (List 3 (List 4 EmptyList))))
10
```
]

---

# product

returns the product of a numerical SimpList

```haskell
product :: Num a => SimpList a -> a
product (EmptyList) = 1
product (List x xs) = x * product xs
```

.footnote[
#### Example:

```haskell
λ> product (List 1 (List 2 (List 3 (List 4 EmptyList))))
24
```
]

---

# take

`take n` returns the `n` first elements of a SimpList

```haskell
take :: Int -> SimpList a -> SimpList a
take 0 _ = EmptyList
take n (List x xs) = List x (take (n - 1) xs)
```

.footnote[
#### Example:

```haskell
λ> take 2 (List 1 (List 2 (List 3 (List 4 EmptyList))))
List 1 (List 2 EmptyList)
```
]

---

# drop

`drop n` returns all elements but the `n` firsts of a SimpList

```haskell
drop :: Int -> SimpList a -> SimpList a
drop _ EmptyList = EmptyList
drop 0 l = l
drop n (List _ xs) = drop (n - 1) xs
```

.footnote[
#### Example:

```haskell
λ> drop 2 (List 1 (List 2 (List 3 (List 4 EmptyList))))
List 3 (List 4 EmptyList)
```
]

---

# elem

tells if a value is element of a SimpList

```haskell
elem :: Eq a => a -> SimpList a -> Bool
elem _ EmptyList = False
elem needle (List current haystack) =
  needle == current || elem needle haystack
```

.footnote[
#### Example:

```haskell
λ> elem 3 (List 1 (List 2 (List 3 (List 4 EmptyList))))
True
```
]

---

# (!!)

`l !! n` returns the `n`th element of the SimpList `l`

```hakell
(!!) :: SimpList a -> Int -> a
(!!) (EmptyList) _ = error "index too large"
(!!) (List x _ ) 0 = x
(!!) (List _ xs) n
  | n < 0     = error "negative index"
  | otherwise = xs !! (n - 1)
```

.footnote[
#### Example:

```haskell
λ> List 1 (List 2 (List 3 (List 4 EmptyList))) !! 2
3
```
]

---

# zip

returns a SimpList of pairs from elements of two given SimpList

```haskell
zip :: SimpList a -> SimpList b -> SimpList (a, b)
zip (EmptyList) _ = EmptyList
zip _ (EmptyList) = EmptyList
zip (List x xs) (List y ys) = List (x, y) (zip xs ys)
```

.footnote[
#### Example:

```haskell
λ> zip (List 1 (List 2 EmptyList)) (List 3 (List 4 EmptyList))
List (1,3) (List (2,4) EmptyList)
```
]

---

# filter

returns all elements of a SimpList matching a given predicate

```haskell
filter :: (a -> Bool) -> SimpList a -> SimpList a
filter predicate (EmptyList) = EmptyList
filter predicate (List x xs)
  | predicate x = List x rest
  | otherwise   = rest
  where rest = filter predicate xs
```

.footnote[
#### Example:

```haskell
λ> filter odd (List 1 (List 2 (List 3 (List 4 EmptyList))))
List 1 (List 2 EmptyList)
```
]

---

# partition

returns a tuple of elements of a SimpList that do and do not match the given predicate

```haskell
partition :: (a -> Bool) -> SimpList a -> (SimpList a, SimpList a)
partition predicate (EmptyList) = (EmptyList, EmptyList)
partition predicate (List x xs)
  | predicate x = (List x left, right)
  | otherwise   = (left, List x right)
  where (left, right) = partition predicate xs
```

.footnote[
#### Example:

```haskell
λ> partition (< 3) (List 1 (List 2 (List 3 (List 4 (List 5 EmptyList)))))
( List 1 (List 2 EmptyList) , List 3 (List 4 (List 5 EmptyList)) )
```
]

---

# sort

naive quicksort implementation

```haskell
sort :: Ord a => SimpList a -> SimpList a
sort (EmptyList) = EmptyList
sort (List x xs) = sort left ++ List x EmptyList ++ sort right
  where (left, right) = partition (< x) xs
```

.footnote[
#### Example:

```haskell
λ> sort (List 4 (List 3 (List 1 (List 2 EmptyList))))
List 1 (List 2 (List 3 (List 4)))
```
]
