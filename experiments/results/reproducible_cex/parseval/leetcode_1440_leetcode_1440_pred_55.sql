-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_e2b52d', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_ce82ee', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('_', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_01de7d', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('H', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('P', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e2b52d', 'a_s_2dc4bc', 'a_s_ce82ee');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_2dc4bc', 'a_s_ce82ee');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e2b52d', 'a_s_2dc4bc', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('_', 'a_s_2dc4bc', 'a_s_ce82ee');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e2b52d', 'a_s_d2bd53', 'a_s_ce82ee');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e2b52d', 'A', 'a_s_ce82ee');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e2b52d', 'exp_fcc4f6', 'a_s_ce82ee');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'H');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', 'P');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_e2b52d', 'a_s_2dc4bc', 'a_s_ce82ee', 'false')
('G', 'a_s_2dc4bc', 'a_s_ce82ee', 'false')
('a_s_e2b52d', 'a_s_2dc4bc', 'A', 'false')
('_', 'a_s_2dc4bc', 'a_s_ce82ee', 'false')
('a_s_e2b52d', 'a_s_d2bd53', 'a_s_ce82ee', 'false')
('a_s_e2b52d', 'A', 'a_s_ce82ee', 'false')
('a_s_e2b52d', 'exp_fcc4f6', 'a_s_ce82ee', 'false')
('@', 'exp_fcc4f6', 'H', 'false')
('B', 'exp_fcc4f6', 'P', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(LFT.VALUE > RGT.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(LFT.VALUE < RGT.VALUE, 'true', 'false') ELSE IIF(LFT.VALUE = RGT.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E INNER JOIN VARIABLES AS LFT ON E.LEFT_OPERAND = LFT.NAME INNER JOIN VARIABLES AS RGT ON E.RIGHT_OPERAND = RGT.NAME;

/*
Prediction Result:
('a_s_e2b52d', 'a_s_2dc4bc', 'a_s_ce82ee', 'true')
('G', 'a_s_2dc4bc', 'a_s_ce82ee', 'false')
('a_s_e2b52d', 'a_s_2dc4bc', 'A', 'true')
('_', 'a_s_2dc4bc', 'a_s_ce82ee', 'true')
('a_s_e2b52d', 'a_s_d2bd53', 'a_s_ce82ee', 'true')
('a_s_e2b52d', 'A', 'a_s_ce82ee', 'true')
('a_s_e2b52d', 'exp_fcc4f6', 'a_s_ce82ee', 'true')
('@', 'exp_fcc4f6', 'H', 'false')
('B', 'exp_fcc4f6', 'P', 'false')
*/