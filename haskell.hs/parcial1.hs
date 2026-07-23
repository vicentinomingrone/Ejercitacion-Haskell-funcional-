-- punto 1 
data Entrenador = UnEntrenador {
    nombre :: String,
    medallas :: Bool,
    experiencia :: Int,
    frasesMotivadoras :: [String]
} deriving Show

ash :: Entrenador 
ash = UnEntrenador {
    nombre = "Ash",
    medallas = True,
    experiencia = 800, 
    frasesMotivadoras = ["Tengo que atraparlos a todos", "Nunca me rendire"]
} 

misty :: Entrenador
misty = UnEntrenador {
    nombre = "Misty",
    medallas = False,
    experiencia = 500,
    frasesMotivadoras = ["El agua siempre encuentra su camino"]
}

-- punto 2

type Mejora = Entrenador -> Entrenador

tieneMedallas :: Entrenador -> Bool
tieneMedallas = medallas

piedraEvolutiva :: String -> Mejora
piedraEvolutiva frase entrenador
  | nombre entrenador == "Ash" =
      entrenador {
        medallas = True,
        frasesMotivadoras =
          frase : frasesMotivadoras entrenador
      }
  | otherwise = entrenador

entrenamientoIntensivo :: Mejora
entrenamientoIntensivo entrenador =
  entrenador {
    nombre = "Maestro " ++ nombre entrenador,
    medallas = True,
    experiencia = experiencia entrenador * 2
  }

medallaLegendaria :: Entrenador -> Mejora
medallaLegendaria elEntrenadorQueDa elEntrenadorQueRecibe 
    | nombre elEntrenadorQueDa == "Oak" =
        elEntrenadorQueRecibe {
            medallas = True,
            frasesMotivadoras = []
        } 
    | otherwise = elEntrenadorQueRecibe {
        medallas = True
    }
-- punto 3 

-- misterio1 :: Entrenador -> (Entrenador -> a) -> a
-- misterio2 :: (a -> Entrenador) -> a -> Int
-- misterio3 :: (a -> b) -> (Entrenador -> a) -> Entrenador -> b