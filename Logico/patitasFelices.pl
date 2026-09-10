% mascota(Nombre, Especie, Edad, Duenio).
mascota(firulais, perro, 5, vicentino).
mascota(michi, gato, 3, martina).
mascota(lola, perro, 12, lucas).
mascota(tito, conejo, 2, sofia).
mascota(nina, gato, 10, tomas).
mascota(rocky, perro, 8, camila).
mascota(coco, loro, 4, juan).

% veterinario(Nombre, Especialidad, Experiencia).
veterinario(ana, clinicaGeneral, 10).
veterinario(raul, cirugia, 15).
veterinario(marcos, dermatologia, 6).
veterinario(sofia, odontologia, 4).
veterinario(lucia, exoticos, 8).
veterinario(pedro, cardiologia, 20).

% diagnostico(Mascota, Problema, Gravedad).
diagnostico(firulais, piel, media).
diagnostico(firulais, dental, leve).
diagnostico(michi, respiratorio, grave).
diagnostico(lola, cardiaco, grave).
diagnostico(tito, exotico, media).
diagnostico(nina, dental, grave).
diagnostico(rocky, piel, leve).
diagnostico(rocky, cardiaco, media).

% costoBase(Problema, Costo).
costoBase(piel, 50000).
costoBase(dental, 70000).
costoBase(respiratorio, 120000).
costoBase(cardiaco, 200000).
costoBase(exotico, 90000).

% vacunaAplicada(Mascota, Vacuna).
vacunaAplicada(firulais, antirrabica).
vacunaAplicada(firulais, quintuple).
vacunaAplicada(michi, antirrabica).
vacunaAplicada(lola, quintuple).
vacunaAplicada(rocky, antirrabica).

/*
Parte A. 
1- mascota(_, perro, _, _).
true
2- mascota(michi, _, _, Quien).
Quien = michi. 
3- diagnostico(Mascota, dental, _).
Mascota = firulais;
Mascota = nina. 
4- veterinario(pedro, Cual, _).
Cual= cardiologia. 

Parte B. 
mascotaDelicada(Mascota):-
    diagnostico(Mascota, _, grave).

mascotaDelicada(Mascota):-
    mascota(Mascota, _, Edad, _),
    Edad > 10.

1- El codigo si resuelve el problema planteado pero tiene un error de inversibilidad.
2- No por completo, la primera regla liga directamente como que la mascota tiene un diagnostico, pero quizas haya mascotas que recien nacen y todavia 
no tengan diagnostico y sean delicadas
3- quizas tiene un poco de repeticion de logica lo prodriamos delegar mas que nada la parte de la edad. 

*/

mascotaDelicda(Mascota):-
    mascota(Mascota, _, _, _),
    diagnostico(Mascota, _, grave). 

mascotaDelicada(Mascota):-
    mascotaVieja(Mascota). 
    
mascotaVieja(Mascota):-   
    mascota(Mascota, _, Edad, _),
    Edad > 10.

% mascotaVieja(Mascota, Edad):-   
%   mascota(Mascota, _, _, _),
%   Edad > 10. 


% Parte C 


/*
mi primera solucion hubiera sido esta: 

costoTratamiento(Mascota, Problema, TotalPagar):-
    mascota(Mascota, _, _, _),
    diagnostico(Mascota, Problema, leve), 
    costoBase(Problema, Costo),
    TotalPagar is Costo . 

costoTratamiento(Mascota, Problema, TotalPagar):-
    mascota(Mascota, _, _, _),
    diagnostico(Mascota, Problema, media), 
    costoBase(Problema, Costo),
    TotalPagar is Costo * 1.30 . 

costoTratamiento(Mascota, Problema, TotalPagar):-
    mascota(Mascota, _, _, _),
    diagnostico(Mascota, Problema, grave), 
    costoBase(Problema, Costo),
    TotalPagar is Costo * 1.80. 

pero le pude hacer modificaciones y quedo como esta abajo: 
*/

costoTratamiento(Mascota, Problema, TotalPagar):-
    mascota(Mascota, _, _, _),
    diagnostico(Mascota, Problema, Gravedad), 
    costoBase(Problema, Costo),
    pagarAcuerdoGravedad(Gravedad, Multiplicador),
    TotalPagar is Costo * Multiplicador. 

pagarAcuerdoGravedad(leve, 1).
pagarAcuerdoGravedad(media, 1.30).
pagarAcuerdoGravedad(garve, 1.80).

% especialidadNecesaria(Problema, Especialidad).
especialidadNecesaria(piel, dermatologia).
especialidadNecesaria(dental, odontologia).
especialidadNecesaria(respiratorio, clinicaGeneral).
especialidadNecesaria(cardiaco, cardiologia).
especialidadNecesaria(exotico, exoticos).

veterinarioRecomendado(Veterinario, Mascota):-
    veterinario(Veterinario, Especialidad, Experiencia),
    diagnostico(Mascota, Problema, _),
    especialidadNecesaria(Problema, Especialidad),
    Experiencia > 5.

 /*1- veterinarioRecomendado(Veterinario, Mascota). Este predicado es inversible dado a que ambas cosas se pueden ligar con nustra base de concoimiento, como hice arriba.
2- NO hace falta usar Findall porque no tenemos que verificar con una lista de veterinarios, le tenemos que pasar solo el veterinario y la mascota
3- la cosulta que haria en ese caso particular seria: veterinarioRecomendado(Cual, rocky). 

Parte E 

*/


planInternacion(Plan):-
    findall(Mascota, mascota(Mascota, _, _, _), Mascotas),
    planPosible(Mascotas, Plan),
    planValido(Plan).

planPosible([], []).

planPosible([Mascota | Resto], [Mascota | Plan]):-
    planPosible(Resto, Plan).

planPosible([_ | Resto], Plan):-
    planPosible(Resto, Plan).

planValido(Plan):- 
    length(Plan, 3),
    todasExisten(Plan),
    tienePerro(Plan), 
    tieneDiagnosticoGrave(Plan), 
    noSuperanSeiscientosMil(Plan).

todasExisten(Plan):-
    forall(
        member(Mascota, Plan),
        mascota(Mascota, _, _, _)
    ).

tienePerro(Plan):-
    member(Mascota, Plan),
    mascota(Mascota, perro, _, _).

tieneDiagnosticoGrave(Plan):-
    member(Mascota, Plan), 
    diagnostico(Mascota, _, grave).

noSuperanSeiscientosMil(Plan):-
    findall(
        CostoFinal,
        (
            member(Mascota, Plan),
            costoTratamiento(Mascota, _, CostoFinal)
        ),
        ListaDeCostos
    ), 
    sum_list(ListaDeCostos, Total),
    Total =< 600000.