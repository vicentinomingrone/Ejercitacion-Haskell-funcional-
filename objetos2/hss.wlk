class Panelista{
    var estrellas=0
    const tipoPanelista
    
    method estrellas()= estrellas
    method darRemateGracioso(tematica)
    method sumarEstrellas(cantidad){
        estrellas+=cantidad
    }
    method tipoPanelista()=tipoPanelista
    method opinarSobreTematica(tematica){
        tematica.tipo().analizarSituacion(self)
    } 
}
class Celebridad inherits Panelista{
 override method darRemateGracioso(tematica) {
    estrellas+=3
 }
}

class Colorado inherits Panelista{
    var gracia

    override method darRemateGracioso(tematica){
        estrellas+= (0.2*gracia)
        self.aumentarGracia()
    }
    method aumentarGracia() {
        gracia+=1
    }
}
class ColoradoConPeluca inherits Colorado{
    override method darRemateGracioso(tematica){
        super(tematica) 
        estrellas+=1
    }
}
class Viejo inherits Panelista{
     
override method darRemateGracioso(tematica){
        estrellas+= tematica.titulo().words().size()
    }
}
class PanelistaDeportivo inherits Panelista{
     override method darRemateGracioso(tematica){
        estrellas+= 0
    }
}


class Tematica{
    const titulo
    const tipo
    const desarrollo

    method tipo()=tipo
    method desarrollo()=desarrollo
    method titulo()=titulo
    method esInteresante() = tipo.interesa(self)
}

object deportiva{
    method interesa(tematica)=tematica.titulo().words().contains("Messi")
    method analizarSituacion(panelista){
        if(panelista.tipoPanelista()== PanelistaDeportivo)
        {
            panelista.sumarEstrellas(5)
        }
        else{
            panelista.sumarEstrella(1)
        }
    }
}

class Farandula{
    const panelistasInvolucrados
   
   
    method esInteresante(tematica)= panelistasInvolucrados.size()>=3
    method analizarSituacion(panelista){
        if(panelistasInvolucrados.any({panelista => panelista.tipoPanelista()== Celebridad})) 
        {
            panelista.sumarEstrellas(panelistasInvolucrados.size())
        }
        else{
            panelista.sumarEstrellas(1)
        }
    }
}
class Filosofica{
    
    method esInteresante(tematica)= tematica.desarrollo().words().size()>20
    method analizarSituacion(panelista){
        panelista.sumarEstrellas(1)
    }
}

object economica{
method interesa(tematica)=false
   method analizarSituacion(panelista){
        panelista.sumarEstrellas(1)
    }
}
object moral{
    method interesa(tematica)=false
    method analizarSituacion(panelista){
        panelista.sumarEstrellas(1)
    }
}

class TematicaMixta { 
    var property tematicasEnvueltas
    var property tipos
    

    method esInteresante()= tematicasEnvueltas.any({tematica=>tematica.esInteresante()})
    method titulo()= tematicasEnvueltas.map({tematica=> tematica.titulo().join(" ")})
    method opinarSobreTematica(panelista){
        tipos.forEach({tematica=> tematica.opinarSobreTematica(panelista)})
    } 
}

class Emision{
    const tematicasATratar
    const panelistas
    var emitiendose 

    
    method sePuedeEmitir()= (panelistas.size()>=2) and (tematicasATratar.count({tematica => tematica.esInteresante()}) >= tematicasATratar.size()/2)
    method emitir(){
        if(self.sePuedeEmitir())
        {
            tematicasATratar.forEach({tematica => panelistas.forEach({panelista => panelista.opinarSobreTematica(tematica)})})
            emitiendose=true
        }
        
    }
    method terminarEmision(){
        emitiendose=false
    }
    method panelistaEstrella() 
    {
        if( emitiendose){
            throw new DomainException(message="No termino la emision todavia")
        }
        return panelistas.max({panelista => panelista.estrellas() })
    }
}