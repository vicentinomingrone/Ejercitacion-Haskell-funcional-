type Marca = String
type Modelo = String
type Patente = String
type Kilometros = Int
type Precio = Int

data Revision = UnaRevision {
  kilometrosRevision :: Kilometros,
  costoRevision :: Precio
} deriving Show 

data Auto = UnAuto {
  marca :: Marca,
  modelo :: Modelo,
  patente :: Patente,
  precio :: Precio,
  revisiones :: [Revision]
} deriving Show


-- Punto 1 

modelosConRevisionCaras :: Precio -> [Auto] -> [Modelo]
modelosConRevisionCaras minimo =
    map modelo . filter (all ((>= minimo) . costoRevision) . revisiones)


-- otro 

patentesDeAutosConRevision :: Kilometros -> [Auto] -> [Patente]
patentesDeAutosConRevision minimokm = 
    map patente . filter (any ((>= minimokm) . kilometrosRevision) . revisiones)  



type Nombre = String
type Materia = String
type Nota = Float

data Examen = UnExamen {
  materia :: Materia,
  nota :: Nota
}

data Alumno = UnAlumno {
  nombreAlumno :: Nombre,
  examenes :: [Examen]
}
 

alumnosAprobados :: Nota -> [Alumno] -> [Nombre]
alumnosAprobados minimo =
    map nombreAlumno . filter (all ((>= minimo) . nota) . examenes) 


materiasDesaprobadas :: [Alumno] -> [Materia]
materiasDesaprobadas alumnos =
  map materia (filter ((< 6) . nota) (concat (map examenes alumnos)))


alumnosConMateriaAprobada :: Materia -> [Alumno] -> [Nombre]
alumnosConMateriaAprobada materiaBuscada =
  map nombreAlumno . filter (\alumno -> any (\examen -> materia examen == materiaBuscada && nota examen >= 6) (examenes alumno))

esDeLaMateria :: Materia -> Examen -> Bool 
esDeLaMateria materiaBuscada examen = 
    materia examen == materiaBuscada  

examenAprobado :: Examen -> Bool
examenAprobado = (>= 6) . nota

examenDeMateriaAprobada :: Materia -> Examen -> Bool
examenDeMateriaAprobada materiaBuscada examen =
    esDeLaMateria materiaBuscada examen && examenAprobado examen 


type NombreSerie = String
type Genero = String
type Duracion = Int
type Calificacion = Int

data Episodio = UnEpisodio {
  tituloEpisodio :: String,
  duracionEpisodio :: Duracion,
  calificacionEpisodio :: Calificacion
}

data Serie = UnaSerie {
  nombreSerie :: NombreSerie,
  generoSerie :: Genero,
  episodios :: [Episodio]
}


seriesBienCalificada ::  [Serie] -> [NombreSerie]
seriesBienCalificada = 
    map nombreSerie . filter (all ((>= 8) . calificacionEpisodio) . episodios)



