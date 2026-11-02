-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_9e07c0', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_ec6df7', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('_', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('G', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_1d32f3', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9e07c0', 'a_s_a39dc8', 'a_s_ec6df7');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9e07c0', '<', 'a_s_ec6df7');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_a39dc8', 'a_s_ec6df7');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9e07c0', 'a_s_a39dc8', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('_', 'a_s_a39dc8', 'a_s_ec6df7');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9e07c0', 'a_s_a39dc8', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9e07c0', 'a_s_09f98f', 'a_s_ec6df7');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9e07c0', 'A', 'a_s_ec6df7');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9e07c0', 'exp_fcc4f6', 'a_s_ec6df7');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_9e07c0', 'a_s_a39dc8', 'a_s_ec6df7', 'false')
('a_s_9e07c0', '<', 'a_s_ec6df7', 'false')
('O', 'a_s_a39dc8', 'a_s_ec6df7', 'false')
('a_s_9e07c0', 'a_s_a39dc8', 'O', 'false')
('_', 'a_s_a39dc8', 'a_s_ec6df7', 'false')
('a_s_9e07c0', 'a_s_a39dc8', 'G', 'false')
('a_s_9e07c0', 'a_s_09f98f', 'a_s_ec6df7', 'false')
('a_s_9e07c0', 'A', 'a_s_ec6df7', 'false')
('a_s_9e07c0', 'exp_fcc4f6', 'a_s_ec6df7', 'false')
('@', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(LFT.VALUE > RGT.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(LFT.VALUE < RGT.VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(LFT.VALUE = RGT.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS LFT ON LFT.NAME = E.LEFT_OPERAND JOIN VARIABLES AS RGT ON RGT.NAME = E.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_9e07c0', 'a_s_a39dc8', 'a_s_ec6df7', None)
('a_s_9e07c0', '<', 'a_s_ec6df7', 'false')
('O', 'a_s_a39dc8', 'a_s_ec6df7', None)
('a_s_9e07c0', 'a_s_a39dc8', 'O', None)
('_', 'a_s_a39dc8', 'a_s_ec6df7', None)
('a_s_9e07c0', 'a_s_a39dc8', 'G', None)
('a_s_9e07c0', 'a_s_09f98f', 'a_s_ec6df7', None)
('a_s_9e07c0', 'A', 'a_s_ec6df7', None)
('a_s_9e07c0', 'exp_fcc4f6', 'a_s_ec6df7', None)
('@', 'exp_fcc4f6', '`', None)
*/