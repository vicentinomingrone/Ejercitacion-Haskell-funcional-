% accion(Ticker, Empresa, Sector, PrecioActual).
accion(aapl, apple, tecnologia, 230).
accion(msft, microsoft, tecnologia, 420).
accion(ko, cocaCola, consumo, 65).
accion(tsla, tesla, autosElectricos, 250).
accion(jpm, jpMorgan, bancos, 210).
accion(xom, exxonMobil, energia, 115).
accion(nvda, nvidia, tecnologia, 900).

% inversor(Nombre, Perfil, DineroDisponible).
inversor(vicentino, agresivo, 5000).
inversor(martina, conservador, 2000).
inversor(lucas, moderado, 3500).
inversor(sofia, agresivo, 1000).
inversor(tomas, conservador, 800).

% tenencia(Inversor, Ticker, Cantidad).
tenencia(vicentino, aapl, 5).
tenencia(vicentino, nvda, 2).
tenencia(martina, ko, 10).
tenencia(lucas, msft, 3).
tenencia(lucas, jpm, 4).
tenencia(sofia, tsla, 2).
tenencia(tomas, ko, 5).

% variacion(Ticker, VariacionPorcentual).
variacion(aapl, 4).
variacion(msft, 2).
variacion(ko, -1).
variacion(tsla, -8).
variacion(jpm, 1).
variacion(xom, -3).
variacion(nvda, 10).

% riesgoSector(Sector, Riesgo).
riesgoSector(tecnologia, alto).
riesgoSector(autosElectricos, alto).
riesgoSector(consumo, bajo).
riesgoSector(bancos, medio).
riesgoSector(energia, medio).

/*
Consultas: 

1- accion(_, _, tecnologia, _).
true. 
2- accion(tsla, _, _, Precio).
Precio = 250.
3- tenencia(vicentino, Cuales, _).
Cuales= appl;
Cuales= nvda.
4- inversor(martina, Perfil, _).
Perfil = Conservador.

1- No porque no dice nunca que haya 2 sectores ditintos. 

2- el problema que aparece es que pasaria como valido. 

3- no es inversible, se liga directamente en el Findall, se deberia ligar antes la variable Inversor. 

4- 


*/

accionInteresante(Accion):- 
    variacion(Accion, Variacion),
    Variacion > 3.

accionInteresante(Accion):- 
    accion(Accion, _, Sector, _),
    riesgoSector(Sector , bajo).

% valorInvertido(Inversor, Ticker, Valor).

valorInvertido(Inversor, Ticker, Valor):-
    tenencia(Inversor, Ticker, Cantidad),
    accion(Ticker, _, _, ValorAccion),
    Valor is Cantidad * ValorAccion. 


% valorTotalCartera(Inversor, ValorTotal).

valorTotalCartera(Inversor, ValorTotal):-
inversor(Inversor, _, _),
    findall(
        Valor,
        valorInvertido(Inversor, _, Valor),
        Valores 
        ),
        sum_list(Valores, ValorTotal). 

estaDiversificado(Inversor):-
    tenencia(Inversor, Ticker, _),
    accion(Ticker1, _, Sector, _),
    accion(Ticker2, _, OtroSector, _), 
    Sector \= OtroSector. 


