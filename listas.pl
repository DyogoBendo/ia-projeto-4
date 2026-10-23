% pertence(Elemento, Lista): Verifica se Elemento pertence a Lista.
% pertence(?Elemento, ?Lista)
pertence(Elemento, [Elemento|_]) :- !.
pertence(Elemento, [_|Cauda]) :-
    pertence(Elemento, Cauda).

% insere_ordenado(Elemento, Lista, NovaLista): Insere Elemento na Lista, gerando NovaLista, ordenado por f(x).
% insere_ordenado(+Elemento, +Lista, -NovaLista)
insere_ordenado(Elemento, [], [Elemento]) :- !.
insere_ordenado(Elemento, [Cabeca|Cauda], [Elemento, Cabeca|Cauda]) :-
    menor_ou_igual_f(Elemento, Cabeca),
    !.
insere_ordenado(Elemento, [Cabeca|Cauda], [Cabeca|NovaCauda]) :-
    insere_ordenado(Elemento, Cauda, NovaCauda).

% menor_ou_igual_f(No1, No2): Verdadeiro se o custo F1 de No1 for menor ou igual ao custo F2 de No2
% menor_ou_igual_f(+No1, +No2)
menor_ou_igual_f(no_fronteira(F1, _, _, _, _), no_fronteira(F2, _, _, _, _)) :-
    F1 =< F2.

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