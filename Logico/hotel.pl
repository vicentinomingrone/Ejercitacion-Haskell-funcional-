% huesped(Nombre, Edad, TipoCliente).
huesped(vicentino, 22, frecuente).
huesped(martina, 25, comun).
huesped(lucas, 17, comun).
huesped(sofia, 30, frecuente).
huesped(tomas, 12, menor).
huesped(camila, 40, premium).
huesped(juan, 70, comun).
huesped(elena, 82, premium).

% habitacion(Numero, Tipo, Piso, PrecioPorNoche).
habitacion(101, simple, 1, 30000).
habitacion(102, doble, 1, 45000).
habitacion(201, suite, 2, 90000).
habitacion(202, doble, 2, 50000).
habitacion(301, suite, 3, 120000).
habitacion(302, simple, 3, 35000).
habitacion(401, presidencial, 4, 200000).

% reserva(Huesped, NumeroHabitacion, CantidadNoches).
reserva(vicentino, 201, 3).
reserva(martina, 102, 2).
reserva(lucas, 101, 1).
reserva(sofia, 301, 4).
reserva(tomas, 302, 1).
reserva(camila, 401, 5).
reserva(juan, 202, 2).
reserva(elena, 201, 2).

% problemaHabitacion(NumeroHabitacion, Problema, Gravedad).
problemaHabitacion(101, aireAcondicionado, leve).
problemaHabitacion(201, calefaccion, media).
problemaHabitacion(201, aguaCaliente, grave).
problemaHabitacion(301, limpieza, leve).
problemaHabitacion(401, electricidad, grave).
problemaHabitacion(202, wifi, media).

% costoBaseProblema(Problema, Costo).
costoBaseProblema(aireAcondicionado, 40000).
costoBaseProblema(calefaccion, 60000).
costoBaseProblema(aguaCaliente, 90000).
costoBaseProblema(limpieza, 20000).
costoBaseProblema(electricidad, 150000).
costoBaseProblema(wifi, 30000).

% empleado(Nombre, Area, Experiencia).
empleado(raul, mantenimiento, 10).
empleado(diego, recepcion, 7).
empleado(marcos, limpieza, 6).
empleado(lucia, wifi, 4).
empleado(gustavo, electricidad, 15).
empleado(ana, atencionCliente, 12).



/**/

/*
Escribí las consultas que harías en Prolog e indicá sus respuestas.

¿Existe algún huésped premium?
huesped(_, _, premium).
true.
para saber quien: huesped(Quien, _, premium).
Quien = camila;
Quien = elena. 
¿Qué edad tiene elena?
huesped(elena, Edad, _).
Edad = 82.
¿Qué habitación reservó vicentino?
reserva(vicentino, NumeroDeHabitacion, _).
NumeroDeHabitacion = 201.
¿Qué tipo de habitación es la 201?
habitacion(201, Tipo, _, _).
Tipo = suite.

Parte B — Habitación problemática

Queremos saber si una habitación es problemática.

Una habitación es problemática cuando:

tiene un problema grave;
o tiene más de un problema cargado;
o está en un piso mayor a 3;
o cuesta más de 150000 por noche.

Se nos dio esta implementación:
habitacionProblematica(Habitacion):-
    problemaHabitacion(Habitacion, _, grave).

habitacionProblematica(Habitacion):-
    problemaHabitacion(Habitacion, _, _).

habitacionProblematica(Habitacion):-
    habitacion(Habitacion, _, Piso, _),
    Piso > 3.

habitacionProblematica(Habitacion):-
    habitacion(Habitacion, _, _, Precio),
    Precio > 150000.

¿El código resuelve correctamente el problema planteado?
no dado a que en la parte de problema solo con 1 problema le basta. 
¿El predicado habitacionProblematica/1 es inversible?
es inversible pero no es cverrado e inversible
¿Qué problema aparece con la segunda regla?
ya con que este cargado un problema pasa, cuando el enucniado nos pide minimo 2. 
Codificar una solución mejor.

*/

habitacionProblematica(Habitacion):-
    habitacion(Habitacion, _, _, _),
    problemaHabitacion(Habitacion, _, grave).

habitacionProblematica(Habitacion):-
    habitacion(Habitacion, _, _, _),
    problemaHabitacion(Habitacion, Problema, _),
    problemaHabitacion(Habitacion, OtroProblema, _),
    Problema \= OtroProblema.
 

habitacionProblematica(Habitacion):-
    habitacion(Habitacion, _, Piso, _),
    Piso > 3.

habitacionProblematica(Habitacion):-
    habitacion(Habitacion, _, _, PrecioNoche),
    PrecioNoche > 150000.

costoReparacionHabitacion(Habitacion, Problema, CostoFinal):-
    habitacion(Habitacion, _, _, _),
    problemaHabitacion(Habitacion, Problema, Gravedad),
    costoBaseProblema(Problema, CostoBase),
    segunGravedad(Gravedad, Multiplicador),
    CostoFinal is CostoBase * Multiplicador. 


segunGravedad(leve, 1).
segunGravedad(media, 1.30).
segunGravedad(grave, 1.80).

costoTotalHabitacion(Habitacion, Total):-
    habitacion(Habitacion, _, _, _),
    findall(
        CostoFinal,
        costoReparacionHabitacion(Habitacion, Problema, CostoFinal),
        CostosFinales 
        ),
        sum_list(CostosFinales, Total). 

% areaNecesaria(Problema, Area).
areaNecesaria(aireAcondicionado, mantenimiento).
areaNecesaria(calefaccion, mantenimiento).
areaNecesaria(aguaCaliente, mantenimiento).
areaNecesaria(limpieza, limpieza).
areaNecesaria(electricidad, electricidad).
areaNecesaria(wifi, wifi).

empleadoRecomendado(Empleado, Habitacion):-
    habitacion(Habitacion, _, _, _),
    empleado(Empleado, Area, Experiencia), 
    problemaHabitacion(Habitacion, Problema, _),
    areaNecesaria(Problema, Area),
    Experiencia > 5. 


paqueteEstadia(Paquete):- 
    findall(Habitacion, habitacion(Habitacion, _, _, _), Habitaciones),
    paquetePosible(Habitaciones, Paquete),
    paqueteValido(Paquete). 


paquetePosible([],[]).

paquetePosible([Habitacion | Resto], [Habitacion | Paquete]):- 
    paquetePosible(Resto, Paquete).

paquetePosible([_ | Resto],  Paquete):- 
    paquetePosible(Resto, Paquete).