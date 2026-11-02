-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_f3a27c', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_f9fb9b', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('C', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('I', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_2220c9', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('B', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('D', -1980249628);

INSERT INTO "variables" ("name", "value") VALUES ('H', -734455130);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f3a27c', 'a_s_ae1b8a', 'a_s_f9fb9b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f3a27c', '<', 'a_s_f9fb9b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_ae1b8a', 'a_s_f9fb9b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f3a27c', 'a_s_ae1b8a', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f3a27c', 'a_s_ae1b8a', 'I');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f3a27c', 'a_s_6c26fd', 'a_s_f9fb9b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f3a27c', 'A', 'a_s_f9fb9b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f3a27c', 'exp_fcc4f6', 'a_s_f9fb9b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('H', 'exp_fcc4f6', 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_f3a27c', 'a_s_ae1b8a', 'a_s_f9fb9b', 'false')
('a_s_f3a27c', '<', 'a_s_f9fb9b', 'false')
('A', 'a_s_ae1b8a', 'a_s_f9fb9b', 'false')
('a_s_f3a27c', 'a_s_ae1b8a', 'O', 'false')
('a_s_f3a27c', 'a_s_ae1b8a', 'I', 'false')
('a_s_f3a27c', 'a_s_6c26fd', 'a_s_f9fb9b', 'false')
('a_s_f3a27c', 'A', 'a_s_f9fb9b', 'false')
('a_s_f3a27c', 'exp_fcc4f6', 'a_s_f9fb9b', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('H', 'exp_fcc4f6', 'D', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, IIF(OPERATOR = '>', IIF(VALUE1 > VALUE2, 'true', 'false'), IIF(OPERATOR = '<', IIF(VALUE1 < VALUE2, 'true', 'false'), IIF(VALUE1 = VALUE2, 'true', 'false'))) AS VALUE FROM (SELECT E.*, V.VALUE AS VALUE1, V1.VALUE AS VALUE2 FROM VARIABLES AS V JOIN EXPRESSIONS AS E ON E.LEFT_OPERAND = V.NAME JOIN VARIABLES AS V1 ON V1.NAME = E.RIGHT_OPERAND) AS FF;

/*
Prediction Result:
('a_s_f3a27c', 'a_s_ae1b8a', 'a_s_f9fb9b', 'true')
('a_s_f3a27c', '<', 'a_s_f9fb9b', 'false')
('A', 'a_s_ae1b8a', 'a_s_f9fb9b', 'false')
('a_s_f3a27c', 'a_s_ae1b8a', 'O', 'false')
('a_s_f3a27c', 'a_s_ae1b8a', 'I', 'false')
('a_s_f3a27c', 'a_s_6c26fd', 'a_s_f9fb9b', 'true')
('a_s_f3a27c', 'A', 'a_s_f9fb9b', 'true')
('a_s_f3a27c', 'exp_fcc4f6', 'a_s_f9fb9b', 'true')
('B', 'exp_fcc4f6', '@', 'false')
('H', 'exp_fcc4f6', 'D', 'false')
*/