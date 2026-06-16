module Modulo7 where
import Utils


-- 1) Inferí el tipo de esta función:  f1 x y = x == y

f1 :: Eq a => a -> a -> Bool
f1 x y = x == y

-- 2) Inferí el tipo de esta función: f2 x y = x + length y

f2 ::  Int -> [a] -> Int
f2 x y = x + length y 

-- 3) f3 f x = f x > 10

f3 :: (Ord a, Num a) => (t -> a) -> t -> Bool
f3 f x = f x > 10

-- 5) Queremos una función genérica: cumpleCondicionSegun, una función para sacar un dato de una persona | una condición sobre ese dato | una persona


