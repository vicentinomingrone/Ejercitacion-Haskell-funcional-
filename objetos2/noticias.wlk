class Noticia{
    const fechaDePublicacion
    const autor
    const gradoDeImportancia
    const titulo
    var desarrollo
    method esCopada()
    method cumpleRequisitosBasicos() {
    const diasDesdePublicacion = new Date() - fechaDePublicacion
    return gradoDeImportancia >= 8 and
        diasDesdePublicacion >= 0 and
        diasDesdePublicacion < 3
        
}
    method esSensacionalista()= self.cumplirConTituloSencionalista() 
    method cumplirConTituloSencionalista()= titulo.contains("espectacular") || titulo.contains("increíble") || titulo.contains("grandioso")
    method esChivo()=false
    method desarrollo()=desarrollo
    method autor()=autor
    method fechaDePublicacion()=fechaDePublicacion
    method estaBienEscrita()=titulo.words().size()>=2 and desarrollo.size()>0
    method titulo()=titulo
    method fechaHoy()= new Date()
    method esDeLaSemana()= self.fechaHoy()-fechaDePublicacion<=7
}
class Chivo inherits Noticia{
    const producto
    const pago

    method pago()=pago
    override method esCopada()= pago>2000000 and self.cumpleRequisitosBasicos()
    override method esChivo()=true

}
class ArticuloComun inherits Noticia{
    const linksANoticias=[]
    override method esCopada()= linksANoticias.size()>=2 and self.cumpleRequisitosBasicos()
}
class Reportaje inherits Noticia{
    const entrevistado
    override method esCopada()= entrevistado.size()%2 == 1 and self.cumpleRequisitosBasicos()
    override method esSensacionalista() = super() and entrevistado=="Dibu Martinez"
}

class Cobertura inherits Noticia{
    const noticiasRelacionadas=[]
    override method esCopada()= noticiasRelacionadas.all({noticia => noticia.esCopada()}) and self.cumpleRequisitosBasicos()
}

class Periodistas{
    var fechaDeIngreso
    const preferencia
    const noticiasPublicadas=[]
    var cantidadDeNoticiasQueNoLeGustan = 0
    var fechaActual= new Date()

    method esReciente() {
        const hoy = new Date()
        return fechaDeIngreso >= hoy.minusYears(1) and fechaDeIngreso <= hoy
    }
      
    method leGustaNoticia(noticia)=preferencia.leGustaNoticia(noticia) 
    method fechaHoy()= new Date()
    method reiniciarContadorSiCambioElDia() {
    if (fechaActual != self.fechaHoy()) {
        fechaActual = self.fechaHoy()
        cantidadDeNoticiasQueNoLeGustan = 0
    }
}
    method publicarNoticia(noticia) {
        self.reiniciarContadorSiCambioElDia()
        if((not self.leGustaNoticia(noticia) and cantidadDeNoticiasQueNoLeGustan>=2) || not noticia.estaBienEscrita())
        {
            throw new DomainException(message="supero el limite diario de noticias que no le gustan o esta mal escrita")
        }
        if(not self.leGustaNoticia(noticia) and cantidadDeNoticiasQueNoLeGustan<2)
        {
            noticiasPublicadas.add(noticia)
            cantidadDeNoticiasQueNoLeGustan+=1
        }
        else{
            noticiasPublicadas.add(noticia)
        }
    }
    method publicoEnLaUltimaSemana()= noticiasPublicadas.any({noticia => noticia.esDeLaSemana()})
    
}

object noticiasCopadas{
    method leGustaNoticia(noticia)=noticia.esCopada() 
    
}
object noticiasSensacionalistas{
    method leGustaNoticia(noticia)= noticia.esSensacionalista()
    
}
object vago{
    method leGustaNoticia(noticia)= noticia.esChivo() || noticia.desarrollo().size()<100
}
object tituloConT{
    method leGustaNoticia(noticia)= noticia.autor() == "José De Zer" and noticia.titulo().startsWith("T")
}

object multimedio{
    const periodistas=[]

    method periodistasRecientesQuePublicaron(){
        const listaRecientes= periodistas.filter({periodista => periodista.esReciente()})
        return listaRecientes.filter({periodista => periodista.publicoEnLaUltimaSemana()})
    }

    method sumarPeriodistasAlMedio(periodista){
        periodistas.add(periodista)  
    }
}