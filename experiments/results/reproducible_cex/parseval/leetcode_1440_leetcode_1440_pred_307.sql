-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_366677', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_260d05', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('I', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_190d2c', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('H', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('C', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_366677', 'a_s_702c67', 'a_s_260d05');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_702c67', 'a_s_260d05');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_366677', 'a_s_702c67', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_366677', 'a_s_aee8b5', 'a_s_260d05');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_366677', 'A', 'a_s_260d05');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_366677', 'exp_fcc4f6', 'a_s_260d05');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'exp_fcc4f6', 'H');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_366677', 'a_s_702c67', 'a_s_260d05', 'false')
('A', 'a_s_702c67', 'a_s_260d05', 'false')
('a_s_366677', 'a_s_702c67', 'A', 'false')
('a_s_366677', 'a_s_aee8b5', 'a_s_260d05', 'false')
('a_s_366677', 'A', 'a_s_260d05', 'false')
('a_s_366677', 'exp_fcc4f6', 'a_s_260d05', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('C', 'exp_fcc4f6', 'H', 'false')
*/

-- Prediction Query
WITH CTE AS (SELECT LEFT_OPERAND, T2.VALUE AS LEFT_VALUE, OPERATOR, RIGHT_OPERAND, T3.VALUE AS RIGHT_VALUE FROM EXPRESSIONS AS T1 LEFT JOIN VARIABLES AS T2 ON T1.LEFT_OPERAND = T2.NAME LEFT JOIN VARIABLES AS T3 ON T1.RIGHT_OPERAND = T3.NAME), CTE2 AS (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN LEFT_VALUE > RIGHT_VALUE WHEN OPERATOR = '=' THEN LEFT_VALUE = RIGHT_VALUE ELSE LEFT_VALUE < RIGHT_VALUE END AS VALUE FROM CTE) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN VALUE = 1 THEN 'true' ELSE 'false' END AS VALUE FROM CTE2;

/*
Prediction Result:
('a_s_366677', 'a_s_702c67', 'a_s_260d05', 'false')
('A', 'a_s_702c67', 'a_s_260d05', 'true')
('a_s_366677', 'a_s_702c67', 'A', 'false')
('a_s_366677', 'a_s_aee8b5', 'a_s_260d05', 'false')
('a_s_366677', 'A', 'a_s_260d05', 'false')
('a_s_366677', 'exp_fcc4f6', 'a_s_260d05', 'false')
('B', 'exp_fcc4f6', '@', 'true')
('C', 'exp_fcc4f6', 'H', 'false')
*/