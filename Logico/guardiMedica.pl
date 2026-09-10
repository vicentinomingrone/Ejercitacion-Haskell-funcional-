% paciente(Nombre, Edad, ObraSocial).
paciente(ana, 25, osde).
paciente(beto, 70, pami).
paciente(carla, 40, swissMedical).
paciente(diego, 15, ninguna).
paciente(elena, 82, pami).
paciente(franco, 33, osde).
paciente(gina, 10, ninguna).

% medico(Nombre, Especialidad, Experiencia).
medico(romero, clinica, 12).
medico(suarez, cardiologia, 18).
medico(molina, pediatria, 7).
medico(arias, traumatologia, 4).
medico(lopez, neurologia, 10).
medico(perez, clinica, 3).

% diagnostico(Paciente, Problema, Gravedad).
diagnostico(ana, fiebre, leve).
diagnostico(ana, dolorPecho, media).
diagnostico(beto, arritmia, grave).
diagnostico(carla, fractura, media).
diagnostico(diego, fiebre, media).
diagnostico(elena, acv, grave).
diagnostico(franco, golpe, leve).
diagnostico(franco, fractura, grave).

% costoBase(Problema, Costo).
costoBase(fiebre, 30000).
costoBase(dolorPecho, 90000).
costoBase(arritmia, 200000).
costoBase(fractura, 150000).
costoBase(acv, 350000).
costoBase(golpe, 40000).

% estudioRealizado(Paciente, Estudio).
estudioRealizado(ana, electrocardiograma).
estudioRealizado(beto, electrocardiograma).
estudioRealizado(carla, radiografia).
estudioRealizado(elena, tomografia).
estudioRealizado(franco, radiografia).


/* Parte A

1- paciente(_, _, pami).
true. 
2- paciente(_, Edad, elena). 
Edad= 82.
3- diagnostico(Quien, fractura, _).
Quien= franco. 
4- medico(lopez, Especialidad, _).
Especialidad= neurologia. 

Parte B

1- El codigo resuelve el problema de perfecta manera. 
2- Es inversible pero hay que tener cuidado por que no se liga con todos los pacientes de nuestra base de conocimiento
3- No veo ninguna repeticion de logica, aunque quizas se podria desglozar alguna que otra parte. 
4- lo hice aca abajo. 
*/


pacienteUrgente(Paciente):-
    paciente(Paciente, _, _),
    diagnostico(Paciente, _, grave).

pacienteUrgente(Paciente):-
    paciente(Paciente, Edad, _),
    Edad > 75.

pacienteUrgente(Paciente):-
    noTieneObraSocial(Paciente).


noTieneObraSocial(Paciente):-
    paciente(Paciente, _, ninguna). 


% Parte C 


costoAtencion(Paciente, Problema, CostoFinal):-
    paciente(Paciente, _, _),
    diagnostico(Paciente, Problema, Gravedad),
    costoBase(Problema, Costo),
    dependeGravedad(Garvedad, Multiplicador),
    CostoFinal is Costo * Multiplicador. 


dependeGravedad(leve, 1).
dependeGravedad(media, 1.40).
dependeGravedad(grave, 2).


costoTotalPaciente(Paciente, Total):-
    paciente(Paciente, _, _),
    findall(
        CostoFinal, 
        costoAtencion(Paciente, _, CostoFinal),
        ListaCostosFinales
    ), 
    sum_list(ListaCostosFinales, Cantidad),
    Total = Cantidad.

% Parte D 

% especialidadNecesaria(Problema, Especialidad).
especialidadNecesaria(fiebre, clinica).
especialidadNecesaria(dolorPecho, cardiologia).
especialidadNecesaria(arritmia, cardiologia).
especialidadNecesaria(fractura, traumatologia).
especialidadNecesaria(golpe, traumatologia).
especialidadNecesaria(acv, neurologia).


medicoRecomendado(Medico, Paciente):-
    diagnostico(Paciente, Problema, _),
    medico(Medico, Especialidad, Experiencia),
    especialidadNecesaria(Problema, Especialidad),
    Experiencia > 5. 