{-- Ejercicio 1 
cuadrado :: Int -> Int 
cuadrado numero = numero * numero 

-- Ejercico 2 

esPositivo :: Int -> Bool
esPositivo = (> 0) 

-- Ejercicio 3 

esNombreFinn :: String -> Bool 
-- esNombreFinn nombre = nombre == "Finn" 
esNombreFinn = (== "finn")

-- Ejercicio 4 

aumentarEn :: Int -> Int -> Int 
aumentarEn numero1 numero2 = numero1 + numero2 

-- Ejercicio 5  

aumentarEnCinco :: Int -> Int
aumentarEnCinco = aumentarEn 5

-- Ejercicio 1
triple :: Int -> Int
triple = (*3)

-- Ejercicio 2
esPar :: Int -> Bool
esPar numero = even numero 

-- otros Ejercicios -> 
-- esNegativo 
esNegativo :: Int -> Bool 
esNegativo = (< 0) 

-- nombre Largo. es largo si tiene mas de 7 caracteres 
nombreLargo :: String -> Bool 
nombreLargo =   (> 7 ) . length 

-- duplicarTodos -> todos los numeros de la lista duplicarlo
duplicarTodos :: [Int] -> [Int]
duplicarTodos = map (*2)

-- soloPares 
soloPares :: [Int] -> [Int]
soloPares  = filter even

-- cantidad de psoitivos 
cantidadDePositivos :: [Int] -> Int
cantidadDePositivos = length . filter (>0)

-- otros Ejercicios -> 
-- esNegativo 
esNegativo :: Int -> Bool 
esNegativo numero  = numero < 0   

-- nombre Largo. es largo si tiene mas de 7 caracteres 
nombreLargo :: String -> Bool 
nombreLargo nombre =   length nombre > 7  

-- duplicarTodos -> todos los numeros de la lista duplicarlo
duplicarTodos :: [Int] -> [Int]
duplicarTodos lista = map (*2) lista  

-- soloPares 
soloPares :: [Int] -> [Int]
soloPares lista = filter  even lista 

-- cantidad de psoitivos 
cantidadDePositivos :: [Int] -> Int
cantidadDePositivos lista = length  (filter (>0) lista)

-}

-- Empecemos con parciales 

data Entrenador = UnEntrenador {
    nombre :: String, 
    medallas :: Bool,
    experiencia :: Int, 
    frasesMotivadoras :: [String]
} 

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

-- Mejoras 

type Mejora = Entrenador -> Entrenador



-- a

siEsAsh :: Entrenador -> Bool
siEsAsh =
  (== "Ash") . nombre

piedraEvolutiva :: String -> Mejora
piedraEvolutiva frase entrenador
  | siEsAsh entrenador =
      entrenador {
        medallas = True,
        frasesMotivadoras =
          frase : frasesMotivadoras entrenador
      }
  | otherwise = entrenador

-- b 

entrenamientoIntensivo :: Mejora 
entrenamientoIntensivo entrenador =  entrenador {
    nombre = "Maestro " ++ nombre entrenador,
    medallas = True, 
    experiencia = experiencia entrenador * 2
}

-- c 

siEsOak :: Entrenador -> Bool
siEsOak =
  (== "Oak") . nombre

medallaLegendaria :: Entrenador -> Mejora
medallaLegendaria entrenadorEntrega entrenadorRecibe
  | siEsOak entrenadorEntrega =
      entrenadorRecibe {
        medallas = True,
        frasesMotivadoras = []
      }
  | otherwise =
      entrenadorRecibe {
        medallas = True
      }
