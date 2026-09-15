% vehiculo(Patente, Marca, Modelo, Anio, Categoria).
vehiculo(ab123cd, volkswagen, golTrend, 2021, economico).
vehiculo(ac456ef, toyota, corolla, 2019, familiar).
vehiculo(ad789gh, ford, ranger, 2016, pickup).
vehiculo(ae111ij, chevrolet, cruze, 2023, familiar).
vehiculo(af222kl, fiat, palio, 2012, economico).
vehiculo(ag333mn, peugeot, 208, 2020, economico).
vehiculo(ah444op, honda, civic, 2018, deportivo).
vehiculo(ai555qr, renault, kangoo, 2017, utilitario).

% ecu(Patente, MarcaECU, Estado).
ecu(ab123cd, bosch, estable).
ecu(ac456ef, denso, estable).
ecu(ad789gh, delphi, inestable).
ecu(ae111ij, bosch, estable).
ecu(af222kl, magnetiMarelli, fallando).
ecu(ag333mn, valeo, estable).
ecu(ah444op, denso, inestable).
ecu(ai555qr, magnetiMarelli, estable).

% sensor(Patente, Sensor, Estado).
sensor(ab123cd, oxigeno, ok).
sensor(ab123cd, temperatura, ok).
sensor(ac456ef, abss, ok).
sensor(ad789gh, presionTurbo, fallando).
sensor(ad789gh, temperatura, fallando).
sensor(ae111ij, abss, ok).
sensor(af222kl, oxigeno, fallando).
sensor(af222kl, temperatura, fallando).
sensor(ag333mn, ciguenial, ok).
sensor(ah444op, velocidad, fallando).
sensor(ai555qr, temperatura, ok).
sensor(ai555qr, presionAceite, fallando).

% falla(Patente, Problema, Gravedad).
falla(ad789gh, turbo, grave).
falla(af222kl, mezclaCombustible, grave).
falla(af222kl, temperaturaMotor, media).
falla(ah444op, transmision, media).
falla(ai555qr, presionAceite, grave).
falla(ab123cd, bateria, leve).

% costoBase(Problema, Costo).
costoBase(turbo, 450000).
costoBase(mezclaCombustible, 180000).
costoBase(temperaturaMotor, 130000).
costoBase(transmision, 350000).
costoBase(presionAceite, 220000).
costoBase(bateria, 90000).

% conductor(Nombre, Experiencia, Preferencia).
conductor(vicentino, 5, economico).
conductor(martina, 4, familiar).
conductor(lucas, 10, pickup).
conductor(sofia, 2, economico).
conductor(tomas, 15, utilitario).
conductor(camila, 7, deportivo).

% viaje(Codigo, Destino, Kilometros, Exigencia).
viaje(v1, cordoba, 700, media).
viaje(v2, mendoza, 1050, alta).
viaje(v3, rosario, 300, baja).
viaje(v4, bariloche, 1600, alta).
viaje(v5, marDelPlata, 400, media).
viaje(v6, tigre, 40, baja).

/*
Parte A — Consultas en consola
Escribí las consultas de Prolog e indicá sus respuestas.
¿Existe algún vehículo de categoría pickup?
vehiculo(_, _, _, _, pickup).
true.
¿Qué estado tiene la ECU del vehículo af222kl?
ecu(af222kl, _, Estado).
Estado = fallando. 
¿Qué sensores tiene fallando el vehículo ad789gh?
sensor(ad789gh, Cuales, fallando).
Cuales = presionTurbo; 
Cuales = temperatura.  
¿Cuántos kilómetros tiene el viaje a bariloche?
viaje(_, bariloche, Km, _).
Km = 1600. 

Parte B — Vehículo peligroso

Queremos saber si un vehículo es peligroso para viajar.

Un vehículo es peligroso cuando:

tiene una falla grave;
o su ECU está fallando;
o tiene más de un sensor fallando;
o tiene más de 10 años de antigüedad.

Tomar como año actual 2026.

nos dieron esto:
vehiculoPeligroso(Patente):-
    falla(Patente, _, grave).

vehiculoPeligroso(Patente):-
    ecu(Patente, _, fallando).

vehiculoPeligroso(Patente):-
    sensor(Patente, _, fallando).

vehiculoPeligroso(Patente):-
    vehiculo(Patente, _, _, Anio, _),
    2026 - Anio > 10.

Responder:

¿El código resuelve correctamente el problema planteado? Falso. 
El codigo no resulve correctamente el problema ya que el problema principal es que no toma en 
cuenta lo de los sensores, ya con que un sensor este fallando se denomina autoPrligroso y no es lo 
indicado, se deberia denominar auto fallado a partir de dos o mas sensores de acuerdo con la
consigna.
¿El predicado es inversible? Veradero, si es inerible, lo que no significa que sea cerrado.
Ser cerrado seria que solo admita vehiculos de nuestra BC, con esto podria admitirse un vehiculo que 
sea peligroso pero no este anotado como vehiculo en nuestra BC, quizas esta anotado como 
con fallas. Chat  decime si esto esta bien, porque si no no se proque es cerrado y no cerrado. 
¿Qué problema aparece con la tercera regla?
la tercera regla dice que con al menos un sensor mal ya pasa, lo cual es erroneo porque lo que pide
la consigna es que al menos 2, dice si tiene mas de un sensor fallando. 
Codificar una solución mejor. 
Esta codificacion esta mejor: 
*/

vehiculoPeligroso(Auto):-
    vehiculo(Auto, _, _, _, _),
    falla(Auto, _, grave).

vehiculoPeligroso(Auto):-
    vehiculo(Auto, _, _, _, _),
    ecu(Auto, _, fallando).

vehiculoPeligroso(Auto):-
    vehiculo(Auto, _, _, _, _),
    sensor(Auto, Sensor, fallando),
    sensor(Auto, OtroSensor, fallando),
    Sensor \= OtroSensor. 

vehiculoPeligroso(Auto):-
    vehiculo(Auto, _, _, Anio, _),
    Anio - 2026 > 10.

/*
Parte C — Costo de reparación

El costo final depende de la gravedad:

leve: costo base.
media: costo base + 40%.
grave: costo base + 90%.
*/

costoDeReparacion(Auto, Falla, CostoFinal):-
    vehiculo(Auto, _, _, _, _),
    falla(Auto, Falla, Gravedad),
    segunSuGravedad(Gravedad, Multiplicador),
    costoBase(Falla, CostoBase),
    CostoFinal is CostoBase * Multiplicador.

segunSuGravedad(leve, 1).
segunSuGravedad(media, 1.40).
segunSuGravedad(grave, 1.90).

costoTotalVehiculo(Auto, Total):-
    vehiculo(Auto, _, _, _, _),
    findall(
        Costo,
        costoDeReparacion(Auto, _, Costo),
        ListaDeCostos
    ),
    sum_list(ListaDeCostos, Total).

/*
¿Dónde usaste is y por qué?
lo use en costoDeReparacion(Auto, Falla, CostoFinal), ya que necesito hacer una 
asigancion pero con una cuenta. 
¿Dónde usaste findall y por qué?
costoTotalVehiculo(Auto, Total), lo use en esta regla ya que debo tener todos los costos 
de todos los probelemas de ese auto y luego eso sumarlo.
¿Para qué sirve sum_list?
Sirve para sumar lo diferentes resultados de una lista y comprarlo en este caso con el total
si llega a dar diferente daria False y  si llega dar igual saria true, 
si hago una pregunta extencial lo que va hacer es sumar todo lo de la veriable ListaDeCostos 
y lo va a  asignar a Total.

Parte D — Conductor apto

Un conductor es apto para manejar un vehículo en un viaje si:

El conductor existe.
El vehículo existe.
El viaje existe.
La preferencia del conductor coincide con la categoría del vehículo.
El vehículo no es peligroso.
La experiencia alcanza según la exigencia del viaje:
baja: más de 1 año.
media: más de 4 años.
alta: más de 8 años.

Definir:
conductor(Nombre, Experiencia, Preferencia).
conductor(vicentino, 5, economico).

vehiculo(Patente, Marca, Modelo, Anio, Categoria).
vehiculo(ab123cd, volkswagen, golTrend, 2021, economico).

viaje(Codigo, Destino, Kilometros, Exigencia).
viaje(v1, cordoba, 700, media).
*/

conductorApto(Conductor, Auto, Viaje):- 
    conductor(Conductor, Experiencia, Preferencia),
    vehiculo(Auto, _, _, _, Preferencia),
    viaje(Viaje, _, _, Exigencia),
    acuerdoConExperiencia(Exigencia, Experiencia),
    not(vehiculoPeligroso(Auto)). 


acuerdoConExperiencia(baja, 2).
acuerdoConExperiencia(media, 5).
acuerdoConExperiencia(alta, 9). 

% chat quizas se podria hacer de otra forma pero no me estaria dando cuenta. 

/*
Parte E — Plan de flota

La empresa quiere armar un plan de flota compuesto por exactamente 3 vehículos.

Un plan válido cumple:

Tiene exactamente 3 vehículos.
Todos los vehículos existen.
Ningún vehículo está repetido.
Tiene al menos un vehículo de categoría familiar.
Tiene al menos un vehículo con ECU estable.
No incluye vehículos peligrosos.
La suma de los costos totales de reparación de los vehículos del plan no supera 500000.
*/

planFlota(Plan):-
    findall(Auto, vehiculo(Auto, _, _, _, _), Autos)
    planPosible(Autos, Plan),
    planValido(Plan). 

planPosible([], []).

planPosible([Auto | Resto], [Auto | Plan]):-
    planPosible(Resto, Plan). 

planPosible([ _ | Resto], Plan):-
    planPosible(Resto, Plan). 


planValido(Plan):-
    length(Plan, 3),
    todosSonAutos(Plan),
    categoriaFamiliar(Plan),
    ecuEstables(Plan),
    noHayVehiculoPeligroso(Plan),
    costosNoSuperan(Plan, 500000).

todosSonAutos(Plan):-
    forall(
        member(Auto, Plan),
        vehiculo(Auto, _, _, _, _)
    ).

categoriaFamiliar(Plan):-
    member(Auto, Plan),
    vehiculo(Auto, _, _, _, familiar).

ecuEstables(Plan):-
    member(Auto, Plan), 
    ecu(Auto, _, estable).

noHayVehiculoPeligroso(Plan):-
    forall(
        member(Auto, Plan),
        not(vehiculoPeligroso(Auto))
        ).

costosNoSuperan(Plan, Cantidad):-
    findall(
        Total,
        costoTotalVehiculo(Auto, Total),
        CostosTotales
        ),
        sum_list(CostosTotales, TotalDeLosAutos),
        Canatidad =< TotalDeLosAutos. 