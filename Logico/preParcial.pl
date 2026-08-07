% persona(Nombre, Apertura, Fuerza)

persona(ada, 166, 60).
persona(beto, 166, 65).
persona(connie, 154, 50).
persona(dana, 180, 70).
persona(esteban, 193, 40).

% ?- persona(_, 180, _).
% true
% ?- persona(dana, _, Fuerza).
% Fuerza = 70 
% ?- persona(Quien, 166, _).
% Quien= ada, Quien = beto
% ?- persona(millhouse, _, 33).
% False 
% ?- persona(connie, 154, _).
% True 

% Poco declarativa algunoSuperaA(Persona):-
% persona(Persona, _, Fuerza),
% findall(Otro, (persona(Otro, _, FuerzaOtro), FuerzaOtro > Fuerza), Otros),
% length(Otros, Longitud),
% Longitud > 0.

algunoSuperaA(Persona):-
    persona(Persona, _, Fuerza), 
    persona(OtraPersona, _, OtraFuerza), 
    Persona \= OtraPersona, 
    OtraFuerza > Fuerza. 



obstaculo(aro(7), 14).
obstaculo(aro(15), 70).
obstaculo(barril(seco, 80), 10).
obstaculo(pared(5), 90).
obstaculo(aro(15), 10).
obstaculo(barril(humedo, 50), 26).
obstaculo(aro(2), 27).
obstaculo(aro(5), 30). 

laMetaEstaEn1(Posicion):-
  obstaculo(_, Posicion),
  findall(Obs, (obstaculo(Obs, Pos),
      Pos > Posicion), Obstaculos),
  length(Obstaculos, 0).

laMetaEstaEn2(Posicion):-
  forall(obstaculo(_, Pos), Posicion >= Pos).

laMetaEstaEn(Posicion):-
    obstaculo(_, Posicion),
    not(hayObstaculoMasAdelante(Posicion)).

hayObstaculoMasAdelante(Posicion):-
    obstaculo(_, OtraPosicion),
    OtraPosicion > Posicion.




puedeDarUnPaso(Persona, Desde, Hasta):-
   persona(Persona, Apertura, Fuerza),
   Apertura > Hasta - Desde,
   obstaculo(aro(Grosor), Hasta),
   Fuerza > Grosor.

puedeDarUnPaso(Persona, Desde, Hasta):-
   persona(Persona, Apertura, Fuerza),
   Apertura > Hasta - Desde,
   obstaculo(pared(Altura), Hasta),
   Fuerza > Altura * 3.

puedeDarUnPaso(Persona, Desde, Hasta):-
   persona(Persona, Apertura, Fuerza),
   Apertura > Hasta - Desde,
   obstaculo(barril(humedo, Diametro), Hasta),
   Fuerza > 50 * Diametro / 10.

puedeDarUnPaso(Persona, Desde, Hasta):-
   persona(Persona, Apertura, Fuerza),
   Apertura > Hasta - Desde,
   obstaculo(barril(seco, Diametro), Hasta),
   Fuerza > 30 * Diametro / 10.

puedeDarUnPaso(Persona, Desde, Hasta):-
    aperturaSuficiente(Persona, Desde, Hasta),
    puedeSuperarObstaculoEn(Persona, Hasta).

aperturaSuficiente(Persona, Desde, Hasta):-
    persona(Persona, Apertura, _),
    Apertura > Hasta - Desde.

puedeSuperarObstaculoEn(Persona, Hasta):-
    persona(Persona, _, Fuerza),
    obstaculo(Obstaculo, Hasta),
    dificultad(Obstaculo, Dificultad),
    Fuerza > Dificultad.

dificultad(aro(Grosor), Grosor).

dificultad(pared(Altura), Dificultad):-
    Dificultad is Altura * 3.

dificultad(barril(Tipo, Diametro), Dificultad):-
    factorTipoBarril(Tipo, Factor),
    Dificultad is Factor * Diametro / 10.

factorTipoBarril(humedo, 50).
factorTipoBarril(seco, 30).