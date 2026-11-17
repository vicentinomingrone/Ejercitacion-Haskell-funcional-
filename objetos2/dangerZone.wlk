object isis {
    const empleados = []
}

class Empleado {
    var tipo = new Oficinista()
    var salud
    const habilidades = []
    const empleadosInferiores = []
    const misionesCompletadas = []

    method misionesCompletadas() = misionesCompletadas
    method salud() = salud
    method habilidades() = habilidades
    method tipo() = tipo
    method cambiarTipo(nuevoTipo) {
        tipo = nuevoTipo
    }

    method saludCritica() = tipo.saludCritica()
    method incapacitado() = salud < self.saludCritica()
    method esJefe() = empleadosInferiores.size() != 0

    method puedeUsarHabilidad(habilidad) =
        (not self.incapacitado()) and
            (habilidades.contains(habilidad) or
                empleadosInferiores.any({ empleado =>
                    empleado.puedeUsarHabilidad(habilidad)
                }))

    method reducirSalud(cantidad) {
        salud -= cantidad
    }

    method puedeCumplirMision(mision) =
        mision.habilidadesRequeridas().all({ habilidad =>
            self.puedeUsarHabilidad(habilidad)
        })

    method aplicarDanio(mision) {
        self.reducirSalud(mision.peligrosidad())
    }

    method agregarComoMisionCompletada(mision) {
        if (salud > 0) {
            misionesCompletadas.add(mision)
            tipo.recibirRecompensa(self, mision)
        }
    }
}

class Espia {
    method saludCritica() = 15

    method recibirRecompensa(empleado, mision) {
        const habilidadesFaltantes = mision.habilidadesRequeridas().filter({ habilidad =>
            not empleado.habilidades().contains(habilidad)
        })
        habilidadesFaltantes.forEach({ habilidad =>
            empleado.habilidades().add(habilidad)
        })
    }
}

class Oficinista {
    var estrellas = 0

    method saludCritica() = 40 - 5 * estrellas

    method recibirRecompensa(empleado, mision) {
        estrellas += 1
        if (estrellas == 3) {
            empleado.cambiarTipo(new Espia())
        }
    }
}

class Equipos {
    const empleados = []

    method aplicarDanio(mision) {
        empleados.forEach({ empleado =>
            empleado.reducirSalud(mision.peligrosidad() / 3)
        })
    }

    method alguienPuedeUsar(habilidad) =
        empleados.any({ empleado =>
            empleado.puedeUsarHabilidad(habilidad)
        })

    method puedeCumplirMision(mision) =
        mision.habilidadesRequeridas().all({ habilidad =>
            self.alguienPuedeUsar(habilidad)
        })

    method agregarComoMisionCompletada(mision) {
        empleados
            .filter({ empleado => empleado.salud() > 0 })
            .forEach({ empleado =>
                empleado.agregarComoMisionCompletada(mision)
            })
    }
}

class Mision {
    const habilidadesRequeridas
    const peligrosidad

    method habilidadesRequeridas() = habilidadesRequeridas
    method peligrosidad() = peligrosidad

    method completarMision(desafiante) {
        if (desafiante.puedeCumplirMision(self)) {
            desafiante.aplicarDanio(self)
            desafiante.agregarComoMisionCompletada(self)
        }
    }
}
