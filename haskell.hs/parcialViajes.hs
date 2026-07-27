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
   | destino viaje == "Bariloche" = actividad : actividades 
   && incluyeAlojamiento viaje
   | otherwise = viaje 

paqueteCompleto :: Mejora 
paqueteCompleto viaje = 
    incluyeAlojamiento viaje 
    && cantidadDeDias viaje (*2)
    && "Excursion guiada" :: actividades


