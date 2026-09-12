% vuelo(Codigo, Destino, Tipo, HoraSalida).
vuelo(v001, cordoba, cabotaje, 10).
vuelo(v002, mendoza, cabotaje, 12).
vuelo(v003, madrid, internacional, 18).
vuelo(v004, miami, internacional, 22).
vuelo(v005, bariloche, cabotaje, 15).
vuelo(v006, roma, internacional, 20).
vuelo(v007, salta, cabotaje, 9).

% pasajero(Nombre, Vuelo, Edad, Categoria).
pasajero(vicentino, v003, 22, turista).
pasajero(martina, v001, 25, turista).
pasajero(lucas, v004, 17, turista).
pasajero(sofia, v002, 70, jubilado).
pasajero(tomas, v005, 12, menor).
pasajero(camila, v006, 35, business).
pasajero(juan, v003, 40, business).

% equipaje(Pasajero, PesoKg).
equipaje(vicentino, 28).
equipaje(martina, 15).
equipaje(lucas, 32).
equipaje(sofia, 20).
equipaje(tomas, 10).
equipaje(camila, 25).
equipaje(juan, 18).

% problema(Vuelo, TipoProblema, Gravedad).
problema(v003, demora, media).
problema(v004, clima, grave).
problema(v006, documentacion, grave).
problema(v001, mantenimiento, leve).
problema(v005, demora, leve).
problema(v007, tripulacion, media).

% costoBaseProblema(TipoProblema, Costo).
costoBaseProblema(demora, 50000).
costoBaseProblema(clima, 120000).
costoBaseProblema(documentacion, 90000).
costoBaseProblema(mantenimiento, 200000).
costoBaseProblema(tripulacion, 80000).

% empleado(Nombre, Area, Experiencia).
empleado(ana, documentacion, 8).
empleado(raul, mantenimiento, 15).
empleado(marcos, clima, 6).
empleado(lucia, pasajeros, 4).
empleado(pedro, tripulacion, 10).
empleado(soledad, documentacion, 3).

/*
Parte A 
1- vuelo(_, _, internacional, _). 
true.
2- vuelo(v003, Destino, _, _).
Destino = madrid.
3- pasajero(Pasajeros, v003, _, _).
Pasajeros = vicentino;
Pasajeros = juan.
4- empleado(raul, Area, _).
Area = mantenimiento.

Parte B 

el que no dieron:  
vueloCritico(Vuelo):-
    problema(Vuelo, _, grave).

vueloCritico(Vuelo):-
    vuelo(Vuelo, _, internacional, Hora),
    Hora > 20.

vueloCritico(Vuelo):-
    pasajero(_, Vuelo, Edad, _),
    Edad < 18.

1- Si resuleve el problema correctamente
2- si es invresible pero no es completamente cerrado que quiero decir, que no se liga con un 
vuelo existente, tipo se liga en el caso de el problema solo con los vuelos que tegan problema y asi con
las tres. 
3- para mi no tiene problema de Declaretividad o repeticion de logica, si quizas se podria delegar
lo de la edad y la hora. 
4- aca abajo la planteo. 

*/

vueloCritico(Vuelo):-
    vuelo(Vuelo, _, _, _),
    problema(Vuelo, _, grave).

vueloCritico(Vuelo):-
    vuelo(Vuelo, _, internacional, HoraDeSalida),
    HoraDeSalida > 20. 

/*
vueloCritico(Vuelo):-
    vuelo(Vuelo, _, internacional, _),
    saleDespues(Vuelo, 20).

saleDespues(Vuelo, Hora):-
    vuelo(Vuelo, _, _, Horario),
    Horario > Hora. 
*/

vueloCritico(Vuelo):-
    vuelo(Vuelo, _, _, _),
    pasajero(_, Vuelo, Edad, _),
    Edad < 18. 

/*
Parte C:
*/

costoProblemaVuelo(Vuelo, TipoProblema, CostoFinal):-
    vuelo(Vuelo, _, _, _),
    problema(Vuelo, TipoProblema, Gravedad),
    segunGravedad(Gravedad, Multiplicador), 
    costoBaseProblema(TipoProblema, CostoBase),
    CostoFinal is CostoBase * Multiplicador. 

segunGravedad(leve, 1).
segunGravedad(media, 1.30).
segunGravedad(grave, 1.70).

costoTotalVuelo(Vuelo, Total):- 
    findall(
        CostoFinal,
    costoProblemaVuelo(Vuelo, _, CostoFinal), 
        ListaDeCostos
        ),
        sum_list(ListaDeCostos, Total). 

/*
Parte D:
1- mi predicado es inversible ya que, esto:  vuelo(Vuelo, _, _, _).
Liga y dice que el vuelo tiene que existir, ademas tambien ligo al empleado.
2- no hace falta usar findall porque no pide comparacion con todos, lo unico que pide es que 
compraemos un empleado determinado con un vuelo cualquiera o al reves, no hace falta crear una
lista. 
3- la consulta que haria parael v006 es: 
empleadoRecomendado(Empleado, v006).

*/

empleadoRecomendado(Empleado, Vuelo):-
    vuelo(Vuelo, _, _, _), 
    problema(Vuelo, Problema, _), 
    empleado(Empleado, Problema, Experiencia),
    Experiencia > 5. 


% Parte E 

grupoPrioridad(Grupo):-
    findall(Vuelo,vuelo(Vuelo, _, _, _), Vuelos),
    grupoPosible(Vuelos, Grupo),
    grupoValido(Grupo).

grupoPosible([],[]).

grupoPosible([Vuelo | Resto],[Vuelo | Grupo]):-
    grupoPosible(Resto, Grupo).

grupoPosible([_ | Resto], Grupo):-
    grupoPosible(Resto, Grupo).

grupoValido(Grupo):-
    length(Grupo, 3),
    todosExisten(Grupo),
    tieneInternacional(Grupo),
    tieneCritico(Grupo),
    noSuperan(Grupo).

todosExisten(Grupo):-
    forall(
        member(Vuelo,Grupo),
        vuelo(Vuelo, _, _, _)
        ).
    
tieneInternacional(Grupo):-
    member(Vuelo, Grupo),
    vuelo(Vuelo, _, internacional, _).

tieneCritico(Grupo):-
    member(Vuelo, Grupo),
    vueloCritico(Vuelo).

noSuperan(Grupo):-
    findall(
        Total,
        (
            member(Vuelo, Grupo),
            costoTotalVuelo(Vuelo, Total)
        ),
        ListaDeTotal),
    sum_list(ListaDeTotal, Cantidad),
    Cantidad =< 300000.