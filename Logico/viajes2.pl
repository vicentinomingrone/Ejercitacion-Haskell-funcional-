% auto(Patente, Marca, Modelo, Anio, Tipo).
auto(ab123cd, volkswagen, goltrend, 2021, naftero).
auto(ac456ef, toyota, corolla, 2018, hibrido).
auto(ad789gh, ford, fiesta, 2015, naftero).
auto(ae111ij, chevrolet, cruze, 2023, diesel).
auto(af222kl, fiat, palio, 2012, naftero).
auto(ag333mn, peugeot, 208, 2020, diesel).
auto(ah444op, renault, sandero, 2017, naftero).

% conductor(Nombre, Experiencia, Preferencia).
conductor(vicentino, 5, ruta).
conductor(martina, 3, ciudad).
conductor(lucas, 8, ruta).
conductor(sofia, 2, ciudad).
conductor(tomas, 12, ruta).
conductor(camila, 6, mixto).

% viaje(Codigo, Destino, Km, TipoCamino).
viaje(viaje1, cordoba, 700, ruta).
viaje(viaje2, mendoza, 1050, ruta).
viaje(viaje3, marDelPlata, 400, mixto).
viaje(viaje4, rosario, 300, ruta).
viaje(viaje5, tigre, 40, ciudad).
viaje(viaje6, bariloche, 1600, ruta).

% problemaMecanico(Patente, Problema, Gravedad).
problemaMecanico(ab123cd, aceite, leve).
problemaMecanico(ad789gh, frenos, grave).
problemaMecanico(af222kl, embrague, media).
problemaMecanico(af222kl, temperatura, grave).
problemaMecanico(ah444op, suspension, media).
problemaMecanico(ag333mn, bateria, leve).

% costoBase(Problema, Costo).
costoBase(aceite, 50000).
costoBase(frenos, 180000).
costoBase(embrague, 220000).
costoBase(temperatura, 120000).
costoBase(suspension, 160000).
costoBase(bateria, 90000).

% asignado(Conductor, Viaje, Patente).
asignado(vicentino, viaje1, ab123cd).
asignado(lucas, viaje2, ac456ef).
asignado(martina, viaje5, ah444op).
asignado(tomas, viaje6, ae111ij).
asignado(camila, viaje3, ag333mn).

/*
Parte A 
¿Existe algún auto diesel?
auto(_, _, _, _, diesel).
true.
¿Cuántos kilómetros tiene el viaje a mendoza?
viaje(_, mendoza, Cuantos, _).
Cuantos = 1050.
¿Qué conductor tiene asignado el viaje1?
asignado(Conductor, viaje1, _).
Conductor = vicentino.
¿Qué problemas mecánicos tiene el auto af222kl?
problemaMecanico(af222kl, Cuales, _).
Cuales = embrague;
Cuales = temperatura. 

Parte B

Queremos saber si un auto es no recomendable para viajar.

Un auto es no recomendable cuando:

tiene un problema mecánico grave;
o tiene más de 10 años de antigüedad;
o tiene más de un problema mecánico cargado.

Tomar como año actual 2026.

autoNoRecomendable(Auto):-
    problemaMecanico(Auto, _, grave).

autoNoRecomendable(Auto):-
    auto(Auto, _, _, Anio, _),
    2026 - Anio > 10.

autoNoRecomendable(Auto):-
    problemaMecanico(Auto, _, _).

¿El código resuelve correctamente el problema planteado?
si el codigo resulve el problema, lo que pasa es que hay un pequeño problema en cuanto
a los problemas mecanicos que pueda tener, ya que con la implementacion que nos dieron 
dice que si tiene una ya pasa y en realidad tiene que tener por lo menos dos problemas 
mecanicos. 
¿El predicado autoNoRecomendable/1 es inversible?
es inversible, pero no es inversible y cerrado ya que no liga con un hecho de auto (eso se hace
para decir que el auto exista en unestra BC).
¿Qué problema aparece con la tercera regla?
Lo mismo que dije en la primera pregunta, pasa como un autoNoRecomendado apenas tenga un
problema detectado y no es lo que se pide, lo que se pide es que por lo menos tenga 2.
Codificar una solución mejor si encontrás problemas.
mejor solucion abajo: 
*/

autoNoRecomendable(Auto):-
    auto(Auto, _, _, _, _),
    problemaMecanico(Auto, _, grave).

autoNoRecomendable(Auto):-
    auto(Auto, _, _, Anio, _),
    2026 - Anio > 10. 

autoNoRecomendable(Auto):-
    auto(Auto, _, _, _, _),
    problemaMecanico(Auto, Problema, _),
    problemaMecanico(Auto, OtroProblema, _),
    Problema \= OtroProblema.

/*
Parte C. 
El costo final de reparar un problema mecánico depende de su gravedad:

Si la gravedad es leve, se cobra el costo base.
Si la gravedad es media, se cobra el costo base más un 25%.
Si la gravedad es grave, se cobra el costo base más un 60%.

*/

costoFinalDeReparacion(Auto, TipoFalla, CostoTotal):-
    auto(Auto, _, _, _, _),
    problemaMecanico(Auto, TipoFalla, Gravedad),
    costoBase(TipoFalla, CostoBase),
    segunGravedad(Gravedad, Multiplicador),
    CostoTotal is CostoBase * Multiplicador. 

segunGravedad(leve, 1).
segunGravedad(media, 1.25).
segunGravedad(grave, 1.60).

costoTotalReparacion(Auto, Total):-
    auto(Auto, _, _, _, _),
    findall( 
        CostoTotal, 
        costoFinalDeReparacion(Auto, _ CostoTotal),
        ListaDeCostos
        ),
        sum_list(ListaDeCostos, Total).


/*
Parte D — Viaje apto

Queremos saber si un conductor está apto para realizar un viaje.

Un conductor está apto para un viaje si:

El conductor existe.
El viaje existe.
La preferencia del conductor coincide con el tipo de camino del viaje, o la preferencia del conductor es mixto.
El conductor tiene experiencia suficiente:
para viajes de hasta 500 km necesita más de 2 años;
para viajes de más de 500 km necesita más de 5 años.

Tengo 2 posibiolidades, la que te paso: 

conductorAptoPara(Conductor, Viaje):-
    conductor(Conductor, Anios, PreferenciaEnViaje),
    viaje(Viaje, _, Km, PreferenciaEnViaje),
    Km =< 500,
    Anios > 2.

    
conductorAptoPara(Conductor, Viaje):-
    conductor(Conductor, Anios, PreferenciaEnViaje),
    viaje(Viaje, _, Km, PreferenciaEnViaje),
    Km > 500,
    Anios > 5.

me gusta mas esta: (No se que opinas)
*/

conductorAptoPara(Conductor, Viaje):-
    conductor(Conductor, Anios, Preferencia),
    viaje(Viaje, _, Km, TipoCamino),
    preferenciaCompatible(Preferencia, TipoCamino),
    experienciaSuficiente(Anios, Km).

preferenciaCompatible(mixto, _).
preferenciaCompatible(Preferencia, Preferencia).

experienciaSuficiente(Anios, Km):-
    Km =< 500,
    Anios > 2.

experienciaSuficiente(Anios, Km):-
    Km > 500,
    Anios > 5.

% Parte E — Combo de road trip

comboRoadTrip(Combo):-
    findall(Viaje, viaje(Viaje, _, _, _), Viajes),
    comboPermitido(Viajes, Combo),
    comboValido(Combo).

comboPermitido([], []).

comboPermitido([Viaje | Resto], [Resto | Combo]):-
    comboPermitido(Resto, Combo).

comboPermitido([_ | Resto],  Combo):-
    comboPermitido(Resto, Combo).

comboValido(Combo):-
    length(Combo, 3), 
    todosViajesExisten(Combo),
    hayViajeDeMuchosKm(Combo),
    viajeMixto(Combo),
    viajesNoSuperan(Combo, 2500).


todosViajesExisten(Combo):-
    forall(
        member(Viaje, Combo),
        viaje(Viaje, _, _, _)
        ).

hayViajeDeMuchosKm(Combo):-
    member(Viaje, Combo),
    viaje(Viaje, _, Km, _),
    Km > 1000. 

viajeMixto(Combo):-
    member(Viaje, Combo),
    viaje(Viaje, _, _, ciudad).

viajeMixto(Combo):-
    member(Viaje, Combo),
    viaje(Viaje, _, _, mixto).

viajesNoSuperan(Combo, Cantidad):-
   findall(Kilometro,
    (
    member(Viaje, Combo),
    viaje(Viaje, _, Kilometro, _)
    ),
    ListaDeKilometros
), 
sum_list(ListaDeKilometros, Total),
Total =< Cantidad.  
