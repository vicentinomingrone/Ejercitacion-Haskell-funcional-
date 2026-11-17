object juanPerez {
    method invitar(empleado) = empleado.estaInvitado()

    method listaDeInvitados() =
        empresa.personalTotal().filter({ empleado => self.invitar(empleado) })
}

object fiesta {
    const personasQueIngresaron = []
    const costoSalon = 200000
    const costoXPersona = 5000

    method permitirIngreso(empleado) {
        if (not juanPerez.listaDeInvitados().contains(empleado)) {
            throw new DomainException(message = "El empleado no esta invitado")
        }
        if (personasQueIngresaron.any({ registro => registro.invitado() == empleado })) {
            throw new DomainException(message = "El empleado ya ingreso")
        }

        const registro = new RegistroDeAsistencia(
            nombreInvitado = empleado,
            mesaAsignada = empleado.mesa(),
            importeRegalo = empleado.regalar()
        )
        personasQueIngresaron.add(registro)
    }

    method calcularBalance() =
        personasQueIngresaron.sum({ registro => registro.importeRegalo() }) -
            costoSalon - personasQueIngresaron.size() * costoXPersona

    method fueUnExito() =
        self.calcularBalance() > 0 and
            juanPerez.listaDeInvitados().all({ persona =>
                personasQueIngresaron.any({ registro => registro.invitado() == persona })
            })

    method mesaMasAsistida() {
        if (personasQueIngresaron.isEmpty()) {
            throw new DomainException(message = "Todavia no ingreso ningun invitado")
        }

        const mesas = personasQueIngresaron.map({ registro => registro.mesaAsignada() })
        return mesas.max({ mesa => mesas.count({ otraMesa => otraMesa == mesa }) })
    }

    method personasQueIngresaron() = personasQueIngresaron
}

class RegistroDeAsistencia {
    const nombreInvitado
    const mesaAsignada
    const importeRegalo

    method nombreInvitado() = nombreInvitado
    method invitado() = nombreInvitado
    method mesaAsignada() = mesaAsignada
    method importeRegalo() = importeRegalo
}

class Empleado {
    var experiencia
    const lenguajes

    method lenguajes() = lenguajes
    method estaInvitado() = self.recibirInvitacion()
    method recibirInvitacion() = self.esCopado()
    method esCopado() = false

    method conoceLenguajeAntiguo() =
        lenguajes.any({ lenguaje => lenguaje.esAntiguo() })

    method lenguajesModernos() =
        lenguajes.filter({ lenguaje => not lenguaje.esAntiguo() })

    method aprenderLenguaje(lenguaje) {
        if (not lenguajes.any({ conocido => conocido.nombre() == lenguaje.nombre() })) {
            lenguajes.add(lenguaje)
        }
    }

    method mesa() = self.lenguajesModernos().size()
    method regalar() = 1000 * self.lenguajesModernos().size()
}

class Desarrolladores inherits Empleado {
    override method recibirInvitacion() =
        lenguajes.any({ lenguaje => lenguaje.nombre() == "Wollok" }) or
            self.conoceLenguajeAntiguo() or self.esCopado()

    override method esCopado() =
        self.conoceLenguajeAntiguo() and not self.lenguajesModernos().isEmpty()
}

class Infraestructura inherits Empleado {
    override method recibirInvitacion() =
        lenguajes.size() >= 5 or self.esCopado()

    override method esCopado() = experiencia > 10
}

class Jefe inherits Empleado {
    const empleadosACargo = []

    method empleadosACargo() = empleadosACargo

    method agregarEmpleado(empleado) {
        if (not empleadosACargo.contains(empleado)) {
            empleadosACargo.add(empleado)
        }
    }

    method tomarACargo(empleado) {self.agregarEmpleado(empleado)}

    override method recibirInvitacion() =
        (self.conoceLenguajeAntiguo() and
            empleadosACargo.all({ empleado => empleado.esCopado() })) or self.esCopado()

    override method mesa() = 99
    override method regalar() = super() + 1000 * empleadosACargo.size()
}

object empresa {
    const desarrolladores = []
    const infraestructura = []
    const jefes = []

    method desarrolladores() = desarrolladores
    method infraestructura() = infraestructura
    method jefes() = jefes

    method agregarDesarrollador(empleado) {
        desarrolladores.add(empleado)
    }

    method agregarEmpleadoDeInfraestructura(empleado) {
        infraestructura.add(empleado)
    }

    method agregarJefe(jefe) {
        jefes.add(jefe)
    }

    method personalTotal() = desarrolladores + infraestructura + jefes
}

class Lenguaje {
    const nombre
    const esAntiguo

    method nombre() = nombre
    method esAntiguo() = esAntiguo
}
