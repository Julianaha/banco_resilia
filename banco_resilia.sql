SELECT * FROM banco_resilia.alunos;
/* INDICANDO FOREIGN KEY
-- referenciamento de id_aluno na tabela emails
alter table `emails`
add foreign key (`fk_id_aluno`)
references `alunos` (`id_aluno`);
-- referenciamento de email na tabela alunos
alter table `alunos`
add foreign key (`fk_id_email`)
references `emails` (`id_email`);
-- referenciamento de turma na tabela alunos
alter table `alunos`
add foreign key (`fk_id_turma`)
references `turmas`(`ID`);
-- referenciamento de aluno na tabela entregas
alter table `entregas`
add foreign key (`ID_ALUNO_FK`)
references `alunos` (`id_aluno`);
-- referenciamento de turma na tabela entregas
alter table `entregas`
add foreign key (`ID_TURMA_FK`)
references `turmas` (`ID`);
-- referenciamento de modulo na tabela entregas
alter table `entregas`
add foreign key (`ID_MODULO_FK`)
references `modulo` (`ID`);*/

-- QUERIES;

-- Alunos que entregaram o projeto do modulo 1 e estao com o conceito em pronto ou mais que pronto;
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

-- Quantos alunos tem em cada turma;
SELECT 
    `turmas`.TITULO AS 'nome_turma',
    COUNT(id_aluno) AS 'Quantidade_Alunos'
FROM
    alunos
        INNER JOIN
    `turmas` ON `alunos`.fk_id_turma = `turmas`.ID
GROUP BY `nome_turma`;

-- Quantos projetos no total (entre todas as turmas) foram entregues com o conceito 'Ainda nao esta pronto' e 'Quase la';
SELECT 
    CONCEITO, COUNT(CONCEITO) as 'Total_Projetos'
FROM
    `entregas`
WHERE
    CONCEITO = 'Quase la'
        OR CONCEITO = 'mais que pronto'
GROUP BY CONCEITO;
 -- Turma com a maior quantidade de projetos no mais que pronto;
 SELECT 
    CONCEITO, ID_TURMA_FK as 'Turma', COUNT(CONCEITO) as 'Quantidade_Projetos'
FROM
    `entregas`
WHERE
    CONCEITO = 'mais que pronto'
GROUP BY Turma;
