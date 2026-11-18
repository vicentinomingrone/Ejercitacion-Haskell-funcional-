class Filosofo{
    const nombre
    var edadEnDias
    const actividades 
    const honorificos 
    var nivelDeIluminacion

    method nivelDeIluminacion()=nivelDeIluminacion
    method agregarHonorifico(honorifico){
        if(not honorificos.contains(honorifico))
        {
            honorificos.add(honorifico)
        }
    }
    method presentarse()=  honorificos.join(",")+ " "+nombre

    method estaEnLoCorrecto() = nivelDeIluminacion > 1000
   method agregarActividad(actividad){
    actividades.add(actividad)
   }
   method realizarActividades(){
    actividades.forEach({actividad => actividad.hacer(self)})
   }
   method aumentarIluminacion(cantidad){
    nivelDeIluminacion+=cantidad
   } 
   method disminuirIluminacion(cantidad){
    nivelDeIluminacion-=cantidad
   }
   method rejuvenecer(cantidad){
    edadEnDias-=cantidad
   }
   method envejecer(cantidad){
    edadEnDias+=cantidad
   }

   method cumplirAnios()= edadEnDias%365==0
   method aumentarPorCumpleanios(){
    if(self.cumplirAnios()){
        self.aumentarIluminacion(10)
    }
    if(edadEnDias == 21900)
    {
        self.agregarHonorifico("el sabio")
    }
   }

   method vivirDia(){
    self.realizarActividades()
    self.envejecer(1)
    self.aumentarPorCumpleanios()
   }
    
}
class FilosofoContemporaneo inherits Filosofo{

    override method presentarse() = "hola"
    override method nivelDeIluminacion(){
        if(self.amaAdmirarPaisaje())
        {
            return super()*5
        }
        return super()
    }
    method amaAdmirarPaisaje()= actividades.contains(admirarPaisaje)
}
object tomarVino{

    method hacer(filosofo) {
        filosofo.disminuirIluminacion(10)
        filosofo.agregarHonorifico("el borracho")
    }
}

class JuntarseEnElAgora{
    const filosofo2

    method hacer(filosofo){
        filosofo.aumentarIluminacion(filosofo2.nivelDeIluminacion() * 0.1)
    }    
}
object admirarPaisaje{
    method hacer(filosfo){}
}

class MeditarBakjoUnaCascada{
    const metros
    method hacer(filosofo) {
        filosofo.aumentarIluminacion(10*metros)
    } 
}
class PracticarDeporte{
    const tipo

    method hacer(filosofo){
        filosofo.rejuvenecer(tipo.hacerDeporte(filosofo))
    }
}

object futbol{
    method hacerDeporte(filosofo)=1
}
object polo{
    method hacerDeporte(filosofo)=2
}

object waterpolo{
    method hacerDeporte(filosofo)=polo.hacerDeporte(filosofo) *2
}



class Argumento{
    const descripcion
    const naturaleza

    method esEnriquecedor() = naturaleza.esEnriquecedor(self)
    method descripcion()=descripcion
}
object estoica{
    method esEnriquecedor(argumento)=true
}
object moralista{
    method esEnriquecedor(argumento)= argumento.descripcion().words().size() >=10
}
object esceptica{
    method esEnriquecedor(argumento)= argumento.descripcion().last()=="?"
}

object cinica{
    method esEnriquecedor(argumento) = 1.randomUpTo(100) <= 30
}
class ArgumentoMixto {
    const descripcion
    const naturalezas

    method esEnriquecedor() = naturalezas.all({naturaleza=> naturaleza.esEnriquecedor(self)})

}
class Partido{
    const filosofo
    const argumentos

    method agregarArgumento(argumento){
        argumentos.add(argumento)
    }
    method argumentos()=argumentos
    
    
}
class Discusion{
    
    const partido1
    const partido2

    method discusionBuena() = self.argumentosTotal().count({argumento => argumento.esEnriquecedor()}) >= self.argumentosTotal().size()/2
    method argumentosTotal() = partido1.argumentos() + partido2.argumentos()
}