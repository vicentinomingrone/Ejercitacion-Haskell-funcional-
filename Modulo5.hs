module Modulo5 where
import Utils



-- 1) Definí dobles, que recibe una lista de números y devuelve una lista con todos duplicados. Usa MAP. 

dobles :: Num a =>  [a] -> [a]
dobles lista = map (*2) lista 

-- 2) Definí mayoresA10, que recibe una lista de números y devuelve solo los mayores a 10. Usá filter.

mayoresA10 :: (Num a, Ord a) => [a] -> [a]
mayoresA10 lista = filter (> 10) lista 


-- 3) Definí hayAlgunPar, que recibe una lista de números y devuelve True si algún número es par. Usa any 

hayAlgunPar :: [Int] -> Bool
hayAlgunPar = any even 

-- 4) Definí todosPositivos, que recibe una lista de números y devuelve True si todos son mayores a 0. usa all 

todosPositivos :: [Int] -> Bool
todosPositivos = all (>0)


-- 5) Definí sumarTodos, que recibe una lista de números y devuelve la suma total. usa Foldl 

sumarTodos :: [Int] -> Int 
sumarTodos = foldl (+) 0 

-- 6) Definí largosDePalabras, que recibe una lista de palabras y devuelve una lista con el largo de cada una. Usa Map 

largosDePalabras :: [String] -> [Int]
largosDePalabras = map length 

-- 7) Definí palabrasLargas, que recibe una lista de palabras y devuelve solo las que tienen más de 5 letras. Usa Filter 

palabrasLargas :: [String] -> [String]
palabrasLargas = filter ((>5) .length)
 
-- 8) Definí hayPalabraVacia, que recibe una lista de palabras y devuelve True si alguna palabra está vacía. Usa Any 

hayPalabrasVacia :: [String] -> Bool
hayPalabrasVacia = any ((==0).length)

-- 9) Definí todasLargas, que recibe una lista de palabras y devuelve True si todas tienen más de 3 letras. Usa all 

todasLargas :: [String] -> Bool 
todasLargas = all ((>3).length)

-- 10) Definí multiplicarTodos, que recibe una lista de números y devuelve el producto total.

multiplicarTodos :: [Int] -> Int 
multiplicarTodos = foldl (*) 1