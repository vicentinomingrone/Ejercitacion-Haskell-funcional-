module Modulo3 where
import Utils



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