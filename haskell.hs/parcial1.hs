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

type Insignia = Entrenador -> Bool

puedeTenerInsignia :: Insignia
puedeTenerInsignia entrenador =
  tieneMedallas entrenador
  || experiencia entrenador > 600
  || nombre entrenador == "Ash"

puedeGanarSegun :: Insignia -> Entrenador -> Bool
puedeGanarSegun condicionParticular entrenador =
  condicionParticular entrenador
  && puedeTenerInsignia entrenador

seLlamaPikachu :: Insignia
seLlamaPikachu =
  (== "Pikachu") . nombre

condicionSabio :: Insignia
condicionSabio entrenador =
  length (frasesMotivadoras entrenador) >= 2
  && tieneMedallas entrenador

condicionPrincipiante :: Insignia
condicionPrincipiante entrenador =
  length (frasesMotivadoras entrenador) < 2
  && not (tieneMedallas entrenador)

maestroElectrico :: Insignia
maestroElectrico =
  puedeGanarSegun seLlamaPikachu

sabioPokemon :: Insignia
sabioPokemon =
  puedeGanarSegun condicionSabio

principianteValiente :: Insignia
principianteValiente =
  puedeGanarSegun condicionPrincipiante


type Grupo = [Entrenador]   

cantidadQueGanan :: Insignia -> Grupo -> Int
cantidadQueGanan insignia grupo =
  length (filter insignia grupo)

nombresDeExperimentados :: Grupo -> [String]
nombresDeExperimentados grupo = 
    map nombre (filter experimentado grupo)

experimentado :: Entrenador -> Bool 
experimentado = (> 700) . experiencia