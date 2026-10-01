class Gira {
    var property banda 
    var property cantidadDeFechas
    var property tipoDeGira   

    method costoTotal() = self.costoBase() + tipoDeGira.costoExtra(self)
    method costoBase() = cantidadDeFechas * 500

}



class GiraComun inherits  Gira{
}

class GiraEstadio inherits  Gira{
    override method costoTotal() = 
        super() + 2000
}

object giraNacional{
    method costoExtra(gira) = 0 
}

object giraInternacional{
    method costoExtra(gira) = 1000 
}

const giraHarry = new GiraEstadio (
  banda = "Harry Styles",
  cantidadDeFechas = 100,
  tipoDeGira = giraInternacional
)

const giraColdPlay = new GiraComun (
    banda = "ColdPlay",
    cantidadDeFechas = 10,
    tipoDeGira = giraNacional
)

