% pertence(Elemento, Lista): Verifica se Elemento pertence a Lista.
% pertence(?Elemento, ?Lista)
pertence(Elemento, [Elemento|_]) :- !.
pertence(Elemento, [_|Cauda]) :-
    pertence(Elemento, Cauda).

% insere_ordenado(Elemento, Lista, NovaLista): Insere Elemento na Lista, gerando NovaLista, ordenado pela distancia acumulada.
% insere_ordenado(+Elemento, +Lista, -NovaLista)
insere_ordenado(Elemento, [], [Elemento]) :- !.
insere_ordenado(Elemento, [Cabeca|Cauda], [Elemento, Cabeca|Cauda]) :-
    menor_ou_igual_dist(Elemento, Cabeca),
    !.
insere_ordenado(Elemento, [Cabeca|Cauda], [Cabeca|NovaCauda]) :-
    insere_ordenado(Elemento, Cauda, NovaCauda).

% menor_ou_igual_dist(No1, No2): Verdadeiro se a distancia D1 de No1 for menor ou igual a distancia D2 de No2.
% menor_ou_igual_dist(+No1, +No2)
menor_ou_igual_dist(no_fronteira(D1, _, _), no_fronteira(D2, _, _)) :-
    D1 =< D2.

% insere_lista_ordenada(ListaElementos, FronteiraAtual, NovaFronteira): Insere todos os elementos de ListaElementos em FronteiraAtual, produzindo NovaFronteira.
% insere_lista_ordenada(+ListaElementos, +FronteiraAtual, -NovaFronteira)
insere_lista_ordenada([], Fronteira, Fronteira).
insere_lista_ordenada([Cabeca|Cauda], FronteiraAtual, NovaFronteira) :-
    insere_ordenado(Cabeca, FronteiraAtual, FronteiraIntermediaria),
    insere_lista_ordenada(Cauda, FronteiraIntermediaria, NovaFronteira).

% inverte_lista(Lista, ListaInvertida): Inverte Lista, produzindo ListaInvertida.
% inverte_lista(+Lista, -ListaInvertida)
inverte_lista(Lista, ListaInvertida) :-
    inverte_lista_aux(Lista, [], ListaInvertida).

% inverte_lista_aux(Lista, Acumulador, ListaInvertida): Predicado auxiliar para inverter Lista e obter ListaInvertida.
% inverte_lista_aux(+Lista, +Acumulador, -ListaInvertida)
inverte_lista_aux([], Acumulador, Acumulador).
inverte_lista_aux([Cabeca|Cauda], Acumulador, ListaInvertida) :-
    inverte_lista_aux(Cauda, [Cabeca|Acumulador], ListaInvertida).