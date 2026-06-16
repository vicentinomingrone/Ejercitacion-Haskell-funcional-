module Modulo4 where
import Utils


-- 1) Definí miLength, que recibe una lista y devuelve su cantidad de elementos. Usá recursividad y pattern matching.

miLength :: Num a => [a] -> Int
miLength [] = 0 
miLength (_:xs) = 1 + miLength xs


-- 2) Definí miSum, que recibe una lista de números y devuelve la suma.

miSum :: Num a => [a] -> a
miSum [] = 0
miSum (x:xs) = x + miSum xs   

-- 3) Definí miProduct, que recibe una lista de números y devuelve el producto.

miProduct :: Num a => [a] -> a 
miProduct [] = 1
miProduct (x:xs) = x * miProduct xs

-- 4) Definí primerosNaturales, que sea una lista infinita desde 1 en adelante.

primerosNaturales :: [Int] 
primerosNaturales = [1..]  

-- 5) Definí muchosDe, que recibe un valor y devuelve una lista infinita con ese valor repetido.

muchosDe :: a -> [a]
muchosDe valor = valor : muchosDe valor  

-- 6) Definí miElem, que recibe un valor y una lista, y devuelve True si el valor está en la lista.

miElem :: Eq a => a -> [a] -> Bool
miElem valor [] = False 
miElem valor (x:xs) = valor == x || miElem valor xs

-- 7) Definí miTake, que recibe un número n y una lista, y devuelve los primeros n elementos.

miTake :: Int -> [a] -> [a]
miTake 0 _ = []
miTake _ [] = []
miTake n (x:xs) = x : miTake (n - 1) xs

-- 8) Definí miDrop, que recibe un número n y una lista, y devuelve la lista sin los primeros n elementos.

