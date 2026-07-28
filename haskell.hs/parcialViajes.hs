-- Punto 1 Modelado

data Viaje = UnViaje {
    destino :: String,
    cantidadDeDias :: Int,
    presupuesto :: Int,
    incluyeAlojamiento :: Bool,
    actividades :: [String]
} deriving Show

-- Viaje a Bariloche

bariloche :: Viaje
bariloche = UnViaje {
    destino = "Bariloche",
    cantidadDeDias = 7,
    presupuesto = 1200000,
    incluyeAlojamiento = True,
    actividades = ["Cerro Catedral", "Circuito Chico"]
}

marDelPlata :: Viaje
marDelPlata = UnViaje {
    destino = "Mar Del Plata",
    cantidadDeDias = 5,
    presupuesto = 800000,
    incluyeAlojamiento = False,
    actividades = ["Playa", "Puerto"]
}

type Mejora = Viaje -> Viaje 

-- Punto 2 Mejoras sobre viajes 

agregarActividad :: String -> Mejora
agregarActividad actividad viaje
    | destino viaje == "Bariloche" =
        viaje {
            incluyeAlojamiento = True,
            actividades = actividad : actividades viaje
        }
    | otherwise = viaje

paqueteCompleto :: Mejora
paqueteCompleto viaje =
    viaje {
        incluyeAlojamiento = True,
        cantidadDeDias = cantidadDeDias viaje * 2,
        actividades = "Excursion guiada" : actividades viaje
    }

beneficioFamiliar :: Viaje -> Mejora
beneficioFamiliar viajeBeneficio viajeReceptor
    | destino viajeBeneficio == "Disney" =
        viajeReceptor {
            incluyeAlojamiento = True,
            actividades = []
        }
    | otherwise =
        viajeReceptor {
            incluyeAlojamiento = True
        }


type Categoria = Viaje -> Bool

puedeSerRecomendado :: Categoria 
puedeSerRecomendado viaje =
    incluyeAlojamiento viaje
    || presupuesto viaje < 1000000
    || destino viaje == "Bariloche"

aventuraPatagonica :: Categoria 
aventuraPatagonica viaje = 
    puedePertenecerSegun esUshuaia viaje

esUshuaia :: Viaje -> Bool 
esUshuaia viaje = destino viaje == "Ushuaia"

viajeCompleto :: Categoria 
viajeCompleto viaje = 
    puedePertenecerSegun condicionCompleto viaje 

condicionCompleto :: Viaje -> Bool 
condicionCompleto viaje =
    tieneAlMenosDosActividades viaje 
    && incluyeAlojamiento viaje 

tieneAlMenosDosActividades :: Viaje -> Bool 
tieneAlMenosDosActividades viaje =
     length (actividades viaje) >= 2

escapadaEconomica :: Categoria 
escapadaEconomica viaje = 
    puedePertenecerSegun condicionEconomico viaje 

condicionEconomico :: Viaje -> Bool 
condicionEconomico viaje =
    tieneMenosDeDosActividades viaje 
    && not(incluyeAlojamiento viaje) 

tieneMenosDeDosActividades :: Viaje -> Bool 
tieneMenosDeDosActividades viaje = 
    length (actividades viaje) < 2 


-- Punto 5 

puedePertenecerSegun :: Categoria -> Viaje -> Bool
puedePertenecerSegun condicionParticular viaje = 
    condicionParticular viaje 
    && puedeSerRecomendado viaje

-- Punto 6 
type Itinerario = [Viaje]


cantidadDeCategoria :: Categoria -> Itinerario -> Int
cantidadDeCategoria categoria itinerario =
    length (filter categoria itinerario)  

destinoEconomico :: Itinerario -> [String]
destinoEconomico itinerario = map destino (filter esEconomico itinerario)


esEconomico :: Viaje -> Bool 
esEconomico = (< 900000) . presupuesto

todosIncluyenAlojamiento :: Itinerario -> Bool 
todosIncluyenAlojamiento = all incluyeAlojamiento 

hayAlgunViajeCompleto :: Itinerario -> Bool 
hayAlgunViajeCompleto = any tieneAlMenosDosActividades

aplicarMejoras :: [Mejora] -> Viaje -> Viaje
aplicarMejoras mejoras viaje =
    foldl aplicarUnaMejora viaje mejoras

aplicarUnaMejora :: Viaje -> Mejora -> Viaje
aplicarUnaMejora viaje mejora =
    mejora viaje

presupuestoTotalLuegoDeMejoras :: [Mejora] -> Itinerario -> Int
presupuestoTotalLuegoDeMejoras mejoras itinerario =
    sum (map presupuesto (map (aplicarMejoras mejoras) itinerario))

-- presupuestoTotalLuegoDeMejoras :: [Mejora] -> Itinerario -> Int
-- presupuestoTotalLuegoDeMejoras mejoras =
--    sum . map (presupuesto . aplicarMejoras mejoras)