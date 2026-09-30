class Envio {
    var property peso 
    var property distancia
    var property tipoDeEntrega   

    method costoBase() = peso * 100 + distancia * 10

    method costoTotal() = self.costoBase() + tipoDeEntrega.costoExtra(self)
    
}

class EnvioComun inherits Envio {
    override method costoTotal() =
        super() + 10 
}

class EnvioFragil inherits Envio {
    override method costoTotal() = 
        super() + 300 
}

class EnvioLejano inherits Envio {
    override method costoTotal() = 
        super() + 1500

}


object entregaNormal {
    method costoExtra(envio) = 0 
}

object entregaExpress {
    method costoExtra(envio) = 500 

}

// Instancias  de Envios 


const envio1 = new EnvioComun (
    peso = 30, 
    distancia = 500, 
    tipoDeEntrega = entregaNormal 
)

const envio2 = new EnvioFragil (
    peso = 90, 
    distancia = 100, 
    tipoDeEntrega = entregaExpress
)