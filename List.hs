-- | 

module List where

list_concat [] l = l
list_concat (x:xs) l = (x:list_concat xs l)

list_split [] _ = ([],[])
list_split (x:xs) v
  | v == x = ([],xs)
  | otherwise = let (l,r) = list_split xs v in
      ((x:l),r)

insert_last x [] = [x]
insert_last x (y:ys) = (y : insert_last x ys)

list_shift_1 [] = []
list_shift_1 (x:xs) = insert_last x xs

list_shift 0 l = l
list_shift i l = list_shift (i-1) (list_shift_1 l)

list_reverse [] = []
list_reverse [x] = [x]
list_reverse (x:xs) = insert_last x (list_reverse xs)

list_reverse' xs = list_reverse'' [] xs
  where
    list_reverse'' acc [] = acc
    list_reverse'' acc (x:xs) = list_reverse'' (x:acc) xs

swap :: (Ord a) => [a] -> (a -> a -> Bool) -> [a]
swap [] _ = []
swap [x] _ = [x]
swap l@[x,y] p = if p x y then [y,x] else l
swap (x:xs@(y:t)) p = if p x y then (y:swap (x:t) p) else (x:swap xs p)

bubble_sort xs p = bubble_sort' xs (length xs) p where
  bubble_sort' xs i p
    | i == 0 = xs
    | otherwise = bubble_sort' (swap xs p) (i - 1) p

quick_sort [] p = []
quick_sort (x:xs) p = quick_sort [y | y <-xs, p x y] p
  ++ [x]
  ++ quick_sort [y | y <- xs, not $ p x y] p

