-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_666000', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_3c5a8c', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('C', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_c632f8', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('K', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('"', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_666000', 'a_s_fa6c39', 'a_s_3c5a8c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_666000', '<', 'a_s_3c5a8c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_fa6c39', 'a_s_3c5a8c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_666000', 'a_s_fa6c39', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'a_s_fa6c39', 'a_s_3c5a8c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_666000', 'a_s_58ba94', 'a_s_3c5a8c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_666000', 'A', 'a_s_3c5a8c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_666000', 'exp_fcc4f6', 'a_s_3c5a8c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('K', 'exp_fcc4f6', '"');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_666000', 'a_s_fa6c39', 'a_s_3c5a8c', 'false')
('a_s_666000', '<', 'a_s_3c5a8c', 'false')
('G', 'a_s_fa6c39', 'a_s_3c5a8c', 'false')
('a_s_666000', 'a_s_fa6c39', 'G', 'false')
('C', 'a_s_fa6c39', 'a_s_3c5a8c', 'false')
('a_s_666000', 'a_s_58ba94', 'a_s_3c5a8c', 'false')
('a_s_666000', 'A', 'a_s_3c5a8c', 'false')
('a_s_666000', 'exp_fcc4f6', 'a_s_3c5a8c', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('K', 'exp_fcc4f6', '"', 'false')
*/

-- Prediction Query
WITH TEMP1 AS (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, V.VALUE AS LEFT_VALUE FROM EXPRESSIONS LEFT JOIN VARIABLES AS V ON LEFT_OPERAND = NAME), TEMP2 AS (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, LEFT_VALUE, V.VALUE AS RIGHT_VALUE FROM TEMP1 LEFT JOIN VARIABLES AS V ON RIGHT_OPERAND = NAME), TEMP3 AS (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN (LEFT_VALUE > RIGHT_VALUE) WHEN OPERATOR = '<' THEN (LEFT_VALUE < RIGHT_VALUE) ELSE (LEFT_VALUE = RIGHT_VALUE) END AS NUMB FROM TEMP2) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN NUMB = 1 THEN 'true' ELSE 'false' END AS VALUE FROM TEMP3;

/*
Prediction Result:
('a_s_666000', 'a_s_fa6c39', 'a_s_3c5a8c', 'true')
('a_s_666000', '<', 'a_s_3c5a8c', 'false')
('G', 'a_s_fa6c39', 'a_s_3c5a8c', 'false')
('a_s_666000', 'a_s_fa6c39', 'G', 'false')
('C', 'a_s_fa6c39', 'a_s_3c5a8c', 'false')
('a_s_666000', 'a_s_58ba94', 'a_s_3c5a8c', 'true')
('a_s_666000', 'A', 'a_s_3c5a8c', 'true')
('a_s_666000', 'exp_fcc4f6', 'a_s_3c5a8c', 'true')
('B', 'exp_fcc4f6', '@', 'false')
('K', 'exp_fcc4f6', '"', 'false')
*/