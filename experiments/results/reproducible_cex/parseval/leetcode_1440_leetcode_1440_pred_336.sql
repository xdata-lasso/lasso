-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_112bb2', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_13e0fb', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_0878f6', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('P', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('H', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_112bb2', 'a_s_9a7bcd', 'a_s_13e0fb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_112bb2', '<', 'a_s_13e0fb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_9a7bcd', 'a_s_13e0fb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_112bb2', 'a_s_9a7bcd', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_112bb2', 'a_s_9a7bcd', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_112bb2', 'a_s_7261da', 'a_s_13e0fb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_112bb2', 'A', 'a_s_13e0fb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_112bb2', 'exp_fcc4f6', 'a_s_13e0fb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('P', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('H', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_112bb2', 'a_s_9a7bcd', 'a_s_13e0fb', 'false')
('a_s_112bb2', '<', 'a_s_13e0fb', 'false')
('G', 'a_s_9a7bcd', 'a_s_13e0fb', 'false')
('a_s_112bb2', 'a_s_9a7bcd', 'G', 'false')
('a_s_112bb2', 'a_s_9a7bcd', 'O', 'false')
('a_s_112bb2', 'a_s_7261da', 'a_s_13e0fb', 'false')
('a_s_112bb2', 'A', 'a_s_13e0fb', 'false')
('a_s_112bb2', 'exp_fcc4f6', 'a_s_13e0fb', 'false')
('P', 'exp_fcc4f6', '@', 'false')
('H', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
WITH TB AS (SELECT E.*, V.VALUE AS LEFT_V, V1.VALUE AS RIGHT_V FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V ON E.LEFT_OPERAND = V.NAME LEFT JOIN VARIABLES AS V1 ON E.RIGHT_OPERAND = V1.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, (CASE WHEN OPERATOR = '>' THEN IIF(LEFT_V > RIGHT_V, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(LEFT_V = RIGHT_V, 'true', 'false') ELSE IIF(LEFT_V < RIGHT_V, 'true', 'false') END) AS VALUE FROM TB;

/*
Prediction Result:
('a_s_112bb2', 'a_s_9a7bcd', 'a_s_13e0fb', 'false')
('a_s_112bb2', '<', 'a_s_13e0fb', 'false')
('G', 'a_s_9a7bcd', 'a_s_13e0fb', 'true')
('a_s_112bb2', 'a_s_9a7bcd', 'G', 'false')
('a_s_112bb2', 'a_s_9a7bcd', 'O', 'false')
('a_s_112bb2', 'a_s_7261da', 'a_s_13e0fb', 'false')
('a_s_112bb2', 'A', 'a_s_13e0fb', 'false')
('a_s_112bb2', 'exp_fcc4f6', 'a_s_13e0fb', 'false')
('P', 'exp_fcc4f6', '@', 'true')
('H', 'exp_fcc4f6', '`', 'true')
*/