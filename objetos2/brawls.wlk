class Mision {
    const copasBase

    method superada() = self.destrezaSuficiente() || self.personajeTieneEstrategia()

    method destrezaSuficiente()
    method personajeTieneEstrategia()

    method realizar(){
        if(!self.puedeRealizarse()){
          throw new Exception(message = "Misión no puede comenzar")
        }
        self.repartirCopas()
    }

    method cantidadPersonas()

    method puedeRealizarse() 
    method repartirCopas()
}

class MisionesIndividuales inherits Mision {
    var dificultad
    var personaje

    method copasPorJugar() = dificultad * 2 

    override method destrezaSuficiente() = personaje.destreza() > dificultad 
    override method personajeTieneEstrategia() = personaje.tieneEstrategia()

    override method puedeRealizarse() = personaje.copasObtenidas() >= 10  
}

class MisionesPorEquipo inherits Mision {
    var personajes = []
    
    
    override method puedeRealizarse() = personajes.sum{p => p.copasObtenidas()} >= 60 
    override method personajeTieneEstrategia() = self.personajesConEstrategia() > self.mitadPersonajes()
    override method destrezaSuficiente() = personajes.all({p => p.destreza() > 400})
    
    
    method cantCopasEnJuego() = 50 / personajes.size() 
    method cantidadPersonas() = personajes.size() 
    method mitadPersonajes() = personajes.size()/2
    method personajesConEstrategia() = personajes.count{ p => p.tieneEstrategia()}

}

class Boost inherits MisionesIndividuales {
    const multiplicador 

    method copasFinales() = copasBase * multiplicador
}

class Bonus inherits MisionesPorEquipo {
    
    method copasFinales() = copasBase + self.cantidadPersonas()
}


class Personaje{
    var copasGanadas = 0

    method copasObtenidas() = copasGanadas
    
    method darCopas(cantidad) {
      copasGanadas += cantidad 
    }
}


class Arqueros inherits Personaje {
    var agilidad 
    var rango 

    method destreza() = agilidad * rango 

    method tieneEstrategia() = rango > 100 

}

class Ballesteros inherits Arqueros{
    
    override method destreza() = super() * 2


}

class Guerreras inherits Personaje {
    var fuerza 
    var estrategia

    method tieneEstrategia() = estrategia

    method destreza() = fuerza * 1.5 
    
}