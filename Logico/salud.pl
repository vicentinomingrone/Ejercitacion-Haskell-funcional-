% paciente(Nombre, Edad, ObraSocial).
paciente(ana, 25, osde).
paciente(beto, 72, pami).
paciente(carla, 40, swissMedical).
paciente(diego, 16, ninguna).
paciente(elena, 83, pami).
paciente(franco, 33, osde).
paciente(gina, 10, ninguna).
paciente(hector, 55, galeno).

% estudio(Codigo, TipoEstudio, Complejidad).
estudio(e001, radiografia, baja).
estudio(e002, ecografia, baja).
estudio(e003, tomografia, media).
estudio(e004, resonancia, alta).
estudio(e005, laboratorio, baja).
estudio(e006, cardiologico, media).
estudio(e007, neurologico, alta).

% turno(Paciente, CodigoEstudio, Dia).
turno(ana, e003, lunes).
turno(beto, e006, martes).
turno(carla, e004, miercoles).
turno(diego, e001, lunes).
turno(elena, e007, jueves).
turno(franco, e002, viernes).
turno(franco, e005, viernes).
turno(gina, e001, martes).
turno(hector, e006, lunes).

% diagnostico(Paciente, Problema, Gravedad).
diagnostico(ana, dolorPecho, media).
diagnostico(beto, arritmia, grave).
diagnostico(carla, lesionColumna, grave).
diagnostico(diego, fractura, media).
diagnostico(elena, acv, grave).
diagnostico(franco, controlGeneral, leve).
diagnostico(gina, fiebre, leve).
diagnostico(hector, hipertension, media).

% costoBase(Problema, Costo).
costoBase(dolorPecho, 90000).
costoBase(arritmia, 200000).
costoBase(lesionColumna, 300000).
costoBase(fractura, 150000).
costoBase(acv, 350000).
costoBase(controlGeneral, 40000).
costoBase(fiebre, 30000).
costoBase(hipertension, 100000).

% medico(Nombre, Especialidad, Experiencia).
medico(romero, clinica, 12).
medico(suarez, cardiologia, 18).
medico(molina, pediatria, 7).
medico(arias, traumatologia, 4).
medico(lopez, neurologia, 10).
medico(perez, clinica, 3).
medico(farias, diagnosticoImagenes, 15).


/*
Parte A — Consultas en consola

Escribí las consultas que harías en Prolog e indicá sus respuestas.

¿Existe algún paciente con obra social pami?
paciente(_, _, pami).
true.
¿Qué edad tiene elena?
paciente(elena, Edad, _).
Edad = 83.
¿Qué estudios tiene asignados franco?
diagnostico(franco, Estudio, _).
Estudio = controlGeneral. 
¿Qué especialidad tiene lopez?
medico(lopez, Especialidad , _).
Especialidad = neurologia. 

Parte B — Paciente prioritario

Queremos saber si un paciente es prioritario.

Un paciente es prioritario cuando:

tiene un diagnóstico grave;
o tiene más de 75 años;
o no tiene obra social;
o tiene más de un turno asignado.

Se nos dio esta implementación:

pacientePrioritario(Paciente):-
    diagnostico(Paciente, _, grave).

pacientePrioritario(Paciente):-
    paciente(Paciente, Edad, _),
    Edad > 75.

pacientePrioritario(Paciente):-
    paciente(Paciente, _, ninguna).

pacientePrioritario(Paciente):-
    turno(Paciente, _, _).

Responder:

¿El código resuelve correctamente el problema planteado? Falso. 
En la ultima regla, solo hace falta que tenga un turno y la consigan pide al menos 2
¿El predicado pacientePrioritario/1 es inversible? Veradero. 
es inversible porque liga con nuestra base pero no es cerrada. 
¿Qué problema aparece con la cuarta regla?
el problema que aparece es que no verifica que tenga 2 turnos, que es lo que pide la consigna, 
Codificar una solución mejor.
Creo que hice una mejor, con inversibilidad cerrada y solucionando el tema de la ultima. 

*/

pacientePrioritario(Paciente):-
    paciente(Paciente, _, _),
    diagnostico(Paciente, _, grave).

pacientePrioritario(Paciente):-
    paciente(Paciente, Edad, _),
    Edad > 75.

pacientePrioritario(Paciente):-
    paciente(Paciente, _, ninguna).  

pacientePrioritario(Paciente):-
    paciente(Paciente, _, _), 
    turno(Paciente, Turno, _),
    turno(Paciente, OtroTurno, _),
    Turno \= OtroTurno. 

/*
Parte C — Costo de atención

El costo final de atención depende de la gravedad del diagnóstico:

leve: costo base.
media: costo base + 45%.
grave: costo base + 100%.

Responder también:

¿Dónde usaste is y por qué?
¿Dónde usaste findall y por qué?
¿Para qué sirve sum_list?

todo esto ya lo respondi en el parcial anterior, si queres tirame nuevas preguntas en el proximo y te 
las respondo. 
*/

costoDeAtencion(Paciente, Problema, CostoFinal):-
        paciente(Paciente, _, _),
        diagnostico(Paciente, Problema, Gravedad),
        costoBase(Problema, CostoBase), 
        segunGravedad(Gravedad, Multiplicador),
        CostoFinal is CostoBase * Multiplicador. 


segunGravedad(leve, 1).
segunGravedad(media, 1.45).
segunGravedad(grave, 2).


costoTotal(Paciente, Total):-
    paciente(Paciente, _, _),
    findall(
        CostoFinal, 
        costoDeAtencion(Paciente, _, CostoFinal),
        CostosTotalesPaciente
        ),
        sum_list(CostosTotalesPaciente, Total). 

% especialidadNecesaria(Problema, Especialidad).
especialidadNecesaria(dolorPecho, cardiologia).
especialidadNecesaria(arritmia, cardiologia).
especialidadNecesaria(lesionColumna, traumatologia).
especialidadNecesaria(fractura, traumatologia).
especialidadNecesaria(acv, neurologia).
especialidadNecesaria(controlGeneral, clinica).
especialidadNecesaria(fiebre, pediatria).
especialidadNecesaria(hipertension, clinica).

/*

Parte D — Médico recomendado

Para saber qué médico conviene asignar a un paciente,
se conoce qué especialidad se necesita según el problema:
El paciente existe.
El paciente tiene un diagnóstico.
La especialidad del médico coincide con la especialidad necesaria para ese problema.
El médico tiene más de 5 años de experiencia.

¿El predicado es inversible?
Si porque lo ligo con paciente(Paciente, _, _)
¿Por qué no hace falta usar findall?
porqu no es necesario una lista. 
¿Qué consulta harías para saber qué médicos pueden atender a beto?

medicoRecomenado(beto, Medico).
Medico = 
*/

medicoRecomenado(Paciente, Medico):-
    paciente(Paciente, _, _),
    diagnostico(Paciente, Problema, _),
    especialidadNecesaria(Problema, Especialidad),
    medico(Medico, Especialidad, Experiencia),
    Experiencia > 5. 


/*
La clínica quiere armar un plan de atención semanal compuesto por exactamente 3 pacientes.

Un plan válido cumple:

Tiene exactamente 3 pacientes.
Todos los pacientes existen.
Ningún paciente está repetido.
Tiene al menos un paciente prioritario.
Tiene al menos un paciente con estudio de complejidad alta.
No incluye pacientes sin obra social.
La suma de los costos totales de atención de esos pacientes no supera 900000.
*/

planAtencion(Plan):-
    findall(Paciente, paciente(Paciente, _, _), Pacientes),
    planPosible(Pacientes, Plan),
    planValido(Plan).


planPosible([], []).

planPosible([Paciente | Resto], [Paciente | Plan]):-
    planPosible(Resto, Plan). 
    
planPosible([_| Resto],  Plan):-
    planPosible(Resto, Plan). 

planValido(Plan):-
    length(Plan, 3),
    todosExisten(Plan),
    tienePrioritarios(Plan),
    tieneConComplejidadAlta(Plan),
    ningunoSinObraSocial(Plan), 
    losCostosNoSuperan(Plan, 900000).

todosExisten(Plan):-
    forall(
        member(Paciente, Plan),
        paciente(Pcaciente, _, _)
        ).

tienePrioritarios(Plan):-
    member(Paciente, Plan),
    pacientePrioritario(Paciente). 


tieneConComplejidadAlta(Plan):-
    member(Paciente, Plan),
    turno(Paciente, Turno, _),
    estudio(Turno, _, alta).

ningunoSinObraSocial(Plan):-
    member(Paciente, Plan),
    sinObraSocial(Paciente). 

sinObraSocial(Paciente):-
    paciente(Paciente, _, ninguna).  

losCostosNoSuperan(Plan, Cantidad):-
    findall(
        Total, 
        (member(Paciente, Plan),
        costoTotal(Paciente, Total)),
        Totales
        ), 
        sum_list(Totales, TotalDePaciente),
        TotalDePaciente =< Cantidad. 
