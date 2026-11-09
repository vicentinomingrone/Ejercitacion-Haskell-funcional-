class Cliente{
    const telefono
    const packsActivos =[]
    const consumos=[]

    method comprarPack(pack) 
    { 
        packsActivos.add(pack)
    }
    method promedioDeConsumoEntre(fecha1,fecha2) 
    { 
        const consumosEntre=consumos.filter({consumo => consumo.consumirEntre(fecha1,fecha2)})
        return consumosEntre.sum({consumo=>consumo.precio()})/consumosEntre.size()
    }

    method costoDeLosUltimos30() {
    
    const hoy = new Date()
    const hace30Dias = hoy.minusDays(30)

    return consumos.filter({consumo => consumo.conumirEntre(hace30Dias, hoy)}).sum({ consumo => consumo.precio()})
    
    }
}


class Pack{
    const vigencia
    method satisfaceConsumo()

}
class PackCredito inherits Pack{
    var credito
    
    method credito()=credito

}

class PackMB inherits Pack{
    var megaBytes 
    
    method mb()= megaBytes 
    
 }

class PackLlamadasGratis inherits Pack{
    const segundosInfinitos=true
    method segundos()= segundosInfinitos
}
class packInternetIlimitado inherits Pack{
    const internetIlimitadoElFinde = true
    method internetIlimitadoElFinde()= internetIlimitadoElFinde
}
class Consumo{
    const fechaConsumo = new Date()
    method consumirEntre(minima,maxima)= fechaConsumo.between(minima,maxima)
    method precio()

}
class ConsumoInternet inherits Consumo{
    const cantidadMB 
    method cantidadSegundos()=0

    override method precio() = cantidadMB * empresaTelefonia.precioMB()
}  
class ConsumoLlamada inherits Consumo{
    var segundos
    method cantidadMB()=0

   override method precio()
    {
        if(segundos <=30)
        {
            return 100
        }
        return empresaTelefonia.precioSegundo()*(segundos-30) + 100
    }
    
}



object empresaTelefonia{
    var precioMB=2
    var precioSegundo=10
    
    method precioMB()=precioMB
    method precioSegundo()=precioSegundo
}
