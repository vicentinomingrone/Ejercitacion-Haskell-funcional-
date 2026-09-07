% auto(Patente, Marca, Modelo, Anio, Duenio).
auto(ab123cd, volkswagen, goltrend, 2021, vicentino).
auto(ac456ef, toyota, corolla, 2018, martina).
auto(ad789gh, ford, fiesta, 2015, lucas).
auto(ae111ij, chevrolet, cruze, 2023, sofia).
auto(af222kl, fiat, palio, 2012, tomas).
auto(ag333mn, peugeot, 208, 2020, camila).
auto(ah444op, renault, sandero, 2017, juan).

% mecanico(Nombre, Especialidad, Experiencia).
mecanico(ramon, motor, 15).
mecanico(diego, frenos, 8).
mecanico(marcos, electronica, 5).
mecanico(oscar, distribucion, 12).
mecanico(leo, embrague, 3).
mecanico(ramon, embrague, 4).
mecanico(gustavo, suspension, 20).

% diagnostico(Patente, Problema, Gravedad).
diagnostico(ab123cd, cambioAceite, leve).
diagnostico(ab123cd, frenos, media).
diagnostico(ac456ef, electronica, grave).
diagnostico(ad789gh, distribucion, grave).
diagnostico(ae111ij, motor, grave).
diagnostico(af222kl, embrague, media).
diagnostico(ag333mn, suspension, leve).
diagnostico(ah444op, frenos, grave).

% costoBase(Problema, Costo).
costoBase(cambioAceite, 50000).
costoBase(frenos, 120000).
costoBase(electronica, 250000).
costoBase(distribucion, 300000).
costoBase(motor, 450000).
costoBase(embrague, 180000).
costoBase(suspension, 90000).

% pruebaRealizada(Patente, Resultado).
pruebaRealizada(ab123cd, aprobado).
pruebaRealizada(ac456ef, rechazado).
pruebaRealizada(ad789gh, rechazado).
pruebaRealizada(ae111ij, rechazado).
pruebaRealizada(af222kl, aprobado).
pruebaRealizada(ag333mn, aprobado).


% costoReparacion(Patente, Problema, CostoFinal).

costoDeReparacion(Patente, Problema, CostoFinal):-
    diagnostico(Patente, Problema, Gravedad),
    costoBase(Problema, Dinero),
    multiplicadorSegunGravedad(Gravedad, Multiplicador), 
    CostoFinal is Dinero* Multiplicador. 


multiplicadorSegunGravedad(leve, 1).
multiplicadorSegunGravedad(media, 1.2).
multiplicadorSegunGravedad(grave, 1.5).

esElMejorEn1(Mecanico, Especialidad):-
    mecanico(Mecanico, Especialidad, Experiencia),
    findall(
        Otro,
        (
            mecanico(Otro, Especialidad, OtraExperiencia),
            OtraExperiencia > Experiencia
        ),
        Mejores
    ),
    length(Mejores, 0).

esElMejorEn2(Mecanico, Especialidad):-
    mecanico(Mecanico, Especialidad, Experiencia),
    forall(
        mecanico(_, Especialidad, OtraExperiencia),
        Experiencia >= OtraExperiencia
    ).

esElMejorEn3(Mecanico, Especialidad):-
    mecanico(Mecanico, Especialidad, Experiencia),
    not(hayOtroConMasExperiencia(Mecanico, Especialidad, Experiencia)).

hayOtroConMasExperiencia(Mecanico, Especialidad, Experiencia):-
    mecanico(OtroMecanico, Especialidad, OtraExperiencia),
    OtroMecanico \= Mecanico,
    OtraExperiencia > Experiencia.

% Parte E - Equipo de reparación especial

equipoEspecial(Equipo):-
    mecanicosDisponibles(Mecanicos),
    equipoPosible(Mecanicos, Equipo),
    equipoValido(Equipo).

mecanicosDisponibles(Mecanicos):-
    findall(
        Mecanico,
        mecanico(Mecanico, _, _),
        Mecanicos
    ).

equipoPosible([], []).

equipoPosible([Mecanico | Resto], [Mecanico | Equipo]):-
    equipoPosible(Resto, Equipo).

equipoPosible([_ | Resto], Equipo):-
    equipoPosible(Resto, Equipo).

equipoValido(Equipo):-
    length(Equipo, 4),
    todosTienenMasDeTresAnios(Equipo),
    tieneEspecialidadEnEquipo(Equipo, motor),
    tieneEspecialidadEnEquipo(Equipo, electronica).

todosTienenMasDeTresAnios(Equipo):-
    forall(
        member(Mecanico, Equipo),
        mecanicoConMasDeTresAnios(Mecanico)
    ).

mecanicoConMasDeTresAnios(Mecanico):-
    mecanico(Mecanico, _, Experiencia),
    Experiencia > 3.

tieneEspecialidadEnEquipo(Equipo, Especialidad):-
    member(Mecanico, Equipo),
    mecanico(Mecanico, Especialidad, _).