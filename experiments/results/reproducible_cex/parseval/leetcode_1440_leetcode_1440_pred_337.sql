-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_b023df', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_92b9b3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('I', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('O', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_cff5b0', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('H', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b023df', 'a_s_d5a088', 'a_s_92b9b3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b023df', '<', 'a_s_92b9b3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_d5a088', 'a_s_92b9b3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b023df', 'a_s_d5a088', 'I');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_d5a088', 'a_s_92b9b3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b023df', 'a_s_d5a088', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b023df', 'a_s_8ad138', 'a_s_92b9b3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b023df', 'A', 'a_s_92b9b3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b023df', 'exp_fcc4f6', 'a_s_92b9b3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('H', 'exp_fcc4f6', '@');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_b023df', 'a_s_d5a088', 'a_s_92b9b3', 'false')
('a_s_b023df', '<', 'a_s_92b9b3', 'false')
('G', 'a_s_d5a088', 'a_s_92b9b3', 'false')
('a_s_b023df', 'a_s_d5a088', 'I', 'false')
('O', 'a_s_d5a088', 'a_s_92b9b3', 'false')
('a_s_b023df', 'a_s_d5a088', 'G', 'false')
('a_s_b023df', 'a_s_8ad138', 'a_s_92b9b3', 'false')
('a_s_b023df', 'A', 'a_s_92b9b3', 'false')
('a_s_b023df', 'exp_fcc4f6', 'a_s_92b9b3', 'false')
('H', 'exp_fcc4f6', '@', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN E.OPERATOR = '>' THEN IIF(VL.VALUE > VR.VALUE, 'true', 'false') WHEN E.OPERATOR = '<' THEN IIF(VL.VALUE < VR.VALUE, 'true', 'false') ELSE IIF(VL.VALUE = VR.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E CROSS JOIN VARIABLES AS VL JOIN VARIABLES AS VR ON E.LEFT_OPERAND = VL.NAME AND E.RIGHT_OPERAND = VR.NAME;

/*
Prediction Result:
('a_s_b023df', 'a_s_d5a088', 'a_s_92b9b3', 'true')
('a_s_b023df', '<', 'a_s_92b9b3', 'false')
('G', 'a_s_d5a088', 'a_s_92b9b3', 'false')
('a_s_b023df', 'a_s_d5a088', 'I', 'false')
('O', 'a_s_d5a088', 'a_s_92b9b3', 'false')
('a_s_b023df', 'a_s_d5a088', 'G', 'false')
('a_s_b023df', 'a_s_8ad138', 'a_s_92b9b3', 'true')
('a_s_b023df', 'A', 'a_s_92b9b3', 'true')
('a_s_b023df', 'exp_fcc4f6', 'a_s_92b9b3', 'true')
('H', 'exp_fcc4f6', '@', 'false')
*/