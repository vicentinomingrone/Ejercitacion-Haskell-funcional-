data Auto = UnAuto {
    marca :: String,
    modelo :: String, 
    kilometros :: Int, 
    verificacionAprobada :: Bool,
    listaDeAsesorio :: [String]
} deriving Show

-- Modelado Del Toyota Corolla 

corolla :: Auto
corolla = UnAuto {
    marca = "Toyota",
    modelo = "Corolla",
    kilometros = 85000,
    verificacionAprobada = True,
    listaDeAsesorio = ["Aire acondicionado", "Camara trasera"]
}

-- Modelado de Ford Fiesta

fiesta :: Auto 
fiesta = UnAuto {
    marca = "Ford",
    modelo = "Fiesta",
    kilometros = 120000,
    verificacionAprobada = False,
    listaDeAsesorio = ["Bluetooth"]
}

type Mejora = Auto -> Auto

-- Punto 2


