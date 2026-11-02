-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_da299f', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_45214f', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_f9f6db', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('Q', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('C', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_da299f', 'a_s_0d8033', 'a_s_45214f');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_0d8033', 'a_s_45214f');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_da299f', 'a_s_0d8033', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_da299f', 'a_s_fc4735', 'a_s_45214f');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_da299f', 'A', 'a_s_45214f');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'B');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_da299f', 'exp_fcc4f6', 'a_s_45214f');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('Q', 'exp_fcc4f6', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_da299f', 'a_s_0d8033', 'a_s_45214f', 'false')
('A', 'a_s_0d8033', 'a_s_45214f', 'false')
('a_s_da299f', 'a_s_0d8033', 'O', 'false')
('a_s_da299f', 'a_s_fc4735', 'a_s_45214f', 'false')
('a_s_da299f', 'A', 'a_s_45214f', 'false')
('@', 'exp_fcc4f6', 'B', 'false')
('a_s_da299f', 'exp_fcc4f6', 'a_s_45214f', 'false')
('Q', 'exp_fcc4f6', 'C', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(VR.VALUE > VL.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(VR.VALUE < VL.VALUE, 'true', 'false') ELSE IIF(VR.VALUE = VL.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS VR ON VR.NAME = E.RIGHT_OPERAND JOIN VARIABLES AS VL ON VL.NAME = E.LEFT_OPERAND;

/*
Prediction Result:
('a_s_da299f', 'a_s_0d8033', 'a_s_45214f', 'true')
('A', 'a_s_0d8033', 'a_s_45214f', 'false')
('a_s_da299f', 'a_s_0d8033', 'O', 'false')
('a_s_da299f', 'a_s_fc4735', 'a_s_45214f', 'true')
('a_s_da299f', 'A', 'a_s_45214f', 'true')
('@', 'exp_fcc4f6', 'B', 'false')
('a_s_da299f', 'exp_fcc4f6', 'a_s_45214f', 'true')
('Q', 'exp_fcc4f6', 'C', 'false')
*/