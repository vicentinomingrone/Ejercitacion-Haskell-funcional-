type Palabra = String
type Verso = String
type Estrofa = [Verso]
type Artista = String

esVocal :: Char -> Bool
esVocal = flip elem "aeiou"

tieneTilde :: Char -> Bool
tieneTilde = flip elem "áéíóú"

cumplen :: (a -> b) -> (b -> b -> Bool) -> a -> a -> Bool -- iii.
cumplen f comp v1 v2 = comp (f v1) (f v2)

-- 1.  i. si, porque a y b no sabes que parametros busca le podrias poner palabra1 palabra2 
-- ii. si, no dice que hace, solo dice como lo hace 
-- iv. rimaConstante 

rimaAsonante :: Palabra -> Palabra -> Bool 
rimaAsonante a b =
  cumplen (\x -> drop (length (filter esVocal x) - 2) (filter esVocal x)) (==) a b

rimaConsonante :: Palabra -> Palabra -> Bool
rimaConsonante palabra1 palabra2 =
  cumplen ultimasTresLetras (==) palabra1 palabra2

ultimasTresLetras :: Palabra -> String
ultimasTresLetras palabra =
  reverse (take 3 (reverse palabra))

-- b) 
riman :: Palabra -> Palabra -> Bool
riman palabra1 palabra2 =
  palabra1 /= palabra2 &&
  (rimaAsonante palabra1 palabra2 || rimaConsonante palabra1 palabra2)

{- c)
-- 1. Palabras distintas con rima asonante
-- Ejemplo: "parcial" y "estirar"
-- Debería dar True

-- 2. Palabras distintas con rima consonante
-- Ejemplo: "funcion" y "cancion"
-- Debería dar True

-- 3. Palabras distintas que no riman
-- Ejemplo: "casa" y "perro"
-- Debería dar False

-- 4. Palabras iguales
-- Ejemplo: "casa" y "casa"
-- Debería dar False, aunque técnicamente coincidan sus letras/vocales

-- 5. Palabras que cumplen rima asonante y consonante a la vez
-- Ejemplo: dos palabras distintas con misma terminación fuerte
-- Debería dar True
-}

-- 2)
type Conjugacion = Verso -> Verso -> Bool

primeraPalabra :: Verso -> Palabra
primeraPalabra verso =
  head (words verso)

ultimaPalabra :: Verso -> Palabra
ultimaPalabra verso =
  last (words verso)

conRima :: Conjugacion
conRima =
  cumplen ultimaPalabra riman

anadiplosis :: Conjugacion
anadiplosis verso1 verso2 =
  ultimaPalabra verso1 == primeraPalabra verso2