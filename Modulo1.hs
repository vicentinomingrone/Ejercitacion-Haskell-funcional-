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