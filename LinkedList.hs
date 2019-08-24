-- | Linked List

module LinkedList where

data LinkedList a = Nil | Cons a (LinkedList a)
  deriving Show

empty :: LinkedList a -> Bool
empty Nil = True
empty (Cons _ _) = False

insert :: LinkedList a -> a -> LinkedList a
insert l x = Cons x l

listLength :: LinkedList a -> Int
listLength Nil = 0
listLength (Cons _ t) = listLength t + 1

head :: LinkedList a -> Maybe a
head Nil = Nothing
head (Cons h _) = Just h

tail :: LinkedList a -> Maybe (LinkedList a)
tail Nil = Nothing
tail (Cons _ t) = Just t
