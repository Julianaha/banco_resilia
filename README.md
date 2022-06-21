# Banco de dados Resilia  <img width="20px" src="https://cdn-icons.flaticon.com/png/512/5732/premium/5732837.png?token=exp=1655833715~hmac=424cc33143a99f1ddb4578d99fe3ce94">

## Primeiros passos com MySQL 🐬

Neste projeto da sprint foi usado um modelo de banco de dados para a Resilia. Com os seguintes requisitos:

- [x] Criar uma nova entidade chamada “entregas”, essa entidade vai
receber um link com o repositório da entrega, o módulo do projeto,
quem é o aluno e qual o conceito daquele projeto (Ainda não está
pronto, Chegando lá, Pronto ou Mais que Pronto).

- [x] O cadastro de alunos deve permitir vários e-mails (quantos forem
necessários adicionar, não vamos colocar um limite)

Apos aplicar os ajustes no modelo de banco de dados e criar o banco de dados
vamos popular com dados fictícios e pensar nas seguintes queries SQL:

1. Saber quem são os alunos que entregaram o projeto do módulo 1 e
estão com o conceito em “Pronto” ou “Mais que pronto”

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

2. Consultar quantos alunos temos em cada turma
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

3. Quantos projetos no total (entre todas as turmas) foram entregues
com conceito “Ainda não está pronto” e “Chegando lá”

4. Qual a turma com a maior quantidade de projetos no “Mais que
pronto”
