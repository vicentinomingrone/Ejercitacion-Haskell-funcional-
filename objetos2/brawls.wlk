

class Mision{


    method copasEnJuego()
    method puedeSerSuperada()
    method realizarMision()
}


    class MisionPorEquipo inherits Mision{
        const participantes = []
        
        override method realizarMision() {
         if (participantes.sum({ participante => participante.copasGanadas() }) < 60) {
            throw new Exception(message = "No se puede realizar Mision")
        }
        if(self.puedeSerSuperada()){
            participantes.forEach({participante => participante.modificarCopas(self.copasEnJuego())})
        }else{
            participantes.forEach({participante => participante.modificarCopas(- self.copasEnJuego())})
        }
    }
        

        override method copasEnJuego() = 50/self.cantParticipantes() 

        method cantParticipantes()= participantes.size()

        method tienenEstrategia() = participantes.filter({participante => participante.tieneEstrategia()}).size()

        override method puedeSerSuperada() = self.tienenEstrategia() > (self.cantParticipantes()/2) ||
        participantes.all({participante => participante.destreza() > 400})
    }

class MisionIndividual inherits Mision{
    const dificultad
    const personaje

    override method puedeSerSuperada() = personaje.tieneEstrategia() || personaje.destreza() > dificultad

    override method copasEnJuego() = dificultad * 2

    override method realizarMision() {
        if(personaje.copasGanadas() < 10){
            throw new Exception(message = "No se puede realizar Mision")
        }
        if(self.puedeSerSuperada()){
            personaje.modificarCopas(self.copasEnJuego())
        }else{
            personaje.modificarCopas(- self.copasEnJuego()) 
        }
    }
}


class Personaje{
    var copasGanadas

    method modificarCopas(cantidad){
        copasGanadas += cantidad
    }

    method copasGanadas() = copasGanadas

    method destreza()
    method tieneEstrategia()

}
class Arquero inherits Personaje{
    const agilidad 
    const rango 

    override method destreza() = agilidad * rango

    override method tieneEstrategia() = rango > 100
}

class Guerrera inherits Personaje{
    const fuerza 
    const estrategia

    override method tieneEstrategia() = estrategia

    override method destreza() = fuerza * 1.5
}

class Ballestero inherits Arquero{

    override method destreza() = super() * 2
}