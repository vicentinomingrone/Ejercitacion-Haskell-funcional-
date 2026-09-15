% pc(Codigo, Tipo, Anio, Duenio).
pc(pc001, gamer, 2021, vicentino).
pc(pc002, oficina, 2018, martina).
pc(pc003, diseño, 2020, lucas).
pc(pc004, gamer, 2023, sofia).
pc(pc005, oficina, 2015, tomas).
pc(pc006, ediciónVideo, 2022, camila).
pc(pc007, estudio, 2017, juan).

% componente(PC, TipoComponente, Modelo, Estado).
componente(pc001, gpu, rtx3060, funcionando).
componente(pc001, ram, ddr4_16gb, funcionando).
componente(pc001, disco, ssd500, fallando).
componente(pc002, cpu, i5_8400, funcionando).
componente(pc002, ram, ddr4_8, funcionando).
componente(pc003, gpu, gtx1660, funcionando).
componente(pc003, disco, hdd1tb, fallando).
componente(pc004, gpu, rtx4070, funcionando).
componente(pc004, ram, ddr5_32, funcionando).
componente(pc004, fuente, 750, funcionando).
componente(pc005, disco, hdd500, fallando).
componente(pc005, fuente, 500, fallando).
componente(pc006, cpu, ryzen7, funcionando).
componente(pc006, gpu, rtx3080, fallando).
componente(pc007, ram, ddr3_4gb, fallando).

% falla(PC, Problema, Gravedad).
falla(pc001, discoLento, media).
falla(pc003, discoDaniado, grave).
falla(pc005, fuenteQuemada, grave).
falla(pc005, discoLento, media).
falla(pc006, placaVideo, grave).
falla(pc007, pocaMemoria, leve).

% costoBase(Problema, Costo).
costoBase(discoLento, 70000).
costoBase(discoDaniado, 150000).
costoBase(fuenteQuemada, 120000).
costoBase(placaVideo, 300000).
costoBase(pocaMemoria, 50000).

% tecnico(Nombre, Especialidad, Experiencia).
tecnico(raul, hardware, 12).
tecnico(diego, software, 7).
tecnico(marcos, gpu, 6).
tecnico(oscar, almacenamiento, 15).
tecnico(leo, fuentes, 3).
tecnico(gustavo, diagnostico, 20).

/*
Escribir las consultas que se harían en la consola de Prolog para responder 
las siguientes preguntas e indicar sus respuestas.

¿Existe alguna PC de tipo gamer?
pc(_, gamer, _, _).
true. 
¿Quién es el dueño de la pc006?
pc(pc006, _, _, Quien).
Quien = camila.
¿Qué componentes tiene cargados la pc001?
componente(pc001, Cual, _, _).
Cual = gpu;
Cual = ram; 
Cual = disco. 
¿Qué especialidad tiene oscar?
tecnico(oscar, Cual, _).
Cual = almacenamiento.


Parte B — PC problemática
Queremos saber si una PC es problemática.

Una PC es problemática cuando:

tiene una falla grave;
o tiene más de un componente fallando;
o es una PC de más de 8 años de antigüedad.

Tomar como año actual 2026.
Se nos dio esta implementación:

pcProblematica(PC):-
    falla(PC, _, grave).

pcProblematica(PC):-
    componente(PC, _, _, fallando).

pcProblematica(PC):-
    pc(PC, _, Anio, _),
    2026 - Anio > 8.

Responder verdadero o falso y justificar conceptualmente:

¿El código resuelve correctamente el problema planteado? Verdadero
Resuleve el problema planteado pero no del todo, ya que cuando hacemos lo del 
componente fallado, si hay un componente ya pasaria como pcProblematica, la idea es minimamente 
2 componentes fallados.
¿El predicado pcProblematica/1 es inversible? Verdadero
Es inversible, lo que no sigifica que es inversible cerrado, que quiere decir que jamas se fija la 
existencia de la pc. 
¿Qué problema aparece con la segunda regla? Verdadero tiene problemas. 
si hay un componente ya pasaria como pcProblematica, la idea es minimamente 
2 componentes fallados.
Codificar una solución mejor si encontrás problemas.
Aqui esta: 
*/

pcProblematica(Pc):-
    pc(Pc, _, _, _),
    falla(Pc, _, grave).

pcProblematica(Pc):-
    pc(Pc, _, Anio, _),
    2026 - Anio > 8. 

pcProblematica(Pc):-
    pc(Pc, _, _, _),
    componente(Pc, Componente, _, fallando),
    componente(Pc, OtroComponente, _, fallando),
    Componente \= OtroComponente. 



/*
Parte C — Costo de reparación

El costo final de reparar una falla depende de su gravedad:

Si la gravedad es leve, se cobra el costo base.
Si la gravedad es media, se cobra el costo base más un 30%.
Si la gravedad es grave, se cobra el costo base más un 80%.

Se pide definir:
*/

costoReparacion(Pc, TipoFalla, CostoFinal):-
    pc(Pc, _, _, _),
    falla(Pc, TipoFalla, Gravedad),
    costoBase(TipoFalla, CostoBase),
    segunGravedad(Gravedad, Multiplicador),
    CostoFinal is  CostoBase * Multiplicador. 

segunGravedad(leve, 1).
segunGravedad(media, 1.30).
segunGravedad(grave, 1.80).

costoTotalReparacion(Pc, Total):-
    pc(Pc, _, _, _),
    findall(
        CostoFinal, 
        costoReparacion(Pc, _, CostoFinal),
        ListaDeCostos
        ), 
        sum_list(ListaDeCostos, Total). %cuando me corrijas explicame que hace sum_list

/*
¿Dónde usaste is y por qué?
lo use en la regla costo de reparacion para asignar el valor de CostoFinal ya que se debe hacer una 
cuenta no tan cuentosa. 
¿Dónde usaste findall y por qué?
use Findall en CostoTotalReparacion ya que quiere que vea una Pc sus costos y eso lo sume
es mucho mas facil hacerlo con una lista 
¿Cómo mejorarías la solución usando un predicado auxiliar para el multiplicador?
lo hice.

Parte D — Técnico recomendado

Queremos saber si un técnico es recomendado para reparar una PC.

Para eso sabemos qué especialidad se necesita según el problema:
*/
% especialidadNecesaria(Problema, Especialidad).
especialidadNecesaria(discoLento, almacenamiento).
especialidadNecesaria(discoDañado, almacenamiento).
especialidadNecesaria(fuenteQuemada, fuentes).
especialidadNecesaria(placaVideo, gpu).
especialidadNecesaria(pocaMemoria, hardware).

tecnicoRecomendado(Tecnico, Pc):-
    pc(Pc, _, _, _),
    falla(Pc, Problema, _),
    tecnico(Tecnico, Especialidad, Experiencia),
    especialidadNecesaria(Problema, Especialidad),
    Experiencia > 5.

/*
Después responder:
¿El predicado es inversible?
Si es iversible y cerrado ya que pido que la PC este en la Bc y el tecnico tambien
¿Por qué no hace falta usar findall?
porque no hace falta crear una lista, para estos casos ya con que el tecnico sea recomendado para 
esa Pc ya da true. 
¿Qué consulta harías para saber qué técnicos pueden atender la pc005?
tecnicoRecomendado(Tecnico, pc005).

Parte E — Combo de reparación prioritaria

La casa de computación quiere armar un combo de reparación prioritaria compuesto por exactamente 3 PCs.

Un combo válido cumple:

Tiene exactamente 3 PCs.
Todas las PCs existen en la base.
Ninguna PC está repetida.
Tiene al menos una PC gamer.
Tiene al menos una PC problemática.
La suma de los costos totales de reparación de esas PCs no supera 750000.

Se pide definir:
*/

comboPrioritario(Combo):-
    findall(Pc, pc(Pc, _, _, _), Pcs),
    comboPosible(Pcs, Combo), 
    comboValido(Combo).

comboPosible([], []).

comboPosible([Pc | Resto], [Pc | Combo]):-
    comboPosible(Resto, Combo).

comboPosible([Pc | Resto],  Combo):-
    comboPosible(Resto, Combo). 

comboValido(Combo):-
    length(Combo, 3),
    lasPcsExisten(Combo), 
    tenemosPcGamer(Combo),
    tenemosPcConProblema(Combo),
    costosNoSuperan(Combo, 750000).

lasPcsExisten(Combo):-
    forall(
        member(Pc, Combo),
        pc(Pc, _, _, _)
        ).


tenemosPcGamer(Combo):-
    member(Pc, Combo),
    pc(Pc, gamer, _, _).

tenemosPcConProblema(Combo):-
    member(Pc, Combo),
    pcProblematica(Pc).


costosNoSuperan(Combo, Cantidad):-
    findall(
        Total, 
        (member(Pc, Combo),
        costoTotalReparacion(Pc, Total)),
        ListaDeTotales
        ),
    sum_list(ListaDeTotales, TotalDeCostos),
    TotalDeCostos =< Cantidad. 