import Main (sonIguales)
type Marca = String
type Modelo = String
type Piloto = String
type Maniobra = String
type Secuencia = [Maniobra]
type Potencia = Float
type Control = Float
type PublicoExaltado = Bool




cumplen :: (a -> b) -> (b -> b -> Bool) -> a -> a -> Bool
cumplen transformacion comparacion valor1 valor2 =
  comparacion (transformacion valor1) (transformacion valor2)


-- Parte 1 — Comparaciones de maniobras

ultimasLetras :: Int -> Maniobra -> String
ultimasLetras n = reverse . take n . reverse 


-- 2. Maniobras similares por final

mismoFinal :: Maniobra -> Maniobra -> Bool
mismoFinal = cumplen (ultimasLetras 3) (==) 

-- 3) 

combinan :: Maniobra -> Maniobra -> Bool
combinan maniobra1 maniobra2 = maniobra1 /= maniobra2 && mismoFinal maniobra1 maniobra2


-- Parte 2 — Conexiones entre maniobras

type Conexion = Maniobra -> Maniobra -> Bool

-- Conexion por final 

porFinal :: Conexion 
porFinal = combinan 

-- 5. Conexión por encadenamiento

primeraPalabra :: Maniobra -> String
primeraPalabra = head . words 
ultimaPalabra :: Maniobra -> String
ultimaPalabra = last . words 
porEncadenamiento :: Conexion
porEncadenamiento = cumplen (primeraPalabra . ultimaPalabra) (==)


-- Parte 3 — Patrones de secuencias

-- 6. Patrón simple, Una secuencia cumple un patrón simple si dos maniobras, según sus posiciones, combinan

type Patron = Secuencia -> Bool
type Par = (Int, Int)

maniobraEn :: Int -> Secuencia -> Maniobra
maniobraEn posicion secuencia =
  secuencia !! (posicion - 1)

simple :: Par -> Patron
simple (posicion1, posicion2) secuencia =
  combinan (maniobraEn posicion1 secuencia) (maniobraEn posicion2 secuencia)


-- 7. Anáfora de maniobras


sonIguales :: [String] -> Bool 
sonIguales [] = False 
sonIguales (palabra:palabras) = 
    all (== palabra) palabras

anafora :: Patron
anafora = 
    sonIguales . map primeraPalabra


