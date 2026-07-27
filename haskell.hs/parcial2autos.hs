import System.Console.Haskeline (Settings(autoAddHistory))
data Auto = UnAuto {
    marca :: String,
    modelo :: String, 
    kilometros :: Int, 
    verificacionAprobada :: Bool,
    listaDeAccesorio :: [String]
} deriving Show

corolla :: Auto
corolla = UnAuto {
    marca = "Toyota",
    modelo = "Corolla",
    kilometros = 85000,
    verificacionAprobada = True,
    listaDeAccesorio = [
        "Aire acondicionado",
        "Camara trasera"
    ]
}

fiesta :: Auto 
fiesta = UnAuto {
    marca = "Ford",
    modelo = "Fiesta",
    kilometros = 120000,
    verificacionAprobada = False,
    listaDeAccesorio = ["Bluetooth"]
}

type Mejora = Auto -> Auto

agregarAccesorio :: String -> Mejora 
agregarAccesorio accesorio auto 
    | esToyota auto =
        auto {
            verificacionAprobada = True,
            listaDeAccesorio =
                accesorio : listaDeAccesorio auto 
        }
    | otherwise = auto 

esToyota :: Auto -> Bool 
esToyota auto =
    marca auto == "Toyota"

servicioCompleto :: Mejora 
servicioCompleto auto =
    auto {
        kilometros = kilometros auto `div` 2, 
        verificacionAprobada = True,
        listaDeAccesorio =
            "Service Oficial" : listaDeAccesorio auto 
    }

transferenciaEspecial :: Auto -> Mejora 
transferenciaEspecial autoTransfiere autoRecibe  
    | marca autoTransfiere == "Ferrari" = 
        autoRecibe {
    verificacionAprobada = True, 
    listaDeAccesorio = []
    }
    | otherwise = autoRecibe {
    verificacionAprobada = True}
{-
misterio1 :: Auto -> (Auto -> a) -> a
misterio2 :: Mejora -> Auto -> Int
misterio3 :: (a -> b) -> (Auto -> a) -> Auto -> b
-}

type Categoria = Auto -> Bool

puedeSerExhibido :: Categoria
puedeSerExhibido auto = 
    verificacionAprobada auto 
    || kilometros auto < 100000
    || marca auto == "Toyota"

clasicoDeportivo :: Categoria 
clasicoDeportivo auto = 
    puedePertenecerSegun esFerrari auto

esFerrari :: Categoria 
esFerrari auto = marca auto == "Ferrari"

autoEquipado :: Categoria 
autoEquipado auto = 
     puedePertenecerSegun condicionEquipado auto 

economicoConfiable :: Categoria
economicoConfiable auto = 
    puedePertenecerSegun condicionEconomico auto 

tieneMenosDeDosAccesorios :: Auto -> Bool 
tieneMenosDeDosAccesorios auto =
    length (listaDeAccesorio auto) < 2  

puedePertenecerSegun :: Categoria -> Auto -> Bool
puedePertenecerSegun condicionParticular auto = 
    condicionParticular auto 
    && puedeSerExhibido auto 

condicionEquipado :: Categoria 
condicionEquipado auto = 
    not(tieneMenosDeDosAccesorios auto)
     && verificacionAprobada auto

condicionEconomico :: Categoria 
condicionEconomico auto = 
    tieneMenosDeDosAccesorios auto 
    && not(verificacionAprobada auto) 

type Flota = [Auto]

cantidadDeCategoria :: Categoria -> Flota -> Int 
cantidadDeCategoria categoriaParticular autos =
    lenght (filter categoriaParticular autos) 

modelosConPocosKm :: Flota -> [String]
modelosConPocosKm = map modelo . filter pocosKm


pocosKm :: Auto -> Bool 
pocosKm = (<90000). kilometros

todosConVerificacion :: Flota -> Bool 
todosConVerificacion = all verificacionAprobada

hayAlgunEquipado :: Flota -> Bool 
hayAlgunEquipado = any equipado

equipado :: Auto -> Bool 
equipado = (>=2). length  . listaDeAccesorio

aplicarUnaMejora :: Auto -> Mejora -> Auto
aplicarUnaMejora auto mejora =
    mejora auto

aplicarMejoras :: [Mejora] -> Auto -> Auto
aplicarMejoras mejoras auto =
    foldl aplicarUnaMejora auto mejoras

kilometrosTotalesLuegoDeMejoras :: [Mejora] -> Flota -> Int
kilometrosTotalesLuegoDeMejoras mejoras autos = 
    sum (map kilometros (map (aplicarMejoras mejoras) autos))

