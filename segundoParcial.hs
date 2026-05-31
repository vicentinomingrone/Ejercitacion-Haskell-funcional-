type Titulo = String
type Director = String
type Genero = String
type Anio = Int
type Duracion = Int
type Calificacion = Float
type Reproducciones = Int

data Pelicula = UnaPelicula {
  tituloPelicula :: Titulo,
  directorPelicula :: Director,
  generoPelicula :: Genero,
  anioPelicula :: Anio,
  duracionPelicula :: Duracion,
  calificacionPelicula :: Calificacion,
  reproduccionesPelicula :: Reproducciones
} deriving Show

cumplen :: (a -> b) -> (b -> b -> Bool) -> a -> a -> Bool
cumplen transformacion comparacion valor1 valor2 =
  comparacion (transformacion valor1) (transformacion valor2)

esReciente :: Pelicula -> Bool
esReciente = (>= 2020) . anioPelicula 

esLarga :: Pelicula -> Bool
esLarga = (> 120) . duracionPelicula

tituloLargo :: Pelicula -> Bool
tituloLargo = (> 12) . length . tituloPelicula

esPopular :: Pelicula -> Bool
esPopular = (> 100000) . reproduccionesPelicula

buenaCalificacion :: Pelicula -> Bool 
buenaCalificacion = (> 8) . calificacionPelicula

peliculaDestacada :: Pelicula -> Bool
peliculaDestacada pelicula =
  esReciente pelicula && buenaCalificacion pelicula && esPopular pelicula

fichaPelicula :: Pelicula -> String
fichaPelicula pelicula = 
  tituloPelicula pelicula ++ " - " ++ 
  directorPelicula pelicula ++ " - " ++ 
  show (anioPelicula pelicula) ++ " - " ++ 
  show (calificacionPelicula pelicula)

categoriaDuracion :: Pelicula -> String
categoriaDuracion pelicula 
  | duracionPelicula pelicula < 90 = "corta"
  | duracionPelicula pelicula < 140 = "normal"
  | otherwise = "larga"

categoriaCalificacion :: Pelicula -> String
categoriaCalificacion pelicula 
  | calificacionPelicula pelicula < 5 = "mala"
  | calificacionPelicula pelicula < 8 = "buena"
  | otherwise = "excelente"

primeraPelicula :: [Pelicula] -> Pelicula
primeraPelicula (x:_) = x

cantidadDePeliculas :: [Pelicula] -> Int
cantidadDePeliculas [] = 0
cantidadDePeliculas (_:xs) = 1 + cantidadDePeliculas xs

existeTitulo :: Titulo -> [Pelicula] -> Bool
existeTitulo _ [] = False
existeTitulo titulo (pelicula:peliculas) =
  tituloPelicula pelicula == titulo || existeTitulo titulo peliculas

titulosDelCatalogo :: [Pelicula] -> [Titulo]
titulosDelCatalogo = map tituloPelicula

peliculasRecientes :: [Pelicula] -> [Pelicula]
peliculasRecientes = filter esReciente

hayPeliculaDestacada :: [Pelicula] -> Bool
hayPeliculaDestacada = any peliculaDestacada

todasSonLargas :: [Pelicula] -> Bool
todasSonLargas = all esLarga

duracionTotal :: [Pelicula] -> Duracion
duracionTotal = foldl (\acum pelicula -> acum + duracionPelicula pelicula) 0

titulosYDirectores :: [Pelicula] -> [(Titulo, Director)]
titulosYDirectores =
  map (\pelicula -> (tituloPelicula pelicula, directorPelicula pelicula))


-- 18. Películas muy vistas, Devuelve películas con más de 500000 reproducciones.
peliculasMuyVistas :: [Pelicula] -> [Pelicula]
peliculasMuyVistas = filter (\peliculas -> reproduccionesPelicula peliculas > 500000)

-- 19. Calificaciones aumentadas, Devuelve una lista con la calificación de cada película aumentada en 0.5. Condición: usar map con lambda.

calificacionesAumentadas :: [Pelicula] -> [Calificacion]
calificacionesAumentadas = map (\peliculas -> calificacionPelicula peliculas * 0.5)

-- Parte 6 — Funciones genéricas y composición

-- 20. Misma característica. 
mismaCaracteristica :: Eq b => (Pelicula -> b) -> Pelicula -> Pelicula -> Bool
mismaCaracteristica caracteristica =
    cumplen caracteristica (==)


-- 21. Mejor calificada que otra, si su calificacion es mayor que la otra 

mejorCalificadaQue :: Pelicula -> Pelicula -> Bool
mejorCalificadaQue = 
    cumplen calificacionPelicula (>)




