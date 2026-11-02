-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_5e80a6', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_8c49a1', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('_', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_d2706a', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('R', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_5e80a6', 'a_s_d189f8', 'a_s_8c49a1');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_d189f8', 'a_s_8c49a1');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_5e80a6', 'a_s_d189f8', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_d189f8', 'a_s_8c49a1');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_5e80a6', 'a_s_8d547b', 'a_s_8c49a1');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_5e80a6', 'A', 'a_s_8c49a1');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_5e80a6', 'exp_fcc4f6', 'a_s_8c49a1');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'B');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'R');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_5e80a6', 'a_s_d189f8', 'a_s_8c49a1', 'false')
('G', 'a_s_d189f8', 'a_s_8c49a1', 'false')
('a_s_5e80a6', 'a_s_d189f8', 'A', 'false')
('O', 'a_s_d189f8', 'a_s_8c49a1', 'false')
('a_s_5e80a6', 'a_s_8d547b', 'a_s_8c49a1', 'false')
('a_s_5e80a6', 'A', 'a_s_8c49a1', 'false')
('a_s_5e80a6', 'exp_fcc4f6', 'a_s_8c49a1', 'false')
('@', 'exp_fcc4f6', 'B', 'false')
('`', 'exp_fcc4f6', 'R', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' AND A.VALUE > B.VALUE THEN 'true' WHEN OPERATOR = '>' AND A.VALUE <= B.VALUE THEN 'false' WHEN OPERATOR = '=' AND A.VALUE = B.VALUE THEN 'true' WHEN OPERATOR = '=' AND A.VALUE <> B.VALUE THEN 'false' WHEN OPERATOR = '<' AND A.VALUE < B.VALUE THEN 'true' WHEN OPERATOR = '<' AND A.VALUE >= B.VALUE THEN 'false' ELSE NULL END AS VALUE FROM EXPRESSIONS JOIN VARIABLES AS A ON EXPRESSIONS.LEFT_OPERAND = A.NAME JOIN VARIABLES AS B ON EXPRESSIONS.RIGHT_OPERAND = B.NAME;

/*
Prediction Result:
('a_s_5e80a6', 'a_s_d189f8', 'a_s_8c49a1', None)
('G', 'a_s_d189f8', 'a_s_8c49a1', None)
('a_s_5e80a6', 'a_s_d189f8', 'A', None)
('O', 'a_s_d189f8', 'a_s_8c49a1', None)
('a_s_5e80a6', 'a_s_8d547b', 'a_s_8c49a1', None)
('a_s_5e80a6', 'A', 'a_s_8c49a1', None)
('a_s_5e80a6', 'exp_fcc4f6', 'a_s_8c49a1', None)
('@', 'exp_fcc4f6', 'B', None)
('`', 'exp_fcc4f6', 'R', None)
*/