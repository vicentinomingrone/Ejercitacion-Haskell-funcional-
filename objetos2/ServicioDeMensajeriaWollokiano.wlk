class Mensaje{
    const usuario
    var tipoDeContenido = Texto
    

    method pesoMensaje()= 5 + tipoDeContenido.peso() * 1.3

}

class Contacto{
    const username
    method peso() = 3
}

class Texto{
    const elTexto
    method cantidadDeCaracteres() = elTexto.size()
    method peso()=1 * self.cantidadDeCaracteres()
}
class Audio{
    var duracion
    method peso()= 1.2 * duracion
}

class Imagen{
    const alto
    const ancho
    var modoDeCompresion
    method alto()=alto
    method ancho() = ancho
    method peso()= modoDeCompresion.peso(self)*2
    method pixeles() = alto * ancho
}

class Gif inherits Imagen{
    const cantidadDeCuadros
    override method peso()= super() * cantidadDeCuadros
}
object compresionOriginal{
    method peso(imagen) = imagen.pixeles()
}

class CompresionVariable{
    const porcentajeDeCompresion
    method peso(imagen) = (porcentajeDeCompresion * imagen.pixeles())/100
}

object compresionMaxima{
    method peso(imagen) {
        const pesoTotal = imagen.pixeles()
        if(pesoTotal > 10000)
        {
            return 10000
        }
        return pesoTotal
    }
}
class Notificacion{
    const chat
    var leida = false

    method leer()
    {
        leida=true
    }
}

class Chat{  
    const participantes=[]
    var mensajesChat= []
    method enviarMensaje(mensaje)
    {
        self.validarMensaje(mensaje)
        mensajesChat.add(mensaje)
        self.notificar()
    }
    method notificar(){
        participantes.forEach({usuario => usuario.recibirNotificacion(new Notificacion(chat=self))})
    }
    method espacioDisponible() = mensajesChat.sum({mensaje => mensaje.peso()})
    method agregarParticipante(usuario) = participantes.add(usuario)
    method eliminarParticipante(usuario) = participantes.remove(usuario)
    method validarMensaje(mensaje)= participantes.contains(mensaje.usuario()) and mensaje.peso()<=self.espacioDisponible()
    method contieneTexto(texto) = mensajesChat.any(texto)
}

class ChatPremium inherits Chat{
    var restriccionAdicional
    const creador
    override method enviarMensaje(mensaje) {
        if (restriccionAdicional.validarMensaje(self))
        {
            mensajesChat.add(mensaje)
        }
}
}
class Difusion {
    
    method validarMensaje(chat)
    {

    }
}
class Restringido{
    var limiteMensajes
    method validarMensaje(chat)
}

class Usuario{
const nombre
var memoria
const mensajes=[]
const chats=[]
const notificaciones=[]

method tieneEspacionSuficiente(mensaje) = mensaje.peso() + self.espacioOcupado() <= memoria
method recibirNotificion(notificacion)
{
    notificaciones.add(notificacion)
}
method leer(chat) {
		notificaciones.filter({notificacion => notificacion.chat() == chat}).forEach({notificacion => notificacion.leer()})
	}
method notificacionesSinLeer()= notificaciones.filter({n => not n.leida()})
method espacioOcupado() = mensajes.sum({mensaje => mensaje.peso()})
method agregarChat(chat)= chats.add(chat)
method buscarMensaje(mensaje) = chats.filter({chat => chat.contieneTexto(mensaje)})
method contieneTexto(texto)=nombre.contains(texto)
}