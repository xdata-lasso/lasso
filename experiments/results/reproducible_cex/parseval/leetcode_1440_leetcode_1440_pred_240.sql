-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_bc96c0', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_ebe9ed', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_83c86e', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('H', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('P', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_bc96c0', 'a_s_e72fd1', 'a_s_ebe9ed');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_e72fd1', 'a_s_ebe9ed');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_bc96c0', 'a_s_e72fd1', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_bc96c0', 'a_s_e72fd1', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_bc96c0', 'a_s_7e2866', 'a_s_ebe9ed');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_bc96c0', 'A', 'a_s_ebe9ed');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_bc96c0', 'exp_fcc4f6', 'a_s_ebe9ed');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('E', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('H', 'exp_fcc4f6', 'P');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_bc96c0', 'a_s_e72fd1', 'a_s_ebe9ed', 'false')
('O', 'a_s_e72fd1', 'a_s_ebe9ed', 'false')
('a_s_bc96c0', 'a_s_e72fd1', 'O', 'false')
('a_s_bc96c0', 'a_s_e72fd1', 'G', 'false')
('a_s_bc96c0', 'a_s_7e2866', 'a_s_ebe9ed', 'false')
('a_s_bc96c0', 'A', 'a_s_ebe9ed', 'false')
('a_s_bc96c0', 'exp_fcc4f6', 'a_s_ebe9ed', 'false')
('E', 'exp_fcc4f6', '@', 'false')
('H', 'exp_fcc4f6', 'P', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '<' THEN IIF(V1.VALUE < V2.VALUE, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(V1.VALUE > V2.VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(V1.VALUE = V2.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME LEFT JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_bc96c0', 'a_s_e72fd1', 'a_s_ebe9ed', None)
('O', 'a_s_e72fd1', 'a_s_ebe9ed', None)
('a_s_bc96c0', 'a_s_e72fd1', 'O', None)
('a_s_bc96c0', 'a_s_e72fd1', 'G', None)
('a_s_bc96c0', 'a_s_7e2866', 'a_s_ebe9ed', None)
('a_s_bc96c0', 'A', 'a_s_ebe9ed', None)
('a_s_bc96c0', 'exp_fcc4f6', 'a_s_ebe9ed', None)
('E', 'exp_fcc4f6', '@', None)
('H', 'exp_fcc4f6', 'P', None)
*/