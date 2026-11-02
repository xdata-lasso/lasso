-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_c38ab1', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_2d71d4', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('_', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_6223a3', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('D', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c38ab1', 'a_s_036021', 'a_s_2d71d4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_036021', 'a_s_2d71d4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c38ab1', 'a_s_036021', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c38ab1', 'a_s_1b45e4', 'a_s_2d71d4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c38ab1', 'A', 'a_s_2d71d4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c38ab1', 'exp_fcc4f6', 'a_s_2d71d4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('E', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_c38ab1', 'a_s_036021', 'a_s_2d71d4', 'false')
('A', 'a_s_036021', 'a_s_2d71d4', 'false')
('a_s_c38ab1', 'a_s_036021', 'A', 'false')
('a_s_c38ab1', 'a_s_1b45e4', 'a_s_2d71d4', 'false')
('a_s_c38ab1', 'A', 'a_s_2d71d4', 'false')
('a_s_c38ab1', 'exp_fcc4f6', 'a_s_2d71d4', 'false')
('E', 'exp_fcc4f6', '@', 'false')
('D', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
SELECT T1.LEFT_OPERAND, T1.OPERATOR, T1.RIGHT_OPERAND, (CASE WHEN T1.OPERATOR = '=' THEN (CASE WHEN (T1.LEFT_VAL = T1.RIGHT_VAL) = 0 THEN 'false' ELSE 'true' END) WHEN T1.OPERATOR = '>' THEN (CASE WHEN (T1.LEFT_VAL > T1.RIGHT_VAL) = 0 THEN 'false' ELSE 'true' END) ELSE (CASE WHEN (T1.LEFT_VAL < T1.RIGHT_VAL) = 0 THEN 'false' ELSE 'true' END) END) AS VALUE FROM (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, (CASE WHEN NOT LEFT_OPERAND IS NULL THEN (SELECT VALUE FROM VARIABLES WHERE NAME = LEFT_OPERAND) ELSE 0 END) AS LEFT_VAL, (CASE WHEN NOT RIGHT_OPERAND IS NULL THEN (SELECT VALUE FROM VARIABLES WHERE NAME = RIGHT_OPERAND) ELSE 0 END) AS RIGHT_VAL FROM EXPRESSIONS) AS T1;

/*
Prediction Result:
('a_s_c38ab1', 'a_s_036021', 'a_s_2d71d4', 'false')
('A', 'a_s_036021', 'a_s_2d71d4', 'true')
('a_s_c38ab1', 'a_s_036021', 'A', 'false')
('a_s_c38ab1', 'a_s_1b45e4', 'a_s_2d71d4', 'false')
('a_s_c38ab1', 'A', 'a_s_2d71d4', 'false')
('a_s_c38ab1', 'exp_fcc4f6', 'a_s_2d71d4', 'false')
('E', 'exp_fcc4f6', '@', 'true')
('D', 'exp_fcc4f6', '`', 'false')
*/