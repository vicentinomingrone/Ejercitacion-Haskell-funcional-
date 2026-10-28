class Persona{ 
    var temperatura = 0
    var celulas = 0 
    var enfermedades = []

    method contraer(enfermedad){
        if(self.cantidadEnfermedades() >= 7){
            throw new DomainException(
            message = "Una persona no puede tener mas de 7 enfermedades"
             )}
        enfermedades.add(enfermedad)
    }

    method cantidadEnfermedades() = enfermedades.size()

    method vivirUnDia(){
        enfermedades.forEach({enfermedad => enfermedad.aplicarEfecto(self)})
    }
    
    method aumentarTemperatura(grados){
        temperatura = 45.max(grados + temperatura)
    }
}

class EnfermedadAtenuable {
  var cantAmenazadas = 0
  
  method atenuarse(celulasCuradas) {
    cantAmenazadas = 0.max(cantAmenazadas - celulasCuradas)
  }
}

class Infecciosas inherits EnfermedadAtenuable {

    method reproducirce(){
        cantAmenazadas *= 2
    }

    method aplicarEfecto(persona){
        persona.aumentarTemperatura(cantAmenazadas/1000)
    }
}

class Autoinmunes inherits EnfermedadAtenuable{
    method aplicarEfecto(persona){
        persona.detruirCelulas(cantAmenazadas)
    }
}


const malaria = new Infecciosas (
    cantAmenazadas = 5000
)
