%coche(patente, marca, modelo, año, dueño).
coche(ab123cd, volkswagen, goltrend, 2021, vicentino).
coche(ac456ef, toyota, corolla, 2018, martina).
coche(ad789gh, ford, fiesta, 2015, lucas).
coche(ae111ij, chevrolet, cruze, 2023, sofia).
coche(af222kl, fiat, palio, 2012, tomas).

mecanico(ramon, motor, 15).
mecanico(diego, frenos, 8).
mecanico(marcos, electronica, 5).
mecanico(oscar, distribucion, 12).
mecanico(leo, embrague, 3).

reparacion(ab123cd, cambioAceite, baja, 50000).
reparacion(ab123cd, frenos, media, 120000).
reparacion(ac456ef, electronica, alta, 250000).
reparacion(ad789gh, distribucion, alta, 300000).
reparacion(ae111ij, motor, alta, 450000).
reparacion(af222kl, embrague, media, 180000).

reparacionCostosa(Reparacion):-
    reparacion(_, Reparacion, _, Costo),
    Costo > 200000.

vehiculoViejo(Patente):-
    coche(Patente, _, _, Anio, _),
    2026 - Anio > 10.

mecanicoExperto(Mecanico):-
    mecanico(Mecanico, _, AniosExperiencia),
    AniosExperiencia > 10.

duenioConReparacionCara(Duenio):-
    coche(Patente, _, _, _, Duenio),
    reparacion(Patente, Reparacion, _, _),
    reparacionCostosa(Reparacion).

reparcionPrioridadAlta(Reparacion):-
    reparacion(_, Reparacion, alta, _).

reparcionPrioridadAlta(Reparacion):-
    reparacionCostosa(Reparacion).

/*Usé comparación numérica en reparaciónCostosa/1, vehiculoViejo/1 y mecanicoExperto/1, 
porque en esos casos comparo costos, años o experiencia.
Los predicados son inversibles porque primero generan datos desde hechos como coche/5, 
reparacion/4 o mecanico/3, y después aplican condiciones. 
Por ejemplo, reparacionCostosa(Reparacion) puede generar qué reparaciones son costosas.*/

cuantasReparacionesTiene(Patente, Cantidad):-
    coche(Patente, _, _, _, _),
    findall(
        Reparaciones, reparacion(Patente, Reparaciones, _, _), ListaDeRepraciones
        ),
        length(ListaDeRepraciones, Cantidad). 

vehiculoConMuchasReparaciones(Patente):-
    cuantasReparacionesTiene(Patente, Cantidad),
    Cantidad > 1. 
