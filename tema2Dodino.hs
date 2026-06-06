import Main (Jugador(partidos), Tecnico)
type Velocidad = Float
type Habilidad = Int

data Jugador = UnJugador {
    nombre :: String,
    velocidad :: Velocidad,
    habilidad :: Habilidad, 
    puesto :: String,
    partidos :: [Partido]
}

data Partido = UnPartido {
    minutosJugados :: Float,
    golesConvertidos :: Int
}

-- Equipos primer Punto: 

goleadoresDelEquipo :: [Jugador] -> Int 
goleadoresDelEquipo = length . filter . (all ((>0) . golesConvertidos) . partidos)


todosLosHabilidososSonVolantes :: Number -> [Jugador] -> Bool
todosLosHabilidososSonVolantes minimo =
  all ((== "volante") . puesto) . filter ((> minimo) . habilidad)

-- 2 

gago :: Tecnico
gago jugador
  | puesto jugador == "volante" = jugador { puesto = "defensor" }
  | puesto jugador == "delantero" = jugador { puesto = "volante" }
  | otherwise = jugador


partidoAmistoso :: Partido
partidoAmistoso = UnPartido {
  minutosJugados = 90,
  golesConvertidos = 0
}

bilardo :: Bool -> Tecnico
bilardo estaNervioso jugador
  | estaNervioso = jugador {
      partidos = partidos jugador ++ [partidoAmistoso],
      habilidad = habilidad jugador + 5
    }
  | otherwise = jugador {
      partidos = partidos jugador ++ [partidoAmistoso],
      habilidad = habilidad jugador + 10
    }


fatigatti :: Tecnico
fatigatti = bilardo False


klopp :: Tecnico
klopp = id

partidoGanado :: Partido 
partidoGanado = UnPartido {
    minutosJugados = 90, 
    golesConvertidos = 1
}

medioPartido :: Partido 
medioPartido = UnPartido {
    minutosJugados = 45,
    golesConvertidos = 0
}

scaloni :: Bool -> Tecnico
scaloni confiado jugador 
  | True = jugador {
    partidos = partidos jugador ++ [partidoGanado],
    habilidad = habilidad jugador + 12 
  }
  | otherwise = jugador {
    partidos = partido jugador ++ [medioPartido],
    habilidad = habilidad jugador + 6
  }