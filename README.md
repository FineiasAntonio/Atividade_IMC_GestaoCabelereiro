# CutLog: Intelligent Hair Management

Este repositório contém o sistema **CutLog**, uma solução de gestão inteligente para salões de beleza desenvolvida inteiramente em **Prolog**. O projeto foi criado como parte da disciplina de *Introdução à Matemática para Computação*.

O CutLog utiliza lógica de primeira ordem para automatizar decisões complexas que vão desde a segurança do cliente até a saúde financeira do estabelecimento.

O CutLog implementa um **Motor de Regras** que atende a requisitos reais de um negócio:

1.  **Protocolo de Segurança Ativo:** O sistema possui uma camada de validação que impede o agendamento de serviços químicos para clientes com alergias registradas. Se um serviço usa *Amônia* e o cliente é sensível a ela, o Prolog nega a operação automaticamente.
2.  **Motor de Fidelidade:** Classifica clientes dinamicamente em 4 níveis (Bronze, Prata, Ouro e Diamante) e calcula automaticamente o gatilho para o próximo nível.
3.  **Inteligência de Recomendação:** Sugere serviços com base no perfil de consumo e restrições de saúde, utilizando o predicado avançado `findall/3`.
4.  **Gestão de Recursos Humanos:** Cálculos complexos de salários que integram salário-base, bônus por categoria profissional e horas extras.

---

## Estrutura Lógica do Sistema

O código está organizado em seções modulares para facilitar a manutenção e leitura:

* **Fatos (Base de Dados):** Cadastro de funcionários (cargos, especialidades, horários), clientes (visitas, alergias) e serviços (preços, química envolvida).
* **Regras de Negócio:**
    * **Financeiro:** Cálculo de folha de pagamento e faturamento total.
    * **Fidelização:** Regras de descontos progressivos e metas de visitas.
    * **Validação:** O coração do sistema, utilizando conjunções e **negação por falha (`\+`)** para garantir agendamentos seguros.

---

## Atendimento aos Requisitos Técnicos

O projeto cumpre rigorosamente todos os itens solicitados no edital da disciplina:

| Requisito | Implementação |
| :--- | :--- |
| **Quantidade de Cláusulas** | Mais de 50 cláusulas entre fatos e regras complexas. |
| **Predicados Unários** | `funcionario_senior/1`, `cliente_fiel/1`. |
| **Predicados Binários** | `cargo_funcionario/2`, `percentual_desconto/2`. |
| **Predicados Ternários+** | `salario_final/3`, `agendamento_valido/4`. |
| **Operadores Lógicos** | Uso extensivo de Conjunção (`,`), Disjunção (`;`) e Negação (`\+`). |
| **Aritmética e Comparação** | Cálculos de bônus, descontos e validação de horas (> 40). |
| **Consultas** | Seção dedicada com 8 consultas que testam todos os fluxos do sistema. |

---

### Exemplos de Consultas Úteis:

* **Verificar se um agendamento é seguro e possível:**
    `?- agendamento_valido(joao, carla, coloracao, terca).`
* **Calcular o salário de um funcionário com bônus e extras:**
    `?- salario_final(diana, Total, Status).`
* **Verificar quantos atendimentos faltam para um cliente subir de nível:**
    `?- visitas_para_proximo_nivel(pedro, Faltam).`
