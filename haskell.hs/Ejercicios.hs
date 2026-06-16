import Foreign.C (eDEADLK)
import GHC.RTS.Flags (RTSFlags(parFlags))
import System.Win32 (xBUTTON1)
noMeImportaElPrimero :: (Num a, Num b) => a -> b -> b
noMeImportaElPrimero numero1 numero2 = numero2 

-- Parctica Parcialera 

type Marca = String
type Modelo = String
type Anio = Int
type Kilometraje = Int
type Precio = Float
type Patente = String
type Descripcion = String

data Auto = UnAuto {
  marcaAuto :: Marca,
  modeloAuto :: Modelo,
  anioAuto :: Anio,
  kilometrajeAuto :: Kilometraje,
  precioAuto :: Precio,
  patenteAuto :: Patente,
  descripcionAuto :: Descripcion
} deriving Show

cumplen :: (a -> b) -> (b -> b -> Bool) -> a -> a -> Bool
cumplen transformacion comparacion valor1 valor2 =
  comparacion (transformacion valor1) (transformacion valor2)


-- es un nuevo auto si tiene menos de 1000 km 
esNuevo :: Auto -> Bool
esNuevo = (< 1000).kilometrajeAuto

-- es auto caro si su precio es mayor de 30.000 

esCaro :: Auto -> Bool 
esCaro = (>30000).precioAuto

-- Un auto tiene modelo largo si el nombre del modelo tiene más de 8 caracteres.

modeloLargo :: Auto -> Bool
modeloLargo = (>8).length.modeloAuto

-- un auto es destacado si es nuvo y es caro

autoDestacado :: Auto -> Bool
autoDestacado auto = esCaro auto && esNuevo auto

-- 5) publicacion :: Auto -> String 

publicacion :: Auto -> String 
publicacion auto = marcaAuto auto ++ " - " ++  modeloAuto auto ++ " - " ++ show(anioAuto auto) ++ "- usd" ++ show(precioAuto auto)


-- Parte 2 parcial

-- 6) Estado según kilometraje. si tiene menos de 1000 km: "nuevo"  | si tiene menos de 80000 km: "usado bueno" | si tiene 80000 km o más: "muy usado". Condicion Usar Guardas 

estadoPorKm :: Auto -> String
estadoPorKm auto 
 | kilometrajeAuto auto < 1000 = "nuevo"
 | kilometrajeAuto auto < 80000 = "usado bueno"
 | otherwise = "muy usado"


-- 7) categoria por año. 

categoriaPorAnio :: Auto -> String
categoriaPorAnio auto 
 | anioAuto auto >= 2023 = "actual"
 | anioAuto auto >= 2015 = "moderno"
 | otherwise = "viejo"

-- parte 3 Listas, pattern matching y recursividad

-- 8) use _ porque lo pide. Pide PatternMachine 

primerAuto :: [Auto] -> Auto
primerAuto (x:_) = x

-- 9) Debe contar cuántos autos hay usando recursividad, sin usar length.

cantidadDeAutos :: [Auto] -> Int
cantidadDeAutos [] = 0
cantidadDeAutos (_:xs) = 1 + cantidadDeAutos xs 


-- 10) Debe decir si existe un auto con esa patente en la lista. Condición: usar recursividad, sin usar any ni filter. 
existePatente :: Patente -> [Auto] -> Bool
existePatente _ [] = False
existePatente patente (auto:autos) = 
    patenteAuto auto == patente || existePatente patente autos 

-- 11) devuelve patente de cada auto 

patentesDeAutos :: [Auto] -> [Patente]
patentesDeAutos = map patenteAuto

-- Parte 4 

-- 12) Autos Nuevos: Devuelve solo los autos nuevos.

autosNuevos :: [Auto] -> [Auto]
autosNuevos  = filter esNuevo 

-- 13) hay auto caro 

hayAutoCaro :: [Auto] -> Bool
hayAutoCaro = any esCaro

-- 14) Todos son modernos. Devuelve True si todos los autos son del año 2015 o posterior.

todosSonModernos :: [Auto] -> Bool
todosSonModernos = all sonModernos

sonModernos :: Auto -> Bool 
sonModernos auto = anioAuto auto >= 2015 

-- 15) Precio Total Devuelve la suma de los precios de todos los autos. Condición: usar foldl con lambda.

precioTotal :: [Auto] -> Precio
precioTotal = foldl (\acc auto -> acc + precioAuto auto) 0

-- Parte 5 
-- 16) Devuelve una lista de tuplas con la marca y el modelo de cada auto. Condición: usar map con lambda.

marcasYModelos :: [Auto] -> [(Marca, Modelo)]
marcasYModelos = map (\auto -> (marcaAuto auto, modeloAuto auto))

-- 17) Autos con precio alto. Devuelve autos con precio mayor a 40000. Condición: usar filter con lambda.

autosConPrecioAlto :: [Auto] -> [Auto]
autosConPrecioAlto = filter (\auto -> precioAuto auto > 40000)

-- 18)  Devuelve una lista con el precio de cada auto aplicándole un 10% de descuento. Usar Map con lambda

preciosConDescuento :: [Auto] -> [Precio]
preciosConDescuento = map (\auto -> precioAuto auto * 0.9)


-- Parte 6

-- 19) Comparar autos según una característica . Debe decir si dos autos tienen igual una característica dada.

mismoSegun :: Eq b => (Auto -> b) -> Auto -> Auto -> Bool
mismoSegun caracteristicas auto1 auto2 = 
      caracteristicas auto1 == caracteristicas auto2 