data Jugador = UnJugador {
    nombre :: String,
    posicion :: String, 
    cantidadDeGoles :: Int, 
    estaDisponible :: Bool, 
    habilidades :: [String]
} deriving Show

-- Modelo de Julian 

julian :: Jugador
julian = UnJugador {
    nombre = "Julian Alvarez",
    posicion = "Delantero",
    cantidadDeGoles = 3,
    estaDisponible = True,
    habilidades = ["Definicion", "Presion"]
}

-- Modelado de Dibu Emi Martinez 

dibu :: Jugador 
dibu = UnJugador {
    nombre = "Emiliano Martinez",
    posicion = "Arquero",
    cantidadDeGoles = 0,
    estaDisponible = True, 
    habilidades = ["Penales", "Reflejos"]
}

type Mejora = Jugador -> Jugador


agregarHabilidad :: String -> Mejora
agregarHabilidad habilidad jugador 
    | esJulian jugador = jugador {
        habilidades = habilidad : habilidades jugador, 
        estaDisponible = True
    } 
    | otherwise = jugador

esJulian :: Jugador -> Bool 
esJulian = (== "Julian Alvarez") . nombre

entrenamientoIntensivo :: Mejora
entrenamientoIntensivo jugador =
    jugador {
        cantidadDeGoles = cantidadDeGoles jugador * 2,
        estaDisponible = True,
        habilidades = "Resistencia" : habilidades jugador
    }

liderazgoDelCapitan :: Jugador -> Mejora
liderazgoDelCapitan jugadorLider jugadorAprendiz
    | esMessi jugadorLider =
        jugadorAprendiz {
            estaDisponible = True,
            habilidades = []
        }
    | otherwise =
        jugadorAprendiz {
            estaDisponible = True
        }

esMessi :: Jugador -> Bool
esMessi jugador =
    nombre jugador == "Lionel Messi"
    

-- Punto 3 Tuplas 

type Actuacion = (Jugador, Int)

jugadorDeLaActuacion :: Actuacion -> Jugador 
jugadorDeLaActuacion = fst 


minutosJugador :: Actuacion -> Int
minutosJugador = snd 

resumenActuacion :: Actuacion -> (String, Int, Bool)
resumenActuacion (jugador, minutos) =
    (nombre jugador, minutos, minutos >= 60)



-- Punto 4 

type Actuaciones = [Actuacion]

minutosTotales :: Actuaciones -> Int 
minutosTotales [] = 0 
minutosTotales (actuacion : restoDeActuaciones) =
    minutosJugador actuacion + minutosTotales restoDeActuaciones 

cantidadDeTitulares :: Actuaciones -> Int 
cantidadDeTitulares [] = 0 

cantidadDeTitulares (actuacion : restoDeActuaciones) 
    | fueTitular actuacion =
         1 + cantidadDeTitulares restoDeActuaciones 
    | otherwise = cantidadDeTitulares restoDeActuaciones 

fueTitular :: Actuacion -> Bool
fueTitular =
    (>= 60) . snd



