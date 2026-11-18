class Empleado {
    var salud
    const habilidades = []
    var rol
    const subordinados = []

    method saludCritica() =
        rol.saludCritica()

    method estaIncapacitado() =
        salud < self.saludCritica()

    method sobrevive() =
        salud > 0

    method tieneHabilidadPropia(habilidad) =
        habilidades.contains(habilidad)

    method puedeUsar(habilidad) =
        !self.estaIncapacitado() &&
        (
            self.tieneHabilidadPropia(habilidad) ||
            subordinados.any({
                subordinado => subordinado.puedeUsar(habilidad)
            })
        )

    method puedeCumplir(mision) =
        mision.habilidades().all({
            habilidad => self.puedeUsar(habilidad)
        })

    method agregarHabilidad(habilidad) {
        if(!self.tieneHabilidadPropia(habilidad)) {
            habilidades.add(habilidad)
        }
    }

    method agregarSubordinado(empleado) {
        subordinados.add(empleado)
    }

    method cambiarRol(nuevoRol) {
        rol = nuevoRol
    }

    method recibirDanio(cantidad) {
        salud -= cantidad
    }

    method registrarMision(mision) {
        rol.completarMision(self, mision)
    }

    method cumplirMision(mision) {
        if(!self.puedeCumplir(mision)) {
            throw new DomainException(
                message = "No posee las habilidades necesarias"
            )
        }

        self.recibirDanio(mision.peligrosidad())

        if(self.sobrevive()) {
            self.registrarMision(mision)
        }
    }
}

class Oficinista {
    var estrellas = 0

    method saludCritica() =
        40 - 5 * estrellas

    method completarMision(empleado, mision) {
        estrellas += 1

        if(estrellas == 3) {
            empleado.cambiarRol(espia)
        }
    }
}

object espia {

    method saludCritica() = 15

    method completarMision(empleado, mision) {
        const nuevas =
            mision.habilidades().filter({
                habilidad =>
                    !empleado.tieneHabilidadPropia(habilidad)
            })

        nuevas.forEach({
            habilidad =>
                empleado.agregarHabilidad(habilidad)
        })
    }
}

class Mision {
    const habilidades = #{}
    const peligrosidad

    method habilidades() = habilidades
    method peligrosidad() = peligrosidad
}