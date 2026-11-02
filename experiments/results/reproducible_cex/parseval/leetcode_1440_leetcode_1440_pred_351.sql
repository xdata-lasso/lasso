-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_2dcea3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_e3fee3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('_', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_d110fd', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('D', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2dcea3', 'a_s_72fe5f', 'a_s_e3fee3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2dcea3', '<', 'a_s_e3fee3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_72fe5f', 'a_s_e3fee3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2dcea3', 'a_s_72fe5f', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('_', 'a_s_72fe5f', 'a_s_e3fee3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2dcea3', 'a_s_d5b700', 'a_s_e3fee3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2dcea3', 'A', 'a_s_e3fee3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2dcea3', 'exp_fcc4f6', 'a_s_e3fee3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'D');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_2dcea3', 'a_s_72fe5f', 'a_s_e3fee3', 'false')
('a_s_2dcea3', '<', 'a_s_e3fee3', 'false')
('O', 'a_s_72fe5f', 'a_s_e3fee3', 'false')
('a_s_2dcea3', 'a_s_72fe5f', 'A', 'false')
('_', 'a_s_72fe5f', 'a_s_e3fee3', 'false')
('a_s_2dcea3', 'a_s_d5b700', 'a_s_e3fee3', 'false')
('a_s_2dcea3', 'A', 'a_s_e3fee3', 'false')
('a_s_2dcea3', 'exp_fcc4f6', 'a_s_e3fee3', 'false')
('@', 'exp_fcc4f6', 'D', 'false')
('`', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT A.LEFT_OPERAND, A.OPERATOR, A.RIGHT_OPERAND, CASE A.OPERATOR WHEN '=' THEN IIF(B.VALUE = C.VALUE, 'true', 'false') WHEN '>' THEN IIF(B.VALUE > C.VALUE, 'true', 'false') WHEN '<' THEN IIF(B.VALUE < C.VALUE, 'true', 'false') ELSE NULL END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Prediction Result:
('a_s_2dcea3', 'a_s_72fe5f', 'a_s_e3fee3', None)
('a_s_2dcea3', '<', 'a_s_e3fee3', 'false')
('O', 'a_s_72fe5f', 'a_s_e3fee3', None)
('a_s_2dcea3', 'a_s_72fe5f', 'A', None)
('_', 'a_s_72fe5f', 'a_s_e3fee3', None)
('a_s_2dcea3', 'a_s_d5b700', 'a_s_e3fee3', None)
('a_s_2dcea3', 'A', 'a_s_e3fee3', None)
('a_s_2dcea3', 'exp_fcc4f6', 'a_s_e3fee3', None)
('@', 'exp_fcc4f6', 'D', None)
('`', 'exp_fcc4f6', 'B', None)
*/