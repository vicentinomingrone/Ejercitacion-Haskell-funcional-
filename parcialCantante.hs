type Nombre = String
type Cancion = String
type Album = String
type Genero = String
type Anio = Int
type Duracion = Int -- en segundos
type Reproducciones = Int
type Popularidad = Float

data Cantante = UnCantante {
  nombreCantante :: Nombre,
  generoCantante :: Genero,
  anioDebut :: Anio,
  canciones :: [Cancion],
  albumFavorito :: Album,
  popularidadCantante :: Popularidad,
  reproduccionesTotales :: Reproducciones
} deriving Show

cumplen :: (a -> b) -> (b -> b -> Bool) -> a -> a -> Bool
cumplen transformacion comparacion valor1 valor2 =
  comparacion (transformacion valor1) (transformacion valor2)


-- Parte 1 — Modelado, composición y aplicación parcial
-- 1. Cantante reciente, Un cantante es reciente si debutó en el año 2015 o después.
-- usar composición y aplicación parcial.

esReciente :: Cantante -> Bool
esReciente = (>=2015).anioDebut

-- 2. Cantante popular, Un cantante es popular si su popularidad es mayor a 8.
esPopular :: Cantante -> Bool
esPopular = (>8).popularidadCantante

--3. Nombre artístico largo
-- Un cantante tiene nombre artístico largo si su nombre tiene más de 10 caracteres. Composicion
nombreArtisticoLargo :: Cantante -> Bool
nombreArtisticoLargo = (>10).length.nombreCantante

--4. Cantante muy escuchado, Un cantante es muy escuchado si tiene más de 1000000 reproducciones totales.

muyEscuchado :: Cantante -> Bool
muyEscuchado = (>1000000).reproduccionesTotales

--5. Cantante destacado, Un cantante es destacado si: es popular; es muy escuchado; y tiene nombre artístico largo.
cantanteDestacado :: Cantante -> Bool
cantanteDestacado cantante = esPopular cantante && muyEscuchado cantante && nombreArtisticoLargo cantante

-- 6. Ficha del cantante, vas a necesitar Show. fichaCantante harry
-- "Harry Styles - Pop - Debut: 2010 - Popularidad: 9.5"

fichaCantante :: Cantante -> String
fichaCantante cantante = nombreCantante cantante ++ " - " ++ generoCantante cantante ++ " - Debut: " ++ show(anioDebut cantante) ++ " - popularidad: " ++ show(popularidadCantante cantante) 


-- Parte 2 — Guardas y clasificación, 
-- 7. Categoría por popularidad.
{-
Reglas:
si tiene popularidad menor a 5: "poco conocido"
si tiene popularidad menor a 8: "conocido"
si tiene 8 o más: "estrella"
Condición: usar guardas.
-}

categoriaPopularidad :: Cantante -> String
categoriaPopularidad cantante  
    | popularidadCantante cantante < 5 = "poco conocido"
    | popularidadCantante cantante < 8 = "conocido"
    | otherwise = "estrella"

-- 8. Categoría por debut
{- 
Reglas:
si debutó en 2020 o después: "nuevo"
si debutó en 2010 o después: "con trayectoria"
si debutó antes de 2010: "leyenda"
Condición: usar guardas.
-}

categoriaTrayectoria :: Cantante -> String
categoriaTrayectoria cantante
    | anioDebut cantante >= 2020 = "nuevo"
    | anioDebut cantante >= 2010 = "con trayectoria"
    | otherwise = "leyenda"


-- Parte 3 — Listas, pattern matching y recursividad
-- 9. Primera canción, Devuelve la primera canción de la lista de canciones del cantante. 
-- Condición: usar pattern matching sobre la lista de canciones.
primeraCancion :: Cantante -> Cancion
primeraCancion cantante = 
    primeraDeLaLista (canciones cantante)

primeraDeLaLista :: [Cancion] -> Cancion
primeraDeLaLista (cancion:_) = cancion 

-- 10. Cantidad de canciones, Debe contar cuántas canciones tiene un cantante usando recursividad, sin usar length.
-- Pista: podés hacer una auxiliar sobre [Cancion].

cantidadDeCanciones :: Cantante -> Int
cantidadDeCanciones cantante =
    listaDeCanciones (canciones cantante)

listaDeCanciones :: [Cancion] -> Int
listaDeCanciones [] = 0
listaDeCanciones (cancion:canciones) = 1 + listaDeCanciones canciones

-- 11. Tiene canción, Debe decir si un cantante tiene esa canción en su lista. Condición: usar recursividad, sin usar elem, any ni filter.

tieneCancion :: Cancion -> Cantante -> Bool
tieneCancion cancionBuscada cantante =
  buscarCancion cancionBuscada (canciones cantante)

buscarCancion :: Cancion -> [Cancion] -> Bool
buscarCancion _ [] = False
buscarCancion cancionBuscada (cancion:cancionesRestantes) =
  cancionBuscada == cancion || buscarCancion cancionBuscada cancionesRestantes


-- Parte 4 — Orden superior

-- 13. Cantantes populares, Devuelve solo los cantantes populares. Usar Filter.   

cantantesPopulares :: [Cantante] -> [Cantante]
cantantesPopulares = filter esPopular 
-- cantantesPopulares cantante = filter esPopular cantante --> Sin POINT FREE

-- 14. Hay cantante destacado, Devuelve True si hay al menos un cantante destacado.
-- Condicion: Usar any 
hayCantanteDestacado :: [Cantante] -> Bool
hayCantanteDestacado cantante = any cantanteDestacado cantante

-- 15. Todos son muy escuchados, Devuelve True si todos los cantantes tienen más de 1000000 reproducciones.
-- Condición: usar all.

todosMuyEscuchados :: [Cantante] -> Bool
todosMuyEscuchados = all muyEscuchado

-- 16. Reproducciones totales del festival, Devuelve la suma de las reproducciones totales de todos los cantantes.
-- Condición: usar foldl con lambda.

reproduccionesDelFestival :: [Cantante] -> Reproducciones
reproduccionesDelFestival = foldl (\sum cantante -> sum + reproduccionesTotales cantante) 0

-- Parte 5 — Lambdas y tuplas 
-- 17. Nombres y álbumes, Devuelve una lista de tuplas con el nombre del cantante y su álbum favorito.
-- Condición: usar map con lambda. 

nombresYAlbumes :: [Cantante] -> [(Nombre, Album)]
nombresYAlbumes = map (\cantante -> (nombreCantante cantante, albumFavorito cantante))

-- 19. Popularidades aumentadas, Devuelve una lista con la popularidad de cada cantante aumentada en 0.5.
-- Condición: usar map con lambda.

popularidadesAumentadas :: [Cantante] -> [Popularidad]
popularidadesAumentadas = map (\cantante -> popularidadCantante cantante + 0.5)

-- Parte 6 — Funciones genéricas y composición
-- 20. Misma característica, Debe decir si dos cantantes tienen igual una característica dada.
-- Pista: podés usar cumplen.

mismaCaracteristica :: Eq b => (Cantante -> b) -> Cantante -> Cantante -> Bool
mismaCaracteristica caracteristica cantante1 cantante2 = cumplen caracteristica (==) cantante1 cantante2


-- 21. Más popular que otro, Un cantante es más popular que otro si su popularidad es mayor.
-- Condición: usar cumplen.

masPopularQue :: Cantante -> Cantante -> Bool
masPopularQue cantante1 cantante2 = cumplen popularidadCantante (>) cantante1 cantante2


-- 22. Misma categoría de trayectoria
-- Dos cantantes tienen la misma categoría de trayectoria si categoriaTrayectoria les da el mismo resultado.
-- Condición: usar cumplen.

mismaCategoriaTrayectoria :: Cantante -> Cantante -> Bool
mismaCategoriaTrayectoria cantante1 cantante2 = cumplen categoriaTrayectoria (==) cantante1 cantante2

-- Parte 7 — Sistema de tipos, 
-- 23. Inferencia de tipos
-- Inferí el tipo de estas funciones y justificá brevemente:
{-
f1 :: Eq a => a -> a -> Bool
f1 x y = x == y

f2 :: 
f2 f x = f x > 100

f3 condicion cantantes = filter condicion cantantes

f4 transformacion cantantes = map transformacion cantantes

f5 :: Cantante -> Popularidad
f5 cantante = popularidadCantante cantante + 0.5
-}

-- Parte 8 — Expresividad y declaratividad
-- 24. Analizar calidad de código, Analizá esta función:

f cantante =
  popularidadCantante cantante > 8 && reproduccionesTotales cantante > 1000000

{-
¿Qué hace? Devuelve True si el cantante es popular y tiene muchas reproducciones
¿Tiene problemas de expresividad? si
¿Tiene problemas de declaratividad? si, no dice q hace, solo dice como lo hace
¿Cómo la mejorarías? ni puta idea bro
-} 

-- 25. Refactor, Esta función funciona, pero es poco expresiva:

g cantante =
  length (nombreCantante cantante) > 10

{-
¿Qué hace? devuelve True si el nombre del cantante tiene más de 10 caracteres
¿Qué problema tiene? no es expresiva, no dice q hace, solo dice como lo hace
Reescribila usando un nombre más expresivo. no
-}

-- Parte 9 — Más parecido al parcial
-- 26. Cantantes recomendables

{-
Un cantante es recomendable si:
tiene popularidad mayor o igual a 7;
tiene más de 500000 reproducciones;
tiene al menos 2 canciones.
Condición: usar filter y funciones auxiliares expresivas.
-}

cantantesRecomendables :: [Cantante] -> [Cantante]
cantantesRecomendables = filter esRecomendable 

esRecomendable :: Cantante -> Bool
esRecomendable cantante = popularidadCantante cantante >= 7 && reproduccionesTotales cantante > 500000 && cantidadDeCanciones cantante >= 2


-- 27. Mejor opción musical
{-
Entre dos cantantes, devuelve el más conveniente para recomendar.
Un cantante es mejor opción si:
tiene mayor popularidad;
si empatan en popularidad, tiene más reproducciones.
Podés usar guardas.
-}

mejorOpcionMusical :: Cantante -> Cantante -> Cantante
mejorOpcionMusical cantante1 cantante2
  | popularidadCantante cantante1 > popularidadCantante cantante2 = cantante1
  | popularidadCantante cantante1 == popularidadCantante cantante2 &&
    reproduccionesTotales cantante1 > reproduccionesTotales cantante2 = cantante1
  | otherwise = cantante2

-- 28. Buscar mejor cantante
{-
Devuelve el mejor cantante de una lista usando foldl1.
Pista: reutilizá mejorOpcionMusical.
No hace falta contemplar lista vacía.
-}

buscarMejorCantante :: [Cantante] -> Cantante
buscarMejorCantante = foldl1 mejorOpcionMusical