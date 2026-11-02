-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_22bec6', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_2bd2b0', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('I', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_69909a', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('P', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_22bec6', 'a_s_197248', 'a_s_2bd2b0');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_22bec6', '<', 'a_s_2bd2b0');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_197248', 'a_s_2bd2b0');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_22bec6', 'a_s_197248', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_22bec6', 'a_s_d2cf11', 'a_s_2bd2b0');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_22bec6', 'A', 'a_s_2bd2b0');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('P', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_22bec6', 'exp_fcc4f6', 'a_s_2bd2b0');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_22bec6', 'a_s_197248', 'a_s_2bd2b0', 'false')
('a_s_22bec6', '<', 'a_s_2bd2b0', 'false')
('A', 'a_s_197248', 'a_s_2bd2b0', 'false')
('a_s_22bec6', 'a_s_197248', 'A', 'false')
('a_s_22bec6', 'a_s_d2cf11', 'a_s_2bd2b0', 'false')
('a_s_22bec6', 'A', 'a_s_2bd2b0', 'false')
('P', 'exp_fcc4f6', '@', 'false')
('a_s_22bec6', 'exp_fcc4f6', 'a_s_2bd2b0', 'false')
('`', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
WITH VAR_EXPANDED AS (SELECT A.NAME AS LEFT_OPERAND, '>' AS OPERATOR, B.NAME AS RIGHT_OPERAND, CASE WHEN A.VALUE > B.VALUE THEN 'true' ELSE 'false' END AS EVALUATED_VALUE FROM VARIABLES AS A CROSS JOIN VARIABLES AS B UNION SELECT A.NAME AS LEFT_OPERAND, '<' AS OPERATOR, B.NAME AS RIGHT_OPERAND, CASE WHEN A.VALUE < B.VALUE THEN 'true' ELSE 'false' END AS EVALUATED_VALUE FROM VARIABLES AS A CROSS JOIN VARIABLES AS B UNION SELECT A.NAME AS LEFT_OPERAND, '=' AS OPERATOR, B.NAME AS RIGHT_OPERAND, CASE WHEN A.VALUE = B.VALUE THEN 'true' ELSE 'false' END AS EVALUATED_VALUE FROM VARIABLES AS A CROSS JOIN VARIABLES AS B) SELECT E.*, V.EVALUATED_VALUE AS VALUE FROM EXPRESSIONS AS E JOIN VAR_EXPANDED AS V ON E.LEFT_OPERAND = V.LEFT_OPERAND AND E.OPERATOR = V.OPERATOR AND E.RIGHT_OPERAND = V.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_22bec6', '<', 'a_s_2bd2b0', 'false')
*/