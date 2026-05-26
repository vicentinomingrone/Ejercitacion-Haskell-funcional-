import Foreign.C (eDEADLK)
import GHC.RTS.Flags (RTSFlags(parFlags))
noMeImportaElPrimero :: (Num a, Num b) => a -> b -> b
noMeImportaElPrimero numero1 numero2 = numero2 

data Alumno = Alumno {
    nombre :: String,
    nota :: Int
}

esMenorAOcho :: Int -> Bool
esMenorAOcho nota = nota < 8
promociona :: Alumno -> Bool
promociona alumno = not (esMenorAOcho (nota alumno))

preomociona :: Alumno -> Bool
preomociona  = not . esMenorAOcho . nota 


-- 1) Definí la función esMayorA10, que recibe un número y devuelve True si es mayor a 10.

{- 
esMayorA10 :: (Num a, Ord a) => a -> Bool 
esMayorA10 num1 
 | num1 > 10 = True 
 | otherwise = False  
-}

esMayorA10 :: (Num a, Ord a) => a -> Bool 
esMayorA10 num1 = num1 > 10 

-- 2) Definí la función puedeVotar, que recibe una edad y devuelve True si la persona tiene 16 años o más.

puedeVotar :: Int -> Bool 
puedeVotar edad = edad >=  16 

-- 3) Definí la función estadoNota, que recibe una nota y devuelve:

estadoNota :: Float -> String 
estadoNota nota
 | nota < 6 = "Desaprobado"
 | nota >= 6 && nota <= 9 = "Aprobado"
 | otherwise = "Excelente" 

 {-
estadoNota :: Float -> String 
estadoNota nota
 | nota < 6 = "Desaprobado"
 | nota < 10 = "Aprobado"
 | otherwise = "Excelente" 
 -}

 -- 4) Decí cuál sería el tipo de esta función: dobleEdad edad = edad * 2

dobleEdad :: Int -> Int 
dobleEdad edad = edad * 2 

-- 5) Decí si esta función está bien o es redundante, y explicá por qué: 
{-
esRojo color
  | color == "rojo" = True
  | otherwise = False

Esta bien, ya que solo con Rojo va a Dar True
-}

-- 6) Definí la función esPositivo, que recibe un número y devuelve True si es mayor a 0.

esPositivo :: (Num a, Ord a) => a -> Bool 
esPositivo num = num > 0 

-- 7) Definí la función precioEntrada, que recibe una edad y devuelve:

precioEntrada :: Int -> String 
precioEntrada edad 
 | edad < 6 = "gratis"
 | edad <= 17 = "menor"
 | otherwise = "adulto"


-- 8) Definí la función puedeJubilarse, que recibe una edad y devuelve True si es mayor o igual a 65. Sin Guardass 

puedeJubilarse ::  Int -> Bool 
puedeJubilarse edad = edad >= 65 

-- 9) Decí cuál sería el tipo de esta función: saludar nombre = "Hola " ++ nombre

saludar :: String -> String 
saludar nombre = "Hola " ++ nombre

-- 10) Decí si esta función es correcta o redundante, y cómo la mejorarías: esDesaprobado nota  | nota < 6 = True | otherwise = False

{-
esDesaprobado nota
  | nota < 6 = True
  | otherwise = False

redundante ya con que tenga esto funciona: 
esDesaprobado :: (Num a, Ord a) => a -> Bool 
esDesaprobado nota = nota < 6  
-}

esDesaprobado :: (Num a, Ord a) => a -> Bool 
esDesaprobado nota = nota < 6  

-- MODULO 2 

-- 1) Definí longitudPar, que recibe un String y devuelve si su longitud es par.

longitudPar :: String -> Bool  
longitudPar = even . length  

-- 2) Definí esMenorA20, que recibe un número y devuelve si es menor a 20. Usa aplicacion Parcial. 

esMenorA20 :: Int -> Bool
esMenorA20 = (< 20) 

-- 3) Definí esNombreLargo, que recibe un String y devuelve True si tiene más de 8 caracteres. Usar Composicion y Aplicacion Parcial

esNombreLargo :: String -> Bool
esNombreLargo = (>8) . length 

-- 4) Definí edadPersona, que recibe una tupla (String, Int) y devuelve la edad. USA SND 

edadPersona :: (String, Int) -> Int 
edadPersona = snd 

-- 5) Definí esMayorDeEdad, que recibe una tupla (String, Int) y devuelve si la persona tiene 18 años o más. Usa Composicion y Aplicacion Parcial 

esMayorDeEdad :: (String, Int) -> Bool 
esMayorDeEdad = (>= 18) . snd 

-- 6) Definí terminaConA, que recibe un String y devuelve True si la última letra es 'a'. Usá composición y aplicación parcial.

terminaConA :: String -> Bool 
terminaConA =  (== 'a') . last

-- 7) Definí dobleDelLargo, que recibe un String y devuelve el doble de su longitud. Usa Composicion

dobleDelLargo :: String -> Int 
dobleDelLargo = (*2) . length 

-- 8) Definí esVacio, que recibe una lista y devuelve True si está vacía. Usá composición y aplicación parcial con length.

esVacio :: [a] -> Bool 
esVacio = (== 0) . length 

-- 9) Definí esNoVacio, que recibe una lista y devuelve True si no está vacía. Usá composición y aplicación parcial con length.


esNoVacio :: [a] -> Bool
esNoVacio = (/= 0) . length


{-
tAMBIEN SE PODRIA HACER 

esNoVacio :: [a] -> Bool 
esNoVacio = not . esVacio 

-}


-- 10) Definí inicialEsJ, que recibe un String y devuelve True si empieza con la letra 'J'. Usá composición y aplicación parcial.

inicialEsJ :: String -> Bool 
inicialEsJ = (== 'J') . head

-- 11) Definí la función nombrePersona, que recibe una tupla con nombre y edad, y devuelve el nombre. Usar FST

nombrePersona :: (String, Int) -> String 
nombrePersona = fst


-- Modulo 3

-- 1) Definí primerElemento, que recibe una lista y devuelve su primer elemento. USA PATTERN MACHINE

primerElemento :: [a] -> a 
primerElemento (x:_) = x 

-- 2) Definí esListaVacia, que recibe una lista y devuelve True si está vacía y False si tiene elementos. Usa pattern MAchine 

esListaVacia :: [a] -> Bool
esListaVacia [] = True 
esListaVacia (_:_) = False 

-- 3)  Definí sumaPar, que recibe una tupla de dos números y devuelve la suma. Usá pattern matching de tuplas.

sumaPar :: Num a => (a, a) -> a
sumaPar (num1,num2) = num1 + num2 


-- 4) Definí nombreDePersona, que recibe una tupla (String, Int) y devuelve el nombre.

nombreDePersona :: (String, Int) -> String
nombreDePersona (nombre, _) = nombre 

-- 5) Creá un tipo Persona con record syntax que tenga: nombre :: String y Edad: Int 

data Persona = UnaPersona{
    nombre2 :: String,
    edad2 :: Int
} deriving Show

ana :: Persona 
ana = UnaPersona {
    nombre2 = "Ana",
    edad2 = 22
}

-- 6) Definí segundoElemento, que recibe una lista y devuelve su segundo elemento. Usá pattern matching.

segundoElemento :: [a] -> a
segundoElemento (_:x:_) = x

-- 7) Definí tieneUnElemento, que recibe una lista y devuelve True si tiene exactamente un elemento. USA PM 

tieneUnElemnento :: [a] -> Bool
tieneUnElemnento [a] = True 
tieneUnElemnento [] = False 
tieneUnElemnento (_:_) = False  

-- 8) Definí edadDePersona, que recibe una tupla (String, Int) y devuelve la edad. USA PM no SND

edadPersona2 :: (String, Int) -> Int 
edadPersona2 (_, x)= x

-- 9) Definí esMayorPersona, que recibe una tupla (String, Int) y devuelve True si la edad es mayor o igual a 18. USA PM

esMayorPersona :: (String, Int) -> Bool 
esMayorPersona (_, edad) = edad >= 18

-- 10) Creá un tipo Producto con record syntax que tenga: nombreProducto :: String | precioProducto :: Float | stockProducto :: Int

data Producto = UnProducto {
    nombreProducto :: String, 
    precioProducto :: Float, 
    stockProducto :: Int
}

remera :: Producto 
remera = UnProducto {
    nombreProducto = "Remera Oversize",
    precioProducto = 15000,
    stockProducto = 20
}

-- MODULO 4

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



-- MODULO 5 

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

-- MODULO 6 

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