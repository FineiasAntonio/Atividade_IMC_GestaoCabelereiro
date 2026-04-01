%  MODELAGEM: Sistema de gestão de um salão de cabeleireiro
%  que inclui:
%    - Funcionários, cargos e especialidades
%    - Cálculo de salário com bônus e comissão
%    - Clientes com nível de fidelidade
%    - Cardápio de serviços com preço e duração
%    - Agendamentos com validação de disponibilidade
%    - Recomendação personalizada de serviços
%    - Relatório de faturamento do salão

%  SEÇÃO 1 — FATOS: FUNCIONÁRIOS
%  funcionario(Nome, Cargo, SalarioBase, HorasSemanais)

funcionario(ana,    cabeleireira, 2500, 40).
funcionario(bruno,  barbeiro,     2000, 40).
funcionario(carla,  colorista,    3200, 40).
funcionario(diana,  cabeleireira, 2700, 44).
funcionario(edu,    manicure,     1800, 30).
funcionario(fabio,  barbeiro,     2200, 40).

% especialidade(Funcionario, Servico)

especialidade(ana,   corte_feminino).
especialidade(ana,   escova).
especialidade(ana,   hidratacao).
especialidade(bruno, barba).
especialidade(bruno, corte_masculino).
especialidade(carla, coloracao).
especialidade(carla, luzes).
especialidade(carla, alisamento).
especialidade(diana, corte_feminino).
especialidade(diana, tratamento_capilar).
especialidade(diana, penteado).
especialidade(edu,   manicure).
especialidade(edu,   pedicure).
especialidade(fabio, corte_masculino).
especialidade(fabio, barba).
especialidade(fabio, sobrancelha_masculina).

% disponivel(Funcionario, DiaDaSemana)

disponivel(ana,    segunda).
disponivel(ana,    terca).
disponivel(ana,    quarta).
disponivel(ana,    quinta).
disponivel(ana,    sexta).
disponivel(bruno,  segunda).
disponivel(bruno,  quarta).
disponivel(bruno,  sexta).
disponivel(carla,  terca).
disponivel(carla,  quinta).
disponivel(carla,  sexta).
disponivel(diana,  segunda).
disponivel(diana,  terca).
disponivel(diana,  quarta).
disponivel(diana,  quinta).
disponivel(diana,  sexta).
disponivel(diana,  sabado).
disponivel(edu,    segunda).
disponivel(edu,    quarta).
disponivel(edu,    sabado).
disponivel(fabio,  terca).
disponivel(fabio,  quinta).
disponivel(fabio,  sabado).


%  SEÇÃO 2 — FATOS: CLIENTES
%  cliente(Nome, Nivel)
%  Níveis: bronze, prata, ouro, diamante

cliente(joao,    bronze).
cliente(maria,   ouro).
cliente(pedro,   prata).
cliente(lucia,   diamante).
cliente(fernanda,prata).
cliente(rafael,  bronze).
cliente(beatriz, ouro).

% historico_visitas(Cliente, QuantidadeDeVisitas)

historico_visitas(joao,     3).
historico_visitas(maria,    25).
historico_visitas(pedro,    10).
historico_visitas(lucia,    52).
historico_visitas(fernanda, 8).
historico_visitas(rafael,   1).
historico_visitas(beatriz,  18).

% preferencia(Cliente, Servico, Detalhe)

preferencia(maria,    coloracao,       loiro_platinado).
preferencia(lucia,    corte_feminino,  curto_moderno).
preferencia(joao,     corte_masculino, degradê).
preferencia(pedro,    barba,           aparada_media).
preferencia(fernanda, hidratacao,      cachos).
preferencia(rafael,   corte_masculino, social).
preferencia(beatriz,  luzes,           mel).

% alergia(Cliente, Produto)  — p/ segurança do cliente.
alergia(maria,   amonia).
alergia(fernanda,queratina).


%  SEÇÃO 3 — FATOS: SERVIÇOS
%  servico(Nome, Preco, DuracaoMinutos, Categoria)

servico(corte_feminino,         80,  60,  cabelo).
servico(corte_masculino,        50,  30,  cabelo).
servico(escova,                 60,  45,  cabelo).
servico(hidratacao,            100,  60,  tratamento).
servico(coloracao,             200,  120, quimica).
servico(luzes,                 250,  150, quimica).
servico(alisamento,            300,  180, quimica).
servico(tratamento_capilar,    120,  60,  tratamento).
servico(barba,                  40,  30,  masculino).
servico(sobrancelha_masculina,  25,  20,  masculino).
servico(manicure,               35,  40,  estetica).
servico(pedicure,               45,  50,  estetica).
servico(penteado,               90,  60,  cabelo).

% produto_usado(Servico, Produto)  — para checar alergias

produto_usado(coloracao,  amonia).
produto_usado(coloracao,  oxidante).
produto_usado(luzes,      amonia).
produto_usado(alisamento, queratina).
produto_usado(hidratacao, oleo_argan).

% agendamento(Cliente, Funcionario, Servico, DiaDaSemana)

agendamento(maria,    carla,  coloracao,       terca).
agendamento(joao,     bruno,  corte_masculino, segunda).
agendamento(lucia,    diana,  corte_feminino,  sabado).
agendamento(pedro,    fabio,  barba,           quinta).
agendamento(fernanda, ana,    hidratacao,      quarta).
agendamento(beatriz,  carla,  luzes,           sexta).
agendamento(rafael,   fabio,  corte_masculino, sabado).


%  SEÇÃO 4 — REGRAS: FUNCIONÁRIOS E SALÁRIOS

% Predicado UNÁRIO 
% funcionario_senior/1: funcionário com salário base acima de R$2.800

funcionario_senior(Nome) :-
    funcionario(Nome, _, Salario, _),
    Salario >= 2800.

% Predicado BINÁRIO 
% cargo_funcionario/2: retorna o cargo de um funcionário

cargo_funcionario(Nome, Cargo) :-
    funcionario(Nome, Cargo, _, _).

% Regra com CONJUNÇÃO e ARITMÉTICA
% hora_extra/3: verifica se funcionário faz hora extra (>40h) e calcula valor

hora_extra(Nome, HorasExtras, ValorExtra) :-
    funcionario(Nome, _, Salario, Horas),
    Horas > 40,
    HorasExtras is Horas - 40,
    ValorHora is Salario / 160,
    ValorExtra is HorasExtras * ValorHora * 1.5.

% Regra com DISJUNÇÃO (;) 
% bonus_cargo/2: bônus conforme cargo — uso explícito de disjunção ";"

bonus_cargo(Nome, Bonus) :-
    funcionario(Nome, Cargo, Salario, _),
    (   Cargo = colorista   -> Bonus is Salario * 0.20
    ;   Cargo = cabeleireira -> Bonus is Salario * 0.15
    ;   Cargo = barbeiro     -> Bonus is Salario * 0.10
    ;                          Bonus is Salario * 0.05
    ).

% Predicado TERNÁRIO 
% salario_final/3: calcula salário final com bônus e hora extra (se houver)

salario_final(Nome, SalarioFinal, Descricao) :-
    funcionario(Nome, _, Base, _),
    bonus_cargo(Nome, Bonus),
    (   hora_extra(Nome, _, Extra)
    ->  SalarioFinal is Base + Bonus + Extra,
        Descricao = com_hora_extra
    ;   SalarioFinal is Base + Bonus,
        Descricao = sem_hora_extra
    ).

%  SEÇÃO 5 — REGRAS: CLIENTES, DESCONTOS E FIDELIDADE

% Regra com DISJUNÇÃO explícita via ";" 
% percentual_desconto/2: desconto por nível de fidelidade

percentual_desconto(Cliente, Desconto) :-
    cliente(Cliente, Nivel),
    (   Nivel = diamante -> Desconto = 30
    ;   Nivel = ouro     -> Desconto = 20
    ;   Nivel = prata    -> Desconto = 10
    ;                       Desconto = 0
    ).

% nivel_fidelidade/2: determina nível pela quantidade de visitas
% (regra alternativa ao fato — usando operadores de desigualdade)

nivel_por_visitas(Cliente, diamante) :-
    historico_visitas(Cliente, V), V >= 50.
nivel_por_visitas(Cliente, ouro) :-
    historico_visitas(Cliente, V), V >= 20, V < 50.
nivel_por_visitas(Cliente, prata) :-
    historico_visitas(Cliente, V), V >= 5, V < 20.
nivel_por_visitas(Cliente, bronze) :-
    historico_visitas(Cliente, V), V < 5.

% valor_com_desconto/3: preço final do serviço para o cliente

valor_com_desconto(Cliente, Servico, ValorFinal) :-
    servico(Servico, Preco, _, _),
    percentual_desconto(Cliente, Desc),
    ValorFinal is Preco * (1 - Desc / 100).

% cliente_fiel/1: cliente com mais de 15 visitas

cliente_fiel(Cliente) :-
    historico_visitas(Cliente, V),
    V > 15.

% proximo_nivel/2: informa quantas visitas faltam para o próximo nível

visitas_para_proximo_nivel(Cliente, Faltam) :-
    historico_visitas(Cliente, V),
    nivel_por_visitas(Cliente, Nivel),
    (   Nivel = bronze   -> Meta = 5
    ;   Nivel = prata    -> Meta = 20
    ;   Nivel = ouro     -> Meta = 50
    ;                       Meta = V   % diamante: já no topo
    ),
    Faltam is Meta - V.


%  SEÇÃO 6 — REGRAS: AGENDAMENTOS E VALIDAÇÕES

% agendamento_valido/4: verifica TODOS os critérios de validade
%   1. Funcionário tem especialidade no serviço
%   2. Funcionário está disponível no dia
%   3. Não há alergias ao produto usado no serviço

agendamento_valido(Cliente, Funcionario, Servico, Dia) :-
    agendamento(Cliente, Funcionario, Servico, Dia),
    pode_realizar_servico(Funcionario, Servico),
    funcionario_disponivel_no_dia(Funcionario, Dia),
    \+ agendamento_alergico(Cliente, Servico).   % negação: sem alergias

% agendamento_alergico/2: detecta conflito entre serviço e alergia do cliente

agendamento_alergico(Cliente, Servico) :-
    produto_usado(Servico, Produto),
    alergia(Cliente, Produto).

%  SEÇÃO 7 — REGRAS: RECOMENDAÇÃO PERSONALIZADA

% recomendar_servico/2: recomenda serviço com base no nível do cliente
%   - Diamante/Ouro: serviços premium (química)
%   - Prata: tratamentos
%   - Bronze: serviços básicos (cabelo/masculino)

recomendar_servico(Cliente, Servico) :-
    cliente(Cliente, Nivel),
    servico(Servico, _, _, Categoria),
    (   (Nivel = diamante ; Nivel = ouro) -> Categoria = quimica
    ;   Nivel = prata                     -> Categoria = tratamento
    ;                                        (Categoria = cabelo ; Categoria = masculino)
    ).


%  SEÇÃO 9 — CONSULTAS DEMONSTRATIVAS
%  (Execute após: ?- consult('cutlog.pl').)

/*

CONSULTA 1: Validade dos agendamentos 
Verifica se cada agendamento respeita especialidade, disponibilidade e alergia.

?- agendamento_valido(Cliente, Funcionario, Servico, Dia).

Resultado esperado:
  Cliente=joao,    Funcionario=bruno, Servico=corte_masculino, Dia=segunda
  Cliente=lucia,   Funcionario=diana, Servico=corte_feminino,  Dia=sabado
  Cliente=pedro,   Funcionario=fabio, Servico=barba,           Dia=quinta
  Cliente=fernanda,Funcionario=ana,   Servico=hidratacao,      Dia=quarta
  Cliente=beatriz, Funcionario=carla, Servico=luzes,           Dia=sexta
  Cliente=rafael,  Funcionario=fabio, Servico=corte_masculino, Dia=sabado
  
  NOTA: maria (coloracao com amonia) NÃO aparece por causa da alergia!


CONSULTA 2: Alerta de alergia 
Detecta agendamentos onde o cliente tem alergia ao produto do serviço.

?- agendamento(C, F, S, D), agendamento_alergico(C, S).

Resultado esperado:
  C=maria, F=carla, S=coloracao, D=terca  ← CONFLITO! maria é alérgica a amonia


CONSULTA 3: Valor final com desconto por nível 
Mostra quanto cada cliente pagará pelo seu serviço agendado.

?- agendamento(C, _, S, _), valor_com_desconto(C, S, V),
   percentual_desconto(C, D),
   format("~w paga R$~2f no ~w (~w% desconto)~n", [C, V, S, D]),
   fail ; true.

Resultado esperado:
  maria    paga R$160.00 no coloracao       (20% desconto - ouro)
  joao     paga R$50.00  no corte_masculino (0%  desconto - bronze)
  lucia    paga R$56.00  no corte_feminino  (30% desconto - diamante)
  pedro    paga R$36.00  no barba           (10% desconto - prata)
  fernanda paga R$90.00  no hidratacao      (10% desconto - prata)
  beatriz  paga R$200.00 no luzes           (20% desconto - ouro)
  rafael   paga R$50.00  no corte_masculino (0%  desconto - bronze)


CONSULTA 4: Salário final dos funcionários 
Inclui bônus por cargo e hora extra (se aplicável).

?- salario_final(Nome, Salario, Tipo),
   format("~w: R$~2f (~w)~n", [Nome, Salario, Tipo]),
   fail ; true.

Resultado esperado:
  ana:   R$2875.00 (sem_hora_extra)
  bruno: R$2200.00 (sem_hora_extra)
  carla: R$3840.00 (sem_hora_extra)
  diana: R$3105.00+extra (com_hora_extra — 44h semanais)
  edu:   R$1890.00 (sem_hora_extra)
  fabio: R$2420.00 (sem_hora_extra)


CONSULTA 5: Quantas visitas faltam para o próximo nível 

?- cliente(C, _), visitas_para_proximo_nivel(C, F),
   format("~w: ~w visitas para o proximo nivel~n", [C, F]),
   fail ; true.

Resultado esperado:
  joao:     2 visitas (bronze → prata)
  maria:    25 visitas (ouro → diamante)
  pedro:    10 visitas (prata → ouro)
  lucia:    0 visitas (diamante — já no topo!)
  fernanda: 12 visitas (prata → ouro)
  rafael:   4 visitas (bronze → prata)
  beatriz:  32 visitas (ouro → diamante)

*/
