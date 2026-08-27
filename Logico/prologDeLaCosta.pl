puestoDeComida(hamburguesa, 2000).
puestoDeComida(panchitoConPapas, 1500).
puestoDeComida(lomitoCompleto, 2500).
puestoDeComida(caramelos, 0).

atraccionTranquila(autitosChocadores, paraTodos).
atraccionTranquila(casaEmbrujada, paraTodos).
atraccionTranquila(laberinto, paraTodos).
atraccionTranquila(tobogan, soloChicos).
atraccionTranquila(calesita, soloChicos).

atraccionIntensa(barcoPirata, 14).
atraccionIntensa(tazasChinas, 6).
atraccionIntensa(simulador3d, 2).

montaniaRusa(abismoMortalRecargada, 3, 134).
montaniaRusa(paseoPorElBosque, 0, 45).

atraccionAcuatica(torpedoSalpicon).
atraccionAcuatica(esperoQueHayasTraidoUnaMudaDeRopa).

visitante(eusebio, viejitos, 80, 3000, sentimiento(50, 0)).
visitante(carmela, viejitos, 80, 0, sentimiento(0, 25)).

visitante(coty, sinGrupo, 9, 0, sentimiento(20, 0)).
visitante(vito, sinGrupo, 17, 2000, sentimiento(5, 20)).

vinoSolo(Visitante):-
    visitante(Visitante, sinGrupo, _, _, _).

totalMalestar(Visitante, Total):-
    visitante(Visitante, _, _, _, sentimiento(Hambre, Aburrimiento)),
    Total is Hambre + Aburrimiento.

bienestar(Visitante, felicidadPlena):-
    totalMalestar(Visitante, 0),
    not(vinoSolo(Visitante)).

bienestar(Visitante, podriaEstarMejor):-
    totalMalestar(Visitante, Total),
    Total >= 1,
    Total =< 50.

bienestar(Visitante, podriaEstarMejor):-
    totalMalestar(Visitante, 0),
    vinoSolo(Visitante).

bienestar(Visitante, necesitaEntretenerse):-
    totalMalestar(Visitante, Total),
    Total >= 51,
    Total =< 99.

bienestar(Visitante, seQuiereIrACasa):-
    totalMalestar(Visitante, Total),
    Total >= 100.

puedeComprar(Visitante, Comida):-
    visitante(Visitante, _, _, Dinero, _),
    puestoDeComida(Comida, Precio),
    Dinero >= Precio. 

satisface(Visitante, hamburguesa):-
    visitante(Visitante, _, _, _, sentimiento(Hambre, _)),
    Hambre < 50.

satisface(Visitante, panchitoConPapas):-
    nino(Visitante).

nino(Visitante):-
    visitante(Visitante, _, Edad, _, _),
    Edad < 13.

satisface(Visitante, lomitoCompleto):-
    visitante(Visitante, _, _, _, _).

satisface(Visitante, caramelos):-
    visitante(Visitante, _, _, _, _),
    not(puedeComprarOtraComida(Visitante)).

puedeComprarOtraComida(Visitante):-
    puedeComprar(Visitante, Comida),
    Comida \= caramelos.

puedeSatisfacerHambre(Grupo, Comida):-
    puestoDeComida(Comida, _),
    visitante(_, Grupo, _, _, _),
    forall(
        visitante(Visitante, Grupo, _, _, _),
        (
            puedeComprar(Visitante, Comida),
            satisface(Visitante, Comida)
        )
    ).  

lluviaDeHamburguesas(Visitante, Atraccion):-
    puedeComprar(Visitante, hamburguesa),
    atraccionIntensa(Atraccion, Coeficiente),
    Coeficiente > 10.

lluviaDeHamburguesas(Visitante, Atraccion):-
    puedeComprar(Visitante, hamburguesa),
    montaniaRusaPeligrosaPara(Visitante, Atraccion).

lluviaDeHamburguesas(Visitante, tobogan):-
    puedeComprar(Visitante, hamburguesa),
    atraccionTranquila(tobogan, soloChicos).

montaniaRusaPeligrosaPara(Visitante, Atraccion):-
    nino(Visitante),
    montaniaRusa(Atraccion, _, Duracion),
    Duracion > 60.

montaniaRusaPeligrosaPara(Visitante, Atraccion):-
    adulto(Visitante),
    not(bienestar(Visitante, necesitaEntretenerse)),
    montaniaConMasGiros(Atraccion).

montaniaConMasGiros(Atraccion):-
    montaniaRusa(Atraccion, Giros, _),
    not(hayOtraConMasGiros(Giros)).

hayOtraConMasGiros(Giros):-
    montaniaRusa(_, OtrosGiros, _),
    OtrosGiros > Giros.

adulto(Visitante):-
    visitante(Visitante, _, Edad, _, _),
    Edad >= 13.

opcionDeEntretenimiento(Visitante, _, Comida):-
    puedeComprar(Visitante, Comida).

opcionDeEntretenimiento(Visitante, _, Atraccion):-
    visitante(Visitante, _, _, _, _),
    atraccionTranquila(Atraccion, paraTodos).

opcionDeEntretenimiento(Visitante, _, Atraccion):-
    nino(Visitante),
    atraccionTranquila(Atraccion, soloChicos).

opcionDeEntretenimiento(Visitante, _, Atraccion):-
    adulto(Visitante),
    hayNinoEnSuGrupo(Visitante),
    atraccionTranquila(Atraccion, soloChicos).

opcionDeEntretenimiento(Visitante, _, Atraccion):-
    visitante(Visitante, _, _, _, _),
    atraccionIntensa(Atraccion, _).

opcionDeEntretenimiento(Visitante, _, Atraccion):-
    visitante(Visitante, _, _, _, _),
    montaniaRusa(Atraccion, _, _),
    not(montaniaRusaPeligrosaPara(Visitante, Atraccion)).

opcionDeEntretenimiento(Visitante, Mes, Atraccion):-
    visitante(Visitante, _, _, _, _),
    mesDeAtraccionesAcuaticas(Mes),
    atraccionAcuatica(Atraccion).

hayNinoEnSuGrupo(Visitante):-
    visitante(Visitante, Grupo, _, _, _),
    visitante(OtroVisitante, Grupo, _, _, _),
    nino(OtroVisitante).

mesDeAtraccionesAcuaticas(septiembre).
mesDeAtraccionesAcuaticas(octubre).
mesDeAtraccionesAcuaticas(noviembre).
mesDeAtraccionesAcuaticas(diciembre).
mesDeAtraccionesAcuaticas(enero).
mesDeAtraccionesAcuaticas(febrero).
mesDeAtraccionesAcuaticas(marzo).