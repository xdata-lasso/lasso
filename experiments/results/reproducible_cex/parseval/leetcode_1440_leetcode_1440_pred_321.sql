-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_061dc7', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_036c31', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_ceec74', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('Q', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_061dc7', 'a_s_84d66f', 'a_s_036c31');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_061dc7', '<', 'a_s_036c31');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_84d66f', 'a_s_036c31');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_061dc7', 'a_s_84d66f', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_84d66f', 'a_s_036c31');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_061dc7', 'a_s_84d66f', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_061dc7', 'a_s_36ab9a', 'a_s_036c31');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_061dc7', 'A', 'a_s_036c31');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('E', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_061dc7', 'exp_fcc4f6', 'a_s_036c31');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('Q', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_061dc7', 'a_s_84d66f', 'a_s_036c31', 'false')
('a_s_061dc7', '<', 'a_s_036c31', 'false')
('G', 'a_s_84d66f', 'a_s_036c31', 'false')
('a_s_061dc7', 'a_s_84d66f', 'O', 'false')
('O', 'a_s_84d66f', 'a_s_036c31', 'false')
('a_s_061dc7', 'a_s_84d66f', 'G', 'false')
('a_s_061dc7', 'a_s_36ab9a', 'a_s_036c31', 'false')
('a_s_061dc7', 'A', 'a_s_036c31', 'false')
('E', 'exp_fcc4f6', '@', 'false')
('a_s_061dc7', 'exp_fcc4f6', 'a_s_036c31', 'false')
('Q', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
SELECT VL.NAME AS LEFT_OPERAND, E.OPERATOR, VR.NAME AS RIGHT_OPERAND, CASE WHEN OPERATOR = '<' THEN CASE WHEN VL.VALUE < VR.VALUE THEN 'true' ELSE 'false' END WHEN OPERATOR = '>' THEN CASE WHEN VL.VALUE > VR.VALUE THEN 'true' ELSE 'false' END WHEN OPERATOR = '=' THEN CASE WHEN VL.VALUE = VR.VALUE THEN 'true' ELSE 'false' END ELSE NULL END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS VR ON E.RIGHT_OPERAND = VR.NAME JOIN VARIABLES AS VL ON E.LEFT_OPERAND = VL.NAME;

/*
Prediction Result:
('a_s_061dc7', 'a_s_84d66f', 'a_s_036c31', None)
('a_s_061dc7', '<', 'a_s_036c31', 'false')
('G', 'a_s_84d66f', 'a_s_036c31', None)
('a_s_061dc7', 'a_s_84d66f', 'O', None)
('O', 'a_s_84d66f', 'a_s_036c31', None)
('a_s_061dc7', 'a_s_84d66f', 'G', None)
('a_s_061dc7', 'a_s_36ab9a', 'a_s_036c31', None)
('a_s_061dc7', 'A', 'a_s_036c31', None)
('E', 'exp_fcc4f6', '@', None)
('a_s_061dc7', 'exp_fcc4f6', 'a_s_036c31', None)
('Q', 'exp_fcc4f6', '`', None)
*/