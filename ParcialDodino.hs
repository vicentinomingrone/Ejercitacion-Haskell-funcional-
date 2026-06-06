import Data.Binary.Builder (putInthost)
import Graphics.Win32 (restoreDC)
type Nombre = String
type Velocidad = Float
type Habilidad = Float
type Puesto = String



data Jugador = UnJugador {
    nombre :: Nombre,
    velocidad :: Velocidad, 
    habilidad :: Habilidad,
    puesto :: Puesto,
    partidos :: [Partido]
}

data Partido = UnPartido {
    minutosJugados :: Int,
    golesConvertidos :: Int
}

-- Punto 1 

jugaronAlmenos :: Int -> [Jugador] -> [String]
jugaronAlmenos minutos = 
    map nombre . filter (all ((>= minutos) .  minutosJugados) . partidos)

hayJugadorQueEmpiezaCon :: Char -> [Jugador] -> Bool
hayJugadorQueEmpiezaCon letra =
  any ((== letra) . head . nombre)

-- Punto 2

type Tecnico = Jugador -> Jugador
bielsa:: Tecnico
bielsa jugador = jugador {
        velocidad = velocidad jugador  * 1.5, 
        habilidad = habilidad jugador  - 10
    }

menotti :: Float -> Tecnico 
menotti puntos jugador = jugador {
    nombre = "Mr. " ++ nombre jugador,
    habilidad = habilidad jugador + puntos
}

bertolotti :: Tecnico
bertolotti = menotti 10 

vanGaal :: Tecnico 
vanGaal = id 

-- (vanGaal . menotti 15 . bielsa) jugador

-- Punto 3

jugadorBueno :: Jugador -> Bool
jugadorBueno jugador =
  habilidad jugador > velocidad jugador || puesto jugador == "volante"

cantidadJugadoresBuenos :: [Jugador] -> Int 
cantidadJugadoresBuenos = length . filter jugadorBueno

mejorEquipo :: Tecnico -> [Jugador] -> Bool 
mejorEquipo tecnico equipo = 
    cantidadJugadoresBuenos (map tecnico equipo) > cantidadJugadoresBuenos equipo 

-- Con recursividad punto 4 


jugadorImparable :: Jugador -> Bool
jugadorImparable jugador =
  golesNoBajan (map golesConvertidos (partidos jugador))

golesNoBajan :: [Int] -> Bool
golesNoBajan [] = True 
golesNoBajan [_] = True
golesNoBajan (gol1:gol2:resto) =
    gol1 <= gol2 && golesNoBajan (gol2:resto)




