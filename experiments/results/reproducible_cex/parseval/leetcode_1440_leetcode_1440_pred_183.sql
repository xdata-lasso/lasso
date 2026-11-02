-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_68a112', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_6dc475', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('_', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_c7a37c', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('I', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('Q', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_68a112', 'a_s_718d36', 'a_s_6dc475');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_68a112', '<', 'a_s_6dc475');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_718d36', 'a_s_6dc475');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_68a112', 'a_s_718d36', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_68a112', 'a_s_19e8f7', 'a_s_6dc475');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_68a112', 'A', 'a_s_6dc475');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_68a112', 'exp_fcc4f6', 'a_s_6dc475');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'I');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'Q');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_68a112', 'a_s_718d36', 'a_s_6dc475', 'false')
('a_s_68a112', '<', 'a_s_6dc475', 'false')
('A', 'a_s_718d36', 'a_s_6dc475', 'false')
('a_s_68a112', 'a_s_718d36', 'O', 'false')
('a_s_68a112', 'a_s_19e8f7', 'a_s_6dc475', 'false')
('a_s_68a112', 'A', 'a_s_6dc475', 'false')
('a_s_68a112', 'exp_fcc4f6', 'a_s_6dc475', 'false')
('@', 'exp_fcc4f6', 'I', 'false')
('`', 'exp_fcc4f6', 'Q', 'false')
*/

-- Prediction Query
WITH TEM AS (SELECT A.*, B.VALUE AS LEFT_VALUE FROM EXPRESSIONS AS A LEFT JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME), TEM1 AS (SELECT T.*, B.VALUE AS RIGHT_VALUE FROM TEM AS T LEFT JOIN VARIABLES AS B ON T.RIGHT_OPERAND = B.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN VALUE = 1 THEN 'true' ELSE 'false' END AS VALUE FROM (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN (LEFT_VALUE > RIGHT_VALUE) WHEN OPERATOR = '=' THEN (LEFT_VALUE = RIGHT_VALUE) ELSE (LEFT_VALUE < RIGHT_VALUE) END AS VALUE FROM TEM1) AS A;

/*
Prediction Result:
('a_s_68a112', 'a_s_718d36', 'a_s_6dc475', 'false')
('a_s_68a112', '<', 'a_s_6dc475', 'false')
('A', 'a_s_718d36', 'a_s_6dc475', 'true')
('a_s_68a112', 'a_s_718d36', 'O', 'false')
('a_s_68a112', 'a_s_19e8f7', 'a_s_6dc475', 'false')
('a_s_68a112', 'A', 'a_s_6dc475', 'false')
('a_s_68a112', 'exp_fcc4f6', 'a_s_6dc475', 'false')
('@', 'exp_fcc4f6', 'I', 'true')
('`', 'exp_fcc4f6', 'Q', 'false')
*/