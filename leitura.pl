:- dynamic estacao_inicial/1.
:- dynamic estacao_final/1.
:- dynamic pode_ir/3.

% carrega_arquivo(NomeArquivo): Abre o arquivo NomeArquivo, limpa fatos anteriores e carrega todos os termos para a base de conhecimento em memoria.
% carrega_arquivo(+NomeArquivo)
carrega_arquivo(NomeArquivo) :-
    limpa_base,
    see(NomeArquivo),
    le_termos,
    seen.

% limpa_base/0: Remove fatos anteriores da memoria antes de uma nova leitura.
% limpa_base (0 parametros)
limpa_base :-
    retractall(estacao_inicial(_)),
    retractall(estacao_final(_)),
    retractall(pode_ir(_, _, _)).

% le_termos/0: Le recursivamente cada linha/termo ate encontrar end_of_file.
% le_termos (0 parametros)
le_termos :-
    read(Termo),
    processa_termo(Termo).

% processa_termo(Termo): Insere Termo na base ou encerra no fim do arquivo.
% processa_termo(+Termo)
processa_termo(end_of_file) :- !.
processa_termo(Termo) :-
    assert(Termo),
    le_termos.