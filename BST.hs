-- | Binary Search Tree

module BST where

data BST a = BSTNil | BSTNode a (BST a) (BST a)
  deriving Show

fromList :: (Ord a, Eq a) => [a] -> BST a
fromList [] = BSTNil
fromList xs = fromList' BSTNil xs
  where
    fromList' t [] = t
    fromList' t (x:xs') = fromList' (insertNode t x) xs'

insertNode :: (Ord a, Eq a) => BST a -> a -> BST a
insertNode BSTNil v = BSTNode v BSTNil BSTNil
insertNode t@(BSTNode x l r) v
  | v == x = t
  | v < x = BSTNode x (insertNode l v) r
  | v > x = BSTNode x l (insertNode r v)

empty :: BST a -> Bool
empty BSTNil = True
empty _ = False

contains :: (Ord a, Eq a) => BST a -> a -> Bool
contains BSTNil _ = False
contains (BSTNode x l r) v =
  v == x || (v < x && contains l v) || (v > x && contains r v)

height :: BST a -> Int
height BSTNil = 0
height (BSTNode _ l r) = max (height l) (height r) + 1

sumOfElems :: (Integral a) => BST a -> a
sumOfElems BSTNil = 0
sumOfElems (BSTNode x l r) = (sumOfElems l) + (sumOfElems r) + x

numOfNodes :: BST a -> Int
numOfNodes BSTNil = 0
numOfNodes (BSTNode _ l r) = (numOfNodes l) + (numOfNodes r) + 1

numOfLeafs :: BST a -> Int
numOfLeafs BSTNil = 0
numOfLeafs (BSTNode _ BSTNil BSTNil) = 1
numOfLeafs (BSTNode _ l r) = (numOfLeafs l) + (numOfLeafs r)

minValue :: (Ord a, Eq a) => BST a -> a
minValue BSTNil = error "The minimum value cannot be calculated for an empty tree."
minValue (BSTNode x BSTNil _) = x
minValue (BSTNode _ l _) = minValue l

deleteNode :: (Ord a, Eq a) => BST a -> a -> BST a
deleteNode BSTNil _ = BSTNil
deleteNode t@(BSTNode x BSTNil BSTNil) v =
  if v == x then BSTNil else t
deleteNode (BSTNode x l r) v
  | v == x = let mv = minValue r in (BSTNode mv l (deleteNode r mv))
  | v < x = BSTNode x (deleteNode l v) r
  | v > x = BSTNode x l (deleteNode r v)
