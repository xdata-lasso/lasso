-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_e9cdd0', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_96ec72', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_4d4e92', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('C', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('H', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e9cdd0', 'a_s_6ce5b3', 'a_s_96ec72');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_6ce5b3', 'a_s_96ec72');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e9cdd0', 'a_s_6ce5b3', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e9cdd0', 'a_s_88835b', 'a_s_96ec72');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e9cdd0', 'A', 'a_s_96ec72');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e9cdd0', 'exp_fcc4f6', 'a_s_96ec72');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'C');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', 'H');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_e9cdd0', 'a_s_6ce5b3', 'a_s_96ec72', 'false')
('A', 'a_s_6ce5b3', 'a_s_96ec72', 'false')
('a_s_e9cdd0', 'a_s_6ce5b3', 'O', 'false')
('a_s_e9cdd0', 'a_s_88835b', 'a_s_96ec72', 'false')
('a_s_e9cdd0', 'A', 'a_s_96ec72', 'false')
('a_s_e9cdd0', 'exp_fcc4f6', 'a_s_96ec72', 'false')
('@', 'exp_fcc4f6', 'C', 'false')
('B', 'exp_fcc4f6', 'H', 'false')
*/

-- Prediction Query
SELECT EXP.*, CASE WHEN OPERATOR = '>' THEN IIF(VAR1.VALUE > VAR2.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(VAR2.VALUE > VAR1.VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(VAR2.VALUE = VAR1.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS EXP INNER JOIN VARIABLES AS VAR1 ON VAR1.NAME = EXP.LEFT_OPERAND INNER JOIN VARIABLES AS VAR2 ON VAR2.NAME = EXP.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_e9cdd0', 'a_s_6ce5b3', 'a_s_96ec72', None)
('A', 'a_s_6ce5b3', 'a_s_96ec72', None)
('a_s_e9cdd0', 'a_s_6ce5b3', 'O', None)
('a_s_e9cdd0', 'a_s_88835b', 'a_s_96ec72', None)
('a_s_e9cdd0', 'A', 'a_s_96ec72', None)
('a_s_e9cdd0', 'exp_fcc4f6', 'a_s_96ec72', None)
('@', 'exp_fcc4f6', 'C', None)
('B', 'exp_fcc4f6', 'H', None)
*/