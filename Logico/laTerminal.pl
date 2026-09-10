% plato(Nombre, Categoria, PrecioBase).
plato(hamburguesa, principal, 8500).
plato(pizza, principal, 9000).
plato(ensaladaCaesar, entrada, 6000).
plato(rabas, entrada, 7500).
plato(tiramisu, postre, 5000).
plato(flan, postre, 3500).
plato(limonada, bebida, 2500).
plato(cafe, bebida, 1800).

% cocinero(Nombre, Especialidad, Experiencia).
cocinero(juan, carnes, 12).
cocinero(marta, pastas, 8).
cocinero(lucia, postres, 6).
cocinero(pedro, entradas, 4).
cocinero(ana, bebidas, 10).
cocinero(ricardo, carnes, 3).

% pedido(Cliente, Plato, Cantidad).
pedido(vicentino, hamburguesa, 2).
pedido(vicentino, limonada, 1).
pedido(martina, pizza, 1).
pedido(martina, tiramisu, 1).
pedido(lucas, rabas, 2).
pedido(sofia, ensaladaCaesar, 1).
pedido(sofia, cafe, 2).
pedido(tomas, flan, 1).

% ingrediente(Plato, Ingrediente).
ingrediente(hamburguesa, carne).
ingrediente(hamburguesa, pan).
ingrediente(hamburguesa, queso).
ingrediente(pizza, masa).
ingrediente(pizza, queso).
ingrediente(pizza, tomate).
ingrediente(ensaladaCaesar, lechuga).
ingrediente(ensaladaCaesar, pollo).
ingrediente(rabas, calamar).
ingrediente(tiramisu, cafe).
ingrediente(tiramisu, crema).
ingrediente(flan, huevo).
ingrediente(limonada, limon).
ingrediente(cafe, cafe).

% descuentoCliente(Cliente, TipoDescuento).
descuentoCliente(vicentino, estudiante).
descuentoCliente(martina, frecuente).
descuentoCliente(tomas, jubilado).


/*Parte A

1- plato(_, postre, _).
true
2- plato(pizza, _, Precio).
Precio = 9000
3- pedido(vicentino, Cual, _).
Cual = hamurgesa;
Cual = limonada. 
4- cocinero(lucia, Cual, _).
Cual = postres. 

Parte B 
1- El codigo resuelve correctamente el prolema
2- el predicado es inversible
3- no tiene repeticion de logica
4- algo mejorable es delimitar los platos a nuestra base de concoimiento en el ingrediente como lo hago abajo: 

*/

platoEspecial(Plato):-
    plato(Plato, _, Costo),
    Costo > 7000.

platoEspecial(Plato):-
    plato(Plato, _, _),
    ingrediente(Plato, carne). 

platoEspecial(Plato):-
    plato(Plato, postre, _).

% Parte c

precioPlatoParaCliente(Cliente, Plato, PrecioFinal):-
    pedido(Cliente, Plato, _),
    plato(Plato, _, Precio),
    descuentoCliente(Cliente, Categoria),
    dependeSuCategoria(Categoria, Multiplicador),
    PrecioFinal is Precio * Multiplicador.

precioPlatoParaCliente(Cliente, Plato, PrecioFinal):-
    pedido(Cliente, Plato, _),
    plato(Plato, _, PrecioFinal),
    not(descuentoCliente(Cliente, _)). 

dependeSuCategoria(estudiante, 0.80).
dependeSuCategoria(frecuente, 0.90).
dependeSuCategoria(jubilado, 0.50).


totalPedido(Cliente, Total):-
    pedido(Cliente, Plato, _),
    findall(
        PrecioFinal, 
        precioPlatoParaCliente(Cliente, Plato, PrecioFinal),
        ListaPrecios
    ),
    sum_list(ListaPrecios, Cantidad),
    Total is Cantidad. 

% Parte D 

% especialidadNecesaria(Categoria, Especialidad).
especialidadNecesaria(principal, carnes).
especialidadNecesaria(entrada, entradas).
especialidadNecesaria(postre, postres).
especialidadNecesaria(bebida, bebidas).


cocineroRecomendado(Cocinero, Plato):-
    plato(Plato, Categoria, _),
    cocinero(Cocinero, Especialidad, Experiencia),
    especialidadNecesaria(Categoria, Especialidad),
    Experiencia > 5. 

%predicado es inversible ya que sus variables se pueden ligar, de echo lo estan.  
%no es necesario generar un alista ya que tenes que comprar un cocinero con un plato, no un plato con todos los cocineros. 
% la consulta seria: cocineroRecomendado(Cual, tiramisu).

% Parte E 

menuPromocional(Menu):-
    findall(Plato, plato(Plato, _, _), Platos),
    menuPosible(Platos, Menu),
    menuValido(Menu). 



menuPosible([],[]).

menuPosible([Plato | Resto], [Plato | Menu]):-
    menuPosible(Resto, Menu). 

menuPosible([_| Resto],  Menu):-
    menuPosible(Resto, Menu). 



menuValido(Menu):-
    length(Menu, 3), 
    platosExisten(Menu),
    tienePrincipal(Menu),
    tienePostre(Menu),
    noSuperan(Menu, 20000). 

platosExistentes(Menu):-
    forall(
    member(Plato, Menu),
    plato(Plato, _, _)
    ).

tienePrincipal(Menu):-
    member(Plato, Menu),
    plato(Plato, principal, _).

tienePostre(Menu):-
    member(Plato, Menu),
    plato(Plato, postre, _).

noSuperan(Menu, PrecioPagar):- 
    findall(
        Precio, 
        (member(Plato, Menu),
        plato(Plato, _, Precio)),
        ListaPrecios
    ), 
    sum_lsit(ListaPrecios, PrecioMenu),
    PrecioMenu < PrecioPagar.

    