% jugador(Nombre, Edad, Rango).
jugador(vicentino, 22, diamante).
jugador(martina, 25, oro).
jugador(lucas, 17, platino).
jugador(sofia, 30, diamante).
jugador(tomas, 12, plata).
jugador(camila, 40, maestro).
jugador(juan, 70, oro).
jugador(elena, 82, plata).

% juego(Codigo, Nombre, Genero, Dificultad).
juego(j001, valorant, shooter, alta).
juego(j002, leagueOfLegends, moba, alta).
juego(j003, fifa, deportes, media).
juego(j004, minecraft, sandbox, baja).
juego(j005, counterStrike, shooter, alta).
juego(j006, rocketLeague, deportes, media).
juego(j007, fortnite, battleRoyale, media).
juego(j008, chess, estrategia, alta).

% partida(Jugador, CodigoJuego, Resultado).
partida(vicentino, j001, victoria).
partida(vicentino, j005, derrota).
partida(martina, j003, victoria).
partida(lucas, j007, victoria).
partida(sofia, j002, derrota).
partida(tomas, j004, victoria).
partida(camila, j001, victoria).
partida(camila, j008, victoria).
partida(juan, j006, derrota).
partida(elena, j004, derrota).

% sancion(Jugador, Motivo, Gravedad).
sancion(vicentino, abandono, media).
sancion(sofia, insultos, leve).
sancion(camila, trampa, grave).
sancion(elena, abandono, grave).
sancion(elena, insultos, media).
sancion(lucas, toxicidad, leve).

% costoBaseSancion(Motivo, Costo).
costoBaseSancion(abandono, 5000).
costoBaseSancion(insultos, 3000).
costoBaseSancion(trampa, 15000).
costoBaseSancion(toxicidad, 4000).

% entrenador(Nombre, Especialidad, Experiencia).
entrenador(raul, shooter, 10).
entrenador(diego, estrategia, 7).
entrenador(marcos, deportes, 6).
entrenador(lucia, sandbox, 4).
entrenador(gustavo, mentalidad, 15).
entrenador(ana, moba, 12).

/**/

/*
Parte A — Consultas en consola

Escribí las consultas que harías en Prolog e indicá sus respuestas.

¿Existe algún jugador de rango diamante?
jugador(_, _, diamante).
true. 
¿Qué edad tiene elena?
jugador(elena, Edad, _).
Edad = 82.
¿Qué juegos jugó camila?
partida(camila, CodigoJuego, _).
CodigoJuego = j001;
CodigoJuego = j008.

¿Qué juegos gano camila?
partida(camila, CodigoJuego, victoria).
CodigoJuego = j001;
CodigoJuego = j008.
¿Qué género tiene counterStrike?
juego(_, counterStrike, Genero, _).
Genero = shooter. 

Parte B — Jugador conflictivo

Queremos saber si un jugador es conflictivo.

Un jugador es conflictivo cuando:

tiene una sanción grave;
o tiene más de una sanción cargada;
o tiene más de una partida con derrota;
o tiene más de 75 años.

jugadorConflictivo(Jugador):-
    sancion(Jugador, _, grave).

jugadorConflictivo(Jugador):-
    sancion(Jugador, _, _).

jugadorConflictivo(Jugador):-
    partida(Jugador, _, derrota).

jugadorConflictivo(Jugador):-
    jugador(Jugador, Edad, _),
    Edad > 75.

Responder:

¿El código resuelve correctamente el problema planteado?
No ya que no lo resuelve de la forma adecuada por ejmplo en la sancion el enuciado pide mas de 1
minimo 2 y la regla ya con 1 pasa.
¿El predicado jugadorConflictivo/1 es inversible?
es inversible, pero no cerrado. 
¿Qué problema aparece con la segunda regla?
La segunda regla pasa con apenas 1 sancion el prooblema es que necesitas como minimo 2 difrentes. 
¿Qué problema aparece con la tercera regla?
La tercera regla pasa con apenas 1 derrota el prooblema es que necesitas como minimo 2 difrentes.
Codificar una solución mejor.
esta: 

*/

jugadorConflictivo(Jugador):-
    jugador(Jugador, _, _),
    sancion(Jugador, _, grave).

jugadorConflictivo(Jugador):-
    jugador(Jugador, _, _),
    sancion(Jugador, Sancion, _),
    sancion(Jugador, OtraSancion, _),
    Sancion \= OtraSancion. 

jugadorConflictivo(Jugador):-
    jugador(Jugador, _, _),
    partida(Jugador, Partida, derrota),
    partida(Jugador, OtraPartida, derrota),
    Partida \= OtraPartida. 

jugadorConflictivo(Jugador):-
    jugador(Jugador, Edad, _),
    Edad > 75.

/*
Parte C — Costo de sanción

El costo final de una sanción depende de su gravedad:

Si la gravedad es leve, se cobra el costo base.
Si la gravedad es media, se cobra el costo base más un 50%.
Si la gravedad es grave, se cobra el costo base más un 120%.
*/

costoSancion(Jugador, Motivo, CostoFinal):-
    jugador(Jugador, _, _),
    sancion(Jugador, Motivo, Gravedad),
    segunGravedad(Gravedad, Multiplicador),
    costoBaseSancion(Motivo, CostoBase),
    CostoFinal is CostoBase * Multiplicador.

segunGravedad(leve, 1).
segunGravedad(media, 1.50).
segunGravedad(grave, 2.20).

costoTotalSanciones(Jugador, Total):-
    jugador(Jugador, _, _), 
    findall(
        CostoFinal,
        costoSancion(Jugador, _, CostoFinal), 
        CostosFinales
        ), 
        sum_list(CostosFinales, Total). 

% especialidadNecesaria(CodigoJuego, Especialidad).
especialidadNecesaria(j001, shooter).
especialidadNecesaria(j002, moba).
especialidadNecesaria(j003, deportes).
especialidadNecesaria(j004, sandbox).
especialidadNecesaria(j005, shooter).
especialidadNecesaria(j006, deportes).
especialidadNecesaria(j007, shooter).
especialidadNecesaria(j008, estrategia).

entrenadorRecomendado(Entrenador, Jugador):- 
    jugador(Jugador, _, _),
    partida(Jugador, Juego, _),
    entrenador(Entrenador, Especialidad, Experiencia),
    especialidadNecesaria(Juego, Especialidad),
    Experiencia > 5.

equipoCompetitivo(Equipo):-
    findall(Jugador, jugador(Jugador, _, _), Jugadores),
    equipoPosible(Jugadores, Equipo),
    equipoValido(Equipo).

equipoPosible([], []).

equipoPosible([Jugador | Resto], [Jugador | Equipo]):-
        equipoPosible(Resto, Equipo). 

equipoPosible([ _ | Resto], Equipo):-
        equipoPosible(Resto, Equipo). 

equipoValido(Equipo):-
    length(Equipo, 3),
    todosSonJugadores(Equipo),
    tieneRangos(Equipo), 
    tieneConflictivos(Equipo),
    noHayMenores(Equipo, 16), 
    costosNoSuperan(Equipo, 40000).


todosSonJugadores(Equipo):-
    forall(member(Jugador, Equipo),
    jugador(Jugador, _, _)
    ).

tieneRangos(Equipo):-
    member(Jugador, Equipo),
    jugador(Jugador, _, maestro).

tieneRangos(Equipo):-
    member(Jugador, Equipo),
    jugador(Jugador, _, diamante).

tieneConflictivos(Equipo):-
    member(Jugador, Equipo), 
    jugadorConflictivo(Jugador).

noHayMenores(Equipo, EdadPermitida):-
    member(Jugador, Equipo),
    jugador(Jugador, Edad, _),
    Edad > EdadPermitida. 

costosNoSuperan(Equipo, CantidadDada):-
    findall(
        Total,
        (
            member(Jugador, Equipo),
            costoTotalSanciones(Jugador, Total)
        ),
        ListaDeTotal),
    sum_list(ListaDeTotal, Cantidad),
    Cantidad =< CantidadDada.