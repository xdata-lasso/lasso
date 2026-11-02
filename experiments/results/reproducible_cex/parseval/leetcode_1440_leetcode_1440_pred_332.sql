-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_501d44', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_9172cb', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('I', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_e2fb35', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('C', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('!', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('D', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_501d44', 'a_s_d1312b', 'a_s_9172cb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_501d44', '<', 'a_s_9172cb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_d1312b', 'a_s_9172cb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_501d44', 'a_s_d1312b', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_501d44', 'a_s_a8e8a1', 'a_s_9172cb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_501d44', 'A', 'a_s_9172cb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_501d44', 'exp_fcc4f6', 'a_s_9172cb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'C');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('!', 'exp_fcc4f6', 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_501d44', 'a_s_d1312b', 'a_s_9172cb', 'false')
('a_s_501d44', '<', 'a_s_9172cb', 'false')
('A', 'a_s_d1312b', 'a_s_9172cb', 'false')
('a_s_501d44', 'a_s_d1312b', 'A', 'false')
('a_s_501d44', 'a_s_a8e8a1', 'a_s_9172cb', 'false')
('a_s_501d44', 'A', 'a_s_9172cb', 'false')
('a_s_501d44', 'exp_fcc4f6', 'a_s_9172cb', 'false')
('@', 'exp_fcc4f6', 'C', 'false')
('!', 'exp_fcc4f6', 'D', 'false')
*/

-- Prediction Query
WITH VARIABLES_JOIN AS (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, B.VALUE AS LEFT_VALUE, C.VALUE AS RIGHT_VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '=' THEN CASE WHEN LEFT_VALUE = RIGHT_VALUE THEN 'true' ELSE 'false' END WHEN OPERATOR = '>' THEN CASE WHEN LEFT_VALUE > RIGHT_VALUE THEN 'true' ELSE 'false' END WHEN OPERATOR = '<' THEN CASE WHEN LEFT_VALUE < RIGHT_VALUE THEN 'true' ELSE 'false' END END AS VALUE FROM VARIABLES_JOIN;

/*
Prediction Result:
('a_s_501d44', 'a_s_d1312b', 'a_s_9172cb', None)
('a_s_501d44', '<', 'a_s_9172cb', 'false')
('A', 'a_s_d1312b', 'a_s_9172cb', None)
('a_s_501d44', 'a_s_d1312b', 'A', None)
('a_s_501d44', 'a_s_a8e8a1', 'a_s_9172cb', None)
('a_s_501d44', 'A', 'a_s_9172cb', None)
('a_s_501d44', 'exp_fcc4f6', 'a_s_9172cb', None)
('@', 'exp_fcc4f6', 'C', None)
('!', 'exp_fcc4f6', 'D', None)
*/