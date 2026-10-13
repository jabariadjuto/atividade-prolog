
% SISTEMA ESPECIALISTA PARA RECOMENDACAO DE EXERCICIOS

% 1. FATOS E RELACOES

ambiente(caminhada, ar_livre).
ambiente(corrida, ar_livre).
ambiente(musculacao, fechado).
ambiente(ciclismo, ar_livre).
ambiente(futebol, ar_livre).

modalidade(caminhada, individual).
modalidade(corrida, individual).
modalidade(musculacao, individual).
modalidade(ciclismo, individual).
modalidade(futebol, grupo).

objetivo(caminhada, lazer).
objetivo(corrida, condicionamento).
objetivo(musculacao, fortalecimento).
objetivo(ciclismo, condicionamento).
objetivo(futebol, lazer).

intensidade(caminhada, leve).
intensidade(corrida, intensa).
intensidade(musculacao, intensa).
intensidade(ciclismo, intensa).
intensidade(futebol, intensa).


% 2. REGRAS DE RECOMENDACAO

% Caminhada: ar livre E atividade leve
recomendar(caminhada, _, Ambiente, _, Intensidade) :-
    Ambiente = ar_livre,
    Intensidade = leve,
    ambiente(caminhada, Ambiente),
    intensidade(caminhada, Intensidade).

% Corrida: ar livre E condicionamento
recomendar(corrida, _, Ambiente, Objetivo, _) :-
    Ambiente = ar_livre,
    Objetivo = condicionamento,
    ambiente(corrida, Ambiente),
    objetivo(corrida, Objetivo).

% Musculacao: ambiente fechado E fortalecimento
recomendar(musculacao, _, Ambiente, Objetivo, _) :-
    Ambiente = fechado,
    Objetivo = fortalecimento,
    ambiente(musculacao, Ambiente),
    objetivo(musculacao, Objetivo).

% Futebol: grupo E lazer
recomendar(futebol, Modalidade, _, Objetivo, _) :-
    Modalidade = grupo,
    Objetivo = lazer,
    modalidade(futebol, Modalidade),
    objetivo(futebol, Objetivo).

% Ciclismo: ar livre OU condicionamento
recomendar(ciclismo, _, Ambiente, Objetivo, _) :-
    (Ambiente = ar_livre ; Objetivo = condicionamento).


% 3. ENTRADA E SAIDA DE DADOS

iniciar :-
    writeln('=== SISTEMA DE RECOMENDACAO DE EXERCICIOS ==='),

    writeln('Prefere atividade individual ou em grupo?'),
    writeln('Digite individual ou grupo:'),
    read(Modalidade),

    writeln('Prefere ar livre ou ambiente fechado?'),
    writeln('Digite ar_livre ou fechado:'),
    read(Ambiente),

    writeln('Qual seu objetivo principal?'),
    writeln('Digite condicionamento, lazer ou fortalecimento:'),
    read(Objetivo),

    writeln('Prefere atividade leve ou intensa?'),
    writeln('Digite leve ou intensa:'),
    read(Intensidade),

    nl,
    writeln('=== RESULTADO ==='),

    findall(Exercicio,
        recomendar(Exercicio, Modalidade, Ambiente,
                   Objetivo, Intensidade),
        Lista),

    sort(Lista, Recomendacoes),

    (Recomendacoes = [] ->
        writeln('Nenhum exercicio encontrado.')
    ;
        writeln('Exercicios recomendados:'),
        mostrar(Recomendacoes)
    ).

% Exibe as recomendacoes
mostrar([]).
mostrar([Exercicio|Resto]) :-
    write('- '),
    writeln(Exercicio),
    mostrar(Resto).
