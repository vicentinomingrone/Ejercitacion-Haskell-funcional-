type Ticker = String
type Empresa = String
type Sector = String
type Precio = Float
type Variacion = Float -- porcentaje diario
type DividendYield = Float -- porcentaje anual
type Volumen = Int
type Anio = Int

data Accion = UnaAccion {
  tickerAccion :: Ticker,
  empresaAccion :: Empresa,
  sectorAccion :: Sector,
  precioAccion :: Precio,
  variacionDiaria :: Variacion,
  dividendYield :: DividendYield,
  volumenOperado :: Volumen,
  anioSalidaBolsa :: Anio
} deriving Show

cumplen :: (a -> b) -> (b -> b -> Bool) -> a -> a -> Bool
cumplen transformacion comparacion valor1 valor2 =
  comparacion (transformacion valor1) (transformacion valor2)


esCara :: Accion -> Bool
esCara = (> 100) . precioAccion

esJoven :: Accion -> Bool
esJoven = (>= 2015) . anioSalidaBolsa

empresaConNombreLargo :: Accion -> Bool
empresaConNombreLargo = (> 12) . length . empresaAccion

muchoVolumen :: Accion -> Bool
muchoVolumen = (> 1000000) . volumenOperado

variacionDiariaPositiva :: Accion -> Bool 
variacionDiariaPositiva = (> 0) . variacionDiaria 

dividendYieldDestacado :: Accion -> Bool
dividendYieldDestacado = (> 2) . dividendYield

accionDestacada :: Accion -> Bool
accionDestacada accion =
  muchoVolumen accion && variacionDiariaPositiva accion && dividendYieldDestacado accion

fichaAccion :: Accion -> String
fichaAccion accion =
  tickerAccion accion ++ " - " ++
  empresaAccion accion ++ " - " ++
  sectorAccion accion ++ " - USD " ++
  show (precioAccion accion)


-- Parte 2 — Guardas y clasificación 

-- 7. Categoría por precio

categoriaPrecio :: Accion -> String
categoriaPrecio accion 
    | precioAccion accion < 20 = "barata"
    | precioAccion accion < 100 = "media"
    | otherwise = "cara"

-- 8. Categoría por variación diaria

categoriaVariacion :: Accion -> String
categoriaVariacion accion 
    | variacionDiaria accion <(-2) = "baja fuerte"
    | variacionDiaria accion  < 0 = "baja leve"
    | variacionDiaria accion  == 0 = "sin cambios"
    | otherwise = "sube"

-- Parte 3 — Listas, pattern matching y recursividad
-- 9. Primera acción
-- Devuelve la primera acción de una lista usando pattern matching.

primeraAccion :: [Accion] -> Accion
primeraAccion (accion:_) = accion

-- 10. Cantidad de acciones, Debe contar cuántas acciones hay usando recursividad, sin usar length.

cantidadDeAcciones :: [Accion] -> Int
cantidadDeAcciones [] = 0
cantidadDeAcciones (_:xs) = 1 + cantidadDeAcciones xs

-- 11. Existe ticker, Debe decir si existe una acción con ese ticker en la lista.
-- Condición: usar recursividad, sin usar elem, any ni filter.

existeTicker :: Ticker -> [Accion] -> Bool
existeTicker _ [] = False
existeTicker ticker (accion:acciones) =
  tickerAccion accion == ticker || existeTicker ticker acciones

-- 12 

tickersDeCartera :: [Accion] -> [Ticker]
tickersDeCartera = map tickerAccion

-- Parte 4 
-- 13. Acciones caras
accionesCaras :: [Accion] -> [Accion]
accionesCaras = filter esCara

-- 14. Hay acción destacada
hayAccionDestacada :: [Accion] -> Bool
hayAccionDestacada = any accionDestacada

-- 15. Todas tienen mucho volumen 

todasConMuchoVolumen :: [Accion] -> Bool
todasConMuchoVolumen = all muchoVolumen

-- 16. Valor total de precios

precioTotalAcciones :: [Accion] -> Precio
precioTotalAcciones = foldl (\acum accion -> acum + precioAccion accion) 0 

-- Parte 5 — Lambdas y tuplas
-- 17. Tickers y precios

tickersYPrecios :: [Accion] -> [(Ticker, Precio)]
tickersYPrecios = map (\accion -> (tickerAccion accion, precioAccion accion))

-- 18. Acciones con dividendos altos, Devuelve acciones con dividend yield mayor a 3.

accionesConDividendosAltos :: [Accion] -> [Accion]
accionesConDividendosAltos = filter (\accion -> dividendYield accion >3)

-- 19. Precios con suba del 10%
--  Devuelve una lista con el precio de cada acción aumentado en un 10%. Condición: usar map con lambda.

preciosConSubaDel10 :: [Accion] -> [Precio]
preciosConSubaDel10 = map (\accion -> precioAccion accion * 1.1)

-- Parte 6 — Funciones genéricas y composición
-- 20. Misma característica






