module Modulo2 where
import Utils




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