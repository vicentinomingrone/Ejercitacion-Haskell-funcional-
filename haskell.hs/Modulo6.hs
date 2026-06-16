module Modulo6 where
import Utils

-- 1) Definí doblesLambda, que recibe una lista de números y devuelve todos duplicados. usa Map con lamda 

doblesLambda :: [Int] -> [Int]
doblesLambda lista = map (\x -> x*2) lista 


-- 2) Definí mayoresA10Lambda, que recibe una lista de números y devuelve solo los mayores a 10. Usa Filter 

mayoresA10Lambda :: [Int] -> [Int]
mayoresA10Lambda = filter (\x-> x>10) 


-- 3) Definí sumasDePares, que recibe una lista de tuplas de dos números y devuelve una lista con la suma de cada tupla. Usa map

sumasDePares :: [(Int, Int)] -> [Int]
sumasDePares = map (\(a,b) -> a + b)


-- 4) Definí palabrasConMasDe5, que recibe una lista de palabras y devuelve las que tienen más de 5 letras. Usa filter 

palabrasConMasDe5 :: [String] -> [String]
palabrasConMasDe5 = filter ((\x -> x>5). length) 

-- 5) Definí sumarConLambda, que recibe una lista de números y devuelve la suma total. Usa Foldl  

sumarConLambda :: [Int] -> Int
sumarConLambda = foldl (\acum x -> acum + x) 0 

-- 6) Definí triplesLambda, que recibe una lista de números y devuelve todos triplicados.

triplesLambda :: [Int] -> [Int]
triplesLambda = map (\x -> x*3)

-- 7) Definí paresLambda, que recibe una lista de números y devuelve solo los pares. Usá filter con lambda.

paresLambda :: [Int] -> [Int]
paresLambda = filter (\x -> even x) 

 
-- 8) Definí nombresDePersonas, que recibe una lista de tuplas (String, Int) y devuelve una lista con solo los nombres. Usá map con lambda.

nombresDePersonas :: [(String, Int)] -> [String]
nombresDePersonas = map (\x -> fst x) 

-- 9) Definí mayoresDeEdadLambda, que recibe una lista de tuplas (String, Int) y devuelve solo las personas que tienen 18 años o más. Usá filter con lambda.

mayoresDeEdadLambda ::  [(String, Int)] -> [(String, Int)]
mayoresDeEdadLambda = filter (\x -> snd x >= 18)

-- 10) Definí productoConLambda, que recibe una lista de números y devuelve el producto total. Usa fold con lambda.

productConLambda :: [Int] -> Int
productConLambda = foldl (\acum x -> acum * x) 1