
data Personaje = UnPersonaje {
    nombre :: String,
    poderes :: Bool, 
    fuerza :: Int,
    frasesSabias :: [String]
}

-- Punto 1 

finn :: Personaje
finn = UnPersonaje {
    nombre = "Finn",
    poderes = False,
    fuerza = 600,
    frasesSabias = []
}

jake :: Personaje
jake = UnPersonaje {
    nombre = "Jake",
    poderes = True,
    fuerza = 1500,
    frasesSabias = ["mientras conoozca la forma de mi alma, esta bien", 
    "ser un poco malo en algo es el comienzo de ser un poco bueno en algo", 
    "Si consigues todo lo que quieres en el moemento ¿que sentindo tiene vivir?"]
}


-- Punto 2 

type Mejora = Personaje -> Personaje

espadaDePasto :: String -> Mejora
espadaDePasto frase personaje
  | nombre personaje == "Finn" = personaje {
      poderes = True,
      frasesSabias = frase : frasesSabias personaje
    }
  | otherwise = personaje

porFeoVendeBarato :: Mejora
porFeoVendeBarato personaje = 
    personaje {
        nombre = "feo" ++ " " ++ nombre personaje,
        poderes = True,
        fuerza = fuerza personaje * 2
    }

coronaHelada :: Personaje -> Mejora
coronaHelada otorgante receptor
  | nombre otorgante == "Simon" = receptor {
      poderes = True,
      frasesSabias = []
    }
  | otherwise = receptor {
      poderes = True
    }