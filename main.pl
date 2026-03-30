% fatos

salario_base(2000).

% Nome, Turno, Anos de XP
funcionario(joao, matutino, 3).
funcionario(maria, integral, 5).
funcionario(pedro, vespertino, 1).
funcionario(ana, integral, 2).

% Faturamento de quanto o funcionário arrecadou no mês
faturamento_servicos(joao, 4000).
faturamento_servicos(maria, 7000).
faturamento_servicos(pedro, 2500).
faturamento_servicos(ana, 5000).

% regras

aumento_experiencia(Nome, Aumento) :-
    funcionario(Nome, _, Anos),
    Anos > 2,
    salario_base(Base),
    Aumento is Base * 0.10.

aumento_experiencia(Nome, 0) :-
    funcionario(Nome, _, Anos),
    Anos =< 2.

comissao_servicos(Nome, Comissao) :-
    faturamento_servicos(Nome, Faturamento),
    Comissao is Faturamento * 0.10.

salario_final(Nome, SalarioTotal) :-
    salario_base(Base),
    aumento_experiencia(Nome, Aumento),
    comissao_servicos(Nome, Comissao),
    SalarioTotal is Base + Aumento + Comissao.
