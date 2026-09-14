% auto(Patente, Marca, Modelo, Anio, Duenio).
auto(ab123cd, volkswagen, golTrend, 2021, vicentino).
auto(ac456ef, toyota, corolla, 2018, martina).
auto(ad789gh, ford, fiesta, 2015, lucas).
auto(ae111ij, chevrolet, cruze, 2023, sofia).
auto(af222kl, fiat, palio, 2012, tomas).
auto(ag333mn, peugeot, 208, 2020, camila).
auto(ah444op, renault, sandero, 2017, juan).

% ecu(Auto, TipoECU, Estado).
ecu(ab123cd, bosch, funcionando).
ecu(ac456ef, denso, funcionando).
ecu(ad789gh, magnetiMarelli, inestable).
ecu(ae111ij, delphi, funcionando).
ecu(af222kl, magnetiMarelli, fallando).
ecu(ag333mn, bosch, funcionando).
ecu(ah444op, denso, inestable).

% sensor(Auto, Sensor, Estado).
sensor(ab123cd, oxigeno, ok).
sensor(ab123cd, temperatura, fallando).
sensor(ac456ef, abs, ok).
sensor(ac456ef, oxigeno, ok).
sensor(ad789gh, ciguenial, fallando).
sensor(ad789gh, temperatura, ok).
sensor(ae111ij, abs, fallando).
sensor(ae111ij, presionAceite, ok).
sensor(af222kl, oxigeno, fallando).
sensor(af222kl, temperatura, fallando).
sensor(ag333mn, abs, ok).
sensor(ah444op, ciguenial, ok).

% falla(Auto, TipoFalla, Gravedad).
falla(ab123cd, temperaturaMotor, media).
falla(ad789gh, encendido, grave).
falla(ae111ij, frenosAbs, grave).
falla(af222kl, mezclaCombustible, grave).
falla(af222kl, temperaturaMotor, media).
falla(ah444op, comunicacionEcu, media).

% costoBase(TipoFalla, Costo).
costoBase(temperaturaMotor, 120000).
costoBase(encendido, 250000).
costoBase(frenosAbs, 300000).
costoBase(mezclaCombustible, 180000).
costoBase(comunicacionEcu, 200000).

% tecnico(Nombre, Especialidad, Experiencia).
tecnico(ramon, mecanicaGeneral, 15).
tecnico(diego, electronica, 8).
tecnico(marcos, sensores, 6).
tecnico(oscar, ecu, 12).
tecnico(leo, frenos, 3).
tecnico(gustavo, diagnosticoAvanzado, 20).

/*
Parte A: 
¿Existe algún auto con ECU bosch?
ecu(_, bosch, _). 
true.
¿Qué estado tiene la ECU del auto af222kl?
ecu(af222kl, _, Estado).
Estado = fallando.
¿Qué sensores tiene cargados el auto ab123cd?
sensor(ab123cd, Sensores, _).
Sensores = oxigeno;
Sensores = temperatura.
¿Qué especialidad tiene gustavo?
tecnico(gustavo, Especialidad, _).
Especialidad = diagnosticoAvanzado. 

Parte B:
nos  dan esto: 
autoRiesgoso(Auto):-
    falla(Auto, _, grave).

autoRiesgoso(Auto):-
    ecu(Auto, _, fallando).

autoRiesgoso(Auto):-
    sensor(Auto, _, fallando).

Responder verdadero o falso y justificar conceptualmente:

¿El código resuelve correctamente el problema planteado? Falso, 
El problema esta en el sensor, la consigna dice mas de uno y la regla que hay implementada con un 
sensor roto ya pasaria. 
¿El predicado autoRiesgoso/1 es inversible? Verdadero. 
Es inversible pero no es inversible totalmente, ya que le faltaria estar ligado a un auto para que 
sepan que estan haablando de los autos de la BC 
¿Qué problema aparece con la tercera regla?
Lo dije antes, pero lo repito, el problema es que con un Sensor roto la regla ya pasa. Y la idea de
la implementacion del ejercicio es mas de 1 entonces tendrian que ser por lo menos 2 difreentes.
Codificar una solución mejor si encontrás problemas.
aca esta mi solucion creo que es la mejor: 
*/
autoRiesgoso(Patente):-
    auto(Patente, _, _, _, _),
    falla(Patente, _, grave).

autoRiesgoso(Patente):-
    auto(Patente, _, _, _, _),
    ecu(Patente, _, fallando).

autoRiesgoso(Patente):-
    auto(Patente, _, _, _, _),
    sensor(Patente, Sensor, fallando),
    sensor(Patente, OtroSensor, fallando),
    Sensor \= OtroSensor.

/*
Parte C — Costo de reparación electrónica

El costo final de reparar una falla depende de su gravedad:

Si la gravedad es leve, se cobra el costo base.
Si la gravedad es media, se cobra el costo base más un 35%.
Si la gravedad es grave, se cobra el costo base más un 75%.

*/

costoFinalFalla(Patente, TipoDeFalla, CostoFinal):-
    auto(Patente, _, _, _, _),
    falla(Patente, TipoDeFalla, Gravedad),
    segunGravedad(Gravedad, Multiplicador),
    costoBase(TipoDeFalla, Costo),
    CostoFinal is Costo * Multiplicador. 

segunGravedad(leve, 1).
segunGravedad(media, 1.35).
segunGravedad(grave, 1.75).

%Después queremos saber el costo total de reparación de un auto, sumando todas sus fallas:

costoTotalAuto(Patente, Total):-
    auto(Patente, _, _, _, _),
    findall(
        CostoFinal,
        costoFinalFalla(Patente, _, CostoFinal),
        ListaDeCostos
        ),
        sum_list(ListaDeCostos, Total). 

% Parte D — Técnico recomendado

% especialidadNecesaria(TipoFalla, Especialidad).
especialidadNecesaria(temperaturaMotor, mecanicaGeneral).
especialidadNecesaria(encendido, electronica).
especialidadNecesaria(frenosAbs, frenos).
especialidadNecesaria(mezclaCombustible, sensores).
especialidadNecesaria(comunicacionEcu, ecu).

tecnicoRecomendado(Tecnico, Patente):-
    auto(Patente, _, _, _, _),
    falla(Patente, TipoDeFalla, _),
    especialidadNecesaria(TipoDeFalla, Especialidad),
    tecnico(Tecnico, Especialidad, Experiencia), 
    Experiencia > 5. 

/*
¿El predicado es inversible?
Mi predicado es inversible porque ligo todo y ademas para saber que el auto esta lo hago con el hecho
 auto(Patente, _, _, _, _), esto me asegura que mi auto esta en la BC.
¿Por qué no hace falta usar findall?
No hace falta usar findall ya que no necesito una lista con la que trabajar, yo estoy buscando en 
especifico un tecninoo para un auto, y en el caso de las consultas existenciales estoy buscando 
el tencnico/auto para el auto/tecnico . 
¿Qué consulta harías para saber qué técnicos pueden atender el auto af222kl?
tecnicoRecomendado(Tecnico, af222kl).
Tecnico = . (algo asi esperas como respuesta)

Parte E — Combo de diagnóstico preventivo
*/



comboDiagnostico(Combo):-
    findall(Patente, auto(Patente, _, _, _, _), Autos),
    comboPosible(Autos, Combo),
    comboValido(Combo).


comboPosible([], []).

comboPosible([Patente | Resto], [Patente | Combo]):-
    comboPosible(Resto, Combo).

comboPosible([_ | Resto], Combo):-
    comboPosible(Resto, Combo).

comboValido(Combo):-
    length(Combo, 3),
    existenciaDeAutos(Combo),
    fallaEcu(Combo),
    almenosAutoRiesgoso(Combo),
    costosNoSuperan(Combo, 800000).


existenciaDeAutos(Combo):- 
    forall(
        member(Patente, Combo),
        auto(Patente, _, _, _, _)
        ).

fallaEcu(Combo):-
    member(Patente, Combo),
    ecu(Patente, _, fallando).
    
fallaEcu(Combo):-
    member(Patente, Combo),
    ecu(Patente, _, inestable).


almenosAutoRiesgoso(Combo):-
    member(Patente, Combo),
    autoRiesgoso(Patente).

costosNoSuperan(Combo, Cantidad):-
    findall(Costo, 
        (
            member(Patente, Combo), costoTotalAuto(Patente, Costo)
        ), 
        TotalDeLista
        ),
        sum_list(TotalDeLista, Total),
        Total =< Cantidad.  