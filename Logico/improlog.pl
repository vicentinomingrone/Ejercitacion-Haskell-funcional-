
integrante(sophieTrio, sophie, violin).
integrante(sophieTrio, santi, guitarra).
integrante(vientosDelEste, lisa, saxo).
integrante(vientosDelEste, santi, voz).
integrante(vientosDelEste, santi, guitarra).
integrante(jazzmin, santi, bateria).

nivelQueTiene(sophie, violin, 5).
nivelQueTiene(santi, guitarra, 2).
nivelQueTiene(santi, voz, 3).
nivelQueTiene(santi, bateria, 4).
nivelQueTiene(lisa, saxo, 4).
nivelQueTiene(lore, violin, 4).
nivelQueTiene(luis, trompeta, 1).
nivelQueTiene(luis, contrabajo, 4).

instrumento(violin, melodico(cuerdas)).
instrumento(guitarra, armonico).
instrumento(bateria, ritmico).
instrumento(saxo, melodico(viento)).
instrumento(trompeta, melodico(viento)).
instrumento(contrabajo, armonico).
instrumento(bajo, armonico).
instrumento(piano, armonico).
instrumento(pandereta, ritmico).
instrumento(voz, melodico(vocal)).

buenaBase(Grupo):-
    tocaInstrumentoDeRol(Grupo, Integrante, ritmico),
    tocaInstrumentoDeRol(Grupo, OtroIntegrante, armonico),
    Integrante \= OtroIntegrante.

tocaInstrumentoDeRol(Grupo, Integrante, Rol):-
    integrante(Grupo, Integrante, Instrumento),
    instrumento(Instrumento, Rol).

seDesteca(Integrante, Grupo):-
    integrante(Grupo, Integrante, Instrumento),
    nivelQueTiene(Integrante, Instrumento, Nivel), 
    forall((
        integrante(Grupo, OtroIntegrante, OtroInstrumento),
        OtroIntegrante \= Integrante
    ),(
        nivelQueTiene(OtroIntegrante, OtroInstrumento, OtroNivel),
        Nivel >= OtroNivel + 2
    )
).