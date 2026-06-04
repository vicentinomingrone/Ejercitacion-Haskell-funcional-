
type Palabra = String
type Verso = String
type Estrofa = [Verso]
type Artista = String

esVocal :: Char -> Bool
esVocal = flip elem "aeiou"

tieneTilde :: Char -> Bool
tieneTilde = flip elem "áéíóú"

cumplen :: (a -> b) -> (b -> b -> Bool) -> a -> a -> Bool
cumplen f comp v1 v2 = comp (f v1) (f v2)

rimaAsonante :: Palabra -> Palabra -> Bool
rimaAsonante a b =
  cumplen (\x -> drop (length (filter esVocal x) - 2) (filter esVocal x)) (==) a b


-- 1) 

rimaConsonante :: Palabra -> Palabra -> Bool 
rimaConsonante = cumplen (ultimasTresLetras 3) (==)

ultimasTresLetras :: Int -> Palabra -> Palabra
ultimasTresLetras n = reverse . take n . reverse

-- b)

puedenRimar :: Palabra -> Palabra -> Bool 
puedenRimar palabra1 palabra2 = 
    palabra1 /= palabra2 && (rimaAsonante palabra1 palabra2 || rimaConsonante palabra1 palabra2) 


-- c) 
 {-
cuando dos palabras son distintas y sus ultimas vocales son iguales, entonces da True 
cuando dos palabras son distintas y sus ultimas tres letras coinciden, entonces da True
cuando dos palabras son distintas y sus ultimas tres letras no coinciden, => da False 
cuando dos palabras son distintas y sus ultimas vocales son distintas, => da False 
cuando dos palabras son iguales, => da False 
 -}

-- 2) 
type Conjugacion = Verso -> Verso -> Bool

porMedioRima :: Conjugacion
porMedioRima = cumplen ultimaPalabra puedenRimar

ultimaPalabra :: Verso -> Palabra
ultimaPalabra = last . words 

porMedioAnadiplosis :: Conjugacion
porMedioAnadiplosis verso1 verso2 =
  ultimaPalabra verso1 == primeraPalabra verso2

primeraPalabra :: Verso -> Palabra
primeraPalabra = head . words

-- 3) 

-- simple :: Verso -> Verso -> Verso -> Verso -> Bool
-- simple = porMedioRima (1,4)