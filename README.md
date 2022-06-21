# Banco de dados Resilia  <img width="20px" src="https://cdn-icons.flaticon.com/png/512/5732/premium/5732837.png?token=exp=1655833715~hmac=424cc33143a99f1ddb4578d99fe3ce94">

## Primeiros passos com MySQL 🐬

Neste projeto da sprint foi usado um modelo de banco de dados para a Resilia. Com os seguintes requisitos:

- [x] Criar uma nova entidade chamada “entregas”, essa entidade vai
receber um link com o repositório da entrega, o módulo do projeto,
quem é o aluno e qual o conceito daquele projeto (Ainda não está
pronto, Chegando lá, Pronto ou Mais que Pronto).

- [x] O cadastro de alunos deve permitir vários e-mails (quantos forem
necessários adicionar, não vamos colocar um limite)

<img width="400" alt="Captura de Tela 2022-06-21 às 14 58 01" src="https://user-images.githubusercontent.com/65184920/174867276-b920b529-a528-4f68-89b1-997d3a7b9374.png">

Apos aplicar os ajustes no modelo de banco de dados e criar o banco de dados
vamos popular com dados fictícios e pensar nas seguintes queries SQL:

**1. Saber quem são os alunos que entregaram o projeto do módulo 1 e
estão com o conceito em “Pronto” ou “Mais que pronto”**

``` sql
SELECT 
    `alunos`.nome,
    `alunos`.fk_id_turma as 'turma',
    `entregas`.LINK_REPOSITORIO,
    `entregas`.ID_MODULO_FK as 'modulo',
    `entregas`.CONCEITO
FROM
    `alunos`
        INNER JOIN
    `entregas` ON `entregas`.ID_ALUNO_FK = `alunos`.id_aluno
        INNER JOIN
    `modulo` ON `entregas`.ID_MODULO_FK = `modulo`.ID
WHERE
    `entregas`.ID_MODULO_FK = 1 IN (`entregas`.CONCEITO = 'Pronto' , `entregas`.CONCEITO = 'mais que pronto');
 ```
    
<img width="400" alt="Captura de Tela 2022-06-21 às 14 10 27" src="https://user-images.githubusercontent.com/65184920/174860320-6097ca7f-5523-45c1-8411-c4d2161e0ef2.png">

**2. Consultar quantos alunos temos em cada turma**
```sql
SELECT 
    `turmas`.TITULO AS 'nome_turma',
    COUNT(id_aluno) AS 'Quantidade_Alunos'
FROM
    alunos
        INNER JOIN
    `turmas` ON `alunos`.fk_id_turma = `turmas`.ID
GROUP BY `nome_turma`;
```
<img width="400" alt="Captura de Tela 2022-06-21 às 14 11 05" src="https://user-images.githubusercontent.com/65184920/174862983-c1ee4e45-2d7f-4c28-a2a5-2ea5aa998d43.png">

**3. Quantos projetos no total (entre todas as turmas) foram entregues
com conceito “Ainda não está pronto” e “Quase lá”**

```sql
SELECT 
    CONCEITO, COUNT(CONCEITO) as 'Total_Projetos'
FROM
    `entregas`
WHERE
    CONCEITO = 'Quase lá'
        OR CONCEITO = 'Ainda não está pronto'
GROUP BY CONCEITO; 
```
<img width="400" alt="Captura de Tela 2022-06-21 às 14 43 15" src="https://user-images.githubusercontent.com/65184920/174865070-4f38082f-be59-44b2-a5d8-bb98dfedccf8.png">

**4. Qual a turma com a maior quantidade de projetos no “Mais que
pronto”**

```sql
SELECT 
    CONCEITO, ID_TURMA_FK as 'Turma', COUNT(CONCEITO) as 'Quantidade_Projetos'
FROM
    `entregas`
WHERE
    CONCEITO = 'mais que pronto'
GROUP BY Turma;
```

<img width="400" alt="Captura de Tela 2022-06-21 às 14 49 58" src="https://user-images.githubusercontent.com/65184920/174865852-44d39ad5-08f0-4761-85ea-a37497aa38d1.png">

[⬆ Voltar ao topo](#banco-de-dados-resilia--)
