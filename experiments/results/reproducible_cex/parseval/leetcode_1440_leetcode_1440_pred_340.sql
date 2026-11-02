-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_905ad3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_260e71', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('I', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('O', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_7f977d', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('@', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_905ad3', 'a_s_3036c0', 'a_s_260e71');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_905ad3', '<', 'a_s_260e71');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_3036c0', 'a_s_260e71');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_905ad3', 'a_s_3036c0', 'I');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_3036c0', 'a_s_260e71');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_905ad3', 'a_s_3036c0', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_905ad3', 'a_s_2e656b', 'a_s_260e71');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_905ad3', 'A', 'a_s_260e71');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_905ad3', 'exp_fcc4f6', 'a_s_260e71');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_905ad3', 'a_s_3036c0', 'a_s_260e71', 'false')
('a_s_905ad3', '<', 'a_s_260e71', 'false')
('G', 'a_s_3036c0', 'a_s_260e71', 'false')
('a_s_905ad3', 'a_s_3036c0', 'I', 'false')
('O', 'a_s_3036c0', 'a_s_260e71', 'false')
('a_s_905ad3', 'a_s_3036c0', 'O', 'false')
('a_s_905ad3', 'a_s_2e656b', 'a_s_260e71', 'false')
('a_s_905ad3', 'A', 'a_s_260e71', 'false')
('a_s_905ad3', 'exp_fcc4f6', 'a_s_260e71', 'false')
('@', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
WITH STEP1 AS (SELECT LEFT_OPERAND, E.OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN VAR1.VALUE > VAR2.VALUE WHEN OPERATOR = '<' THEN VAR1.VALUE > VAR2.VALUE WHEN OPERATOR = '=' THEN VAR1.VALUE = VAR2.VALUE END AS CASE_ FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS VAR1 ON E.LEFT_OPERAND = VAR1.NAME LEFT JOIN VARIABLES AS VAR2 ON E.RIGHT_OPERAND = VAR2.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN CASE_ = 0 THEN 'false' ELSE 'true' END AS VALUE FROM STEP1;

/*
Prediction Result:
('a_s_905ad3', 'a_s_3036c0', 'a_s_260e71', 'true')
('a_s_905ad3', '<', 'a_s_260e71', 'false')
('G', 'a_s_3036c0', 'a_s_260e71', 'true')
('a_s_905ad3', 'a_s_3036c0', 'I', 'true')
('O', 'a_s_3036c0', 'a_s_260e71', 'true')
('a_s_905ad3', 'a_s_3036c0', 'O', 'true')
('a_s_905ad3', 'a_s_2e656b', 'a_s_260e71', 'true')
('a_s_905ad3', 'A', 'a_s_260e71', 'true')
('a_s_905ad3', 'exp_fcc4f6', 'a_s_260e71', 'true')
('@', 'exp_fcc4f6', 'B', 'true')
*/