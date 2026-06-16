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
rimaConsonante = cumplen (ultimasLetras 3) (==)

ultimasLetras :: Int -> Palabra -> Palabra
ultimasLetras n = reverse . take n . reverse

-- b)

puedenRimar :: Palabra -> Palabra -> Bool 
puedenRimar palabra1 palabra2 =
  palabra1 /= palabra2 &&
  (rimaAsonante palabra1 palabra2 || rimaConsonante palabra1 palabra2)


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
type Par = (Int, Int)
type Patron = Estrofa -> Bool 

versoAt :: Int -> Estrofa -> Verso
versoAt posicion estrofa =
  estrofa !! (posicion - 1)

simple :: Par -> Patron
simple (posicion1, posicion2) estrofa =
  porMedioRima (versoAt posicion1 estrofa) (versoAt posicion2 estrofa)

-- Esdrujula 

esVocalOTilde :: Char -> Bool
esVocalOTilde letra = 
  esVocal letra || tieneTilde letra

ultimasVocales :: Int -> Palabra -> String
ultimasVocales n =
  ultimasLetras n . filter esVocalOTilde

esEsdrujula :: Palabra -> Bool
esEsdrujula = 
  tieneTilde . head . ultimasVocales 3

esdrujulas :: Patron
esdrujulas =
  all (esEsdrujula . ultimaPalabra)


-- Anafora


esAnafora :: Estrofa -> Bool 
esAnafora = 
  sonIguales . map primeraPalabra

sonIguales :: [Palabra] -> Bool 
sonIguales [] = False 
sonIguales (palabra:palabras) = 
  all (== palabra) palabras

-- Cadena 

cadena :: Conjugacion -> Patron
cadena _ [] = False
cadena _ [_] = True
cadena conjugacion (verso1:verso2:versos) =
  conjugacion verso1 verso2 && cadena conjugacion (verso2:versos)


-- comnbinarDos 

combinarDos :: Patron -> Patron -> Patron 
combinarDos patron1 patron2 estrofa = 
  patron1 estrofa && patron2 estrofa

aabb :: Patron
aabb = combinarDos (simple (1,2)) (simple (3,4))

abab :: Patron 
abab = combinarDos (simple (1,3)) (simple (2,4))

abba :: Patron 
abba = combinarDos (simple (1,4)) (simple (2,3))

hardcore :: Patron 
hardcore = combinarDos (cadena porMedioRima) (esdrujulas)


-- 

data PuestaEnEscena = UnaPuestaEnEscena {
  artista :: Artista,
  freestyle :: Estrofa,
  potencia :: Float, 
  publicoExaltado :: Bool
}

puestaBase :: Artista -> Estrofa -> PuestaEnEscena
puestaBase artista estrofa =
  UnaPuestaEnEscena {
    artista = artista,
    freestyle = estrofa,
    potencia = 1,
    publicoExaltado = False
  }


aumentarPotencia :: Float -> PuestaEnEscena -> PuestaEnEscena 
aumentarPotencia factor puesta = 
  puesta { potencia = potencia puesta * (1 + factor)}


exaltarPublico :: Bool -> PuestaEnEscena -> PuestaEnEscena
exaltarPublico exaltado puesta = puesta {publicoExaltado = exaltado}
 
exaltarPublicoSiCumple :: Patron -> PuestaEnEscena -> PuestaEnEscena
exaltarPublicoSiCumple patron puesta =
 exaltarPublico (cumplePatron puesta patron) puesta
 
cumplePatron :: PuestaEnEscena -> Patron -> Bool
cumplePatron puesta patron = patron (freestyle puesta)
 
type Estilo = PuestaEnEscena -> PuestaEnEscena
 
gritar :: Estilo
gritar = aumentarPotencia 0.5
 
respuesta :: Bool -> Estilo
respuesta efectiva = exaltarPublico efectiva . aumentarPotencia 0.2
 
tirarSkills :: Patron -> Estilo
tirarSkills patron = exaltarPublicoSiCumple patron . aumentarPotencia 0.1