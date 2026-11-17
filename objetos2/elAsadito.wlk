class Persona {
    var posicion
    const elementosCerca = []
    var criterio

    method pedirCosa(persona, cosa) {
        persona.validarTieneElemento(cosa)
        criterio.buscarElemento(self, persona, cosa)
    }

    method elementosCerca() = elementosCerca
    method posicion() = posicion

    method cambiarCriterio(nuevoCriterio) {
        criterio = nuevoCriterio
    }

    method validarTieneElemento(elemento) {
        if (not elementosCerca.contains(elemento)) {
            throw new DomainException(message = "No tiene la cosa")
        }
    }

    method recibirElemento(elemento) {
        elementosCerca.add(elemento)
    }

    method entregarElementoA(elemento, persona) {
        self.validarTieneElemento(elemento)
        elementosCerca.remove(elemento)
        persona.recibirElemento(elemento)
        elemento
    }

    method entregarTodosA(persona) {
        elementosCerca.asSet().forEach({ elemento =>
            self.entregarElementoA(elemento, persona)
        })
    }

    method cambiarPosicion(persona) {
        const posicionNueva = persona.posicion()
        persona.modificarPosicion(posicion)
        posicion = posicionNueva
    }

    method modificarPosicion(posicionNueva) {
        posicion = posicionNueva
    }
}

object sordo {
    method buscarElemento(solicitante, destinatario, cosa) {
        const elemento = destinatario.elementosCerca().head()
        destinatario.entregarElementoA(elemento, solicitante)
    }
}

object quedarseTranquilo {
    method buscarElemento(solicitante, destinatario, cosa) {
        destinatario.entregarTodosA(solicitante)
    }
}

object charlarConOtros {
    method buscarElemento(solicitante, destinatario, cosa) {
        solicitante.cambiarPosicion(destinatario)
    }
}

object pasarBenditaCosa {
    method buscarElemento(solicitante, destinatario, cosa) {
        destinatario.entregarElementoA(cosa, solicitante)
    }
}
