-- Modelado

data Inversion = UnaInversion {
    cripto :: String,
    cantidad :: Float,
    precioPromedio :: Float,
    estaEnBilleteraFria :: Bool,
    estrategias :: [String]
} deriving Show

bitcoin :: Inversion 
bitcoin = UnaInversion {
    cripto = "Bitcoin",
    cantidad = 0.04,
    precioPromedio = 65000,
    estaEnBilleteraFria = True,
    estrategias = ["DCA", "Largo plazo"]
}

ethereum :: Inversion
ethereum = UnaInversion {
    cripto = "Ethereum",
    cantidad = 2.5,
    precioPromedio = 2200,
    estaEnBilleteraFria = False,
    estrategias = ["Staking"]
}

type Mejora = Inversion -> Inversion 

agregarEstrategia :: String -> Mejora
agregarEstrategia estrategia inversion 
    | cripto inversion == "Bitcoin" =  inversion {
            estrategias = estrategia : estrategias inversion, 
            estaEnBilleteraFria = True 
        }
    | otherwise = inversion 

planDeAcumulacion :: Mejora 
planDeAcumulacion inversion = inversion {
    cantidad = cantidad inversion *2, 
    estaEnBilleteraFria = True,
    estrategias = "Compra periodica" : estrategias inversion 
}

transferenciaSegura :: Inversion -> Mejora
transferenciaSegura inversionEntrega inversionRecibe 
    | cripto inversionEntrega == "Bitcoin" = 
        inversionRecibe {
            estaEnBilleteraFria = True, 
            estrategias = []
        }
    | otherwise = inversionRecibe {
        estaEnBilleteraFria = True
    }

aplicarSiEsBitcoin :: Mejora -> Mejora 
aplicarSiEsBitcoin mejoraParticular inversion 
    | esBitcoin inversion = mejoraParticular inversion
    | otherwise = inversion 


esBitcoin :: Inversion -> Bool 
esBitcoin = (== "Bitcoin") . cripto

misterio1 :: Inversion -> (Inversion -> a) ->  a 
misterio1 inversion condicion = 
    condicion inversion 

misterio2 :: Mejora -> Inversion -> Int  
misterio2 transformacion =
    length . estrategias . transformacion

misterio3 :: (Inversion -> a) -> Mejora -> Inversion -> a
misterio3 condicion transformacion inversion =
    condicion (transformacion inversion) 


-- Punto 5 Categorias 

type Categoria = Inversion -> Bool 

puedeSerRecomendada :: Categoria 
puedeSerRecomendada inversion = 
    estaEnBilleteraFria inversion
    ||  cantidad inversion > 1
    || esBitcoin inversion

inversionBitcoin :: Categoria
inversionBitcoin inversion =
    esBitcoin inversion && puedeSerRecomendada inversion

inversionDiversificada :: Categoria 
inversionDiversificada inversion = 
    tieneDosOMasEstrategias inversion 
    &&   estaEnBilleteraFria inversion
    &&  puedeSerRecomendada inversion



tieneDosOMasEstrategias :: Inversion -> Bool 
tieneDosOMasEstrategias inversion =
     length  (estrategias inversion) >= 2


inversionPrincipiante :: Categoria
inversionPrincipiante inversion =
    tieneMenosDosEstrategias inversion 
    && not (estaEnBilleteraFria inversion)
    && puedeSerRecomendada inversion 

tieneMenosDosEstrategias :: Inversion -> Bool 
tieneMenosDosEstrategias inversion = 
    length (estrategias inversion) < 2  

-- Punto 6 

type Cartera = [Inversion]

cantidadDeCategoria :: Categoria -> Cartera -> Int
cantidadDeCategoria categoria listaDeInversiones =
    length (filter categoria listaDeInversiones) 


carteraPoderosa :: Cartera -> [String]
carteraPoderosa inversiones =
    map cripto (filter ((> 1) . cantidad) inversiones)

inversionesEnResguardadasEnFrio :: Cartera -> Bool
inversionesEnResguardadasEnFrio = all estaEnBilleteraFria

buenasInversiones :: Cartera -> Bool
buenasInversiones = any tieneDosOMasEstrategias

-- Punto 7 

aplicarMejoras :: [Mejora] -> Inversion -> Inversion
aplicarMejoras mejoras inversion =
    foldl aplicarUnaMejora inversion mejoras

aplicarUnaMejora :: Inversion -> Mejora -> Inversion
aplicarUnaMejora inversion mejora =
    mejora inversion

cantidadTotalLuegoDeMejoras :: [Mejora] -> Cartera -> Float
cantidadTotalLuegoDeMejoras mejoras inversiones = 
    sum (map cantidad (map  (aplicarMejoras mejoras) inversiones))

