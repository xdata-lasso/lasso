-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_2f5d8b', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_16f7cf', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_b1c01f', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('H', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('E', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2f5d8b', 'a_s_5507dd', 'a_s_16f7cf');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2f5d8b', '<', 'a_s_16f7cf');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_5507dd', 'a_s_16f7cf');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2f5d8b', 'a_s_5507dd', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2f5d8b', 'a_s_3eb27e', 'a_s_16f7cf');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2f5d8b', 'A', 'a_s_16f7cf');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2f5d8b', 'exp_fcc4f6', 'a_s_16f7cf');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('H', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'E');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_2f5d8b', 'a_s_5507dd', 'a_s_16f7cf', 'false')
('a_s_2f5d8b', '<', 'a_s_16f7cf', 'false')
('G', 'a_s_5507dd', 'a_s_16f7cf', 'false')
('a_s_2f5d8b', 'a_s_5507dd', 'A', 'false')
('a_s_2f5d8b', 'a_s_3eb27e', 'a_s_16f7cf', 'false')
('a_s_2f5d8b', 'A', 'a_s_16f7cf', 'false')
('a_s_2f5d8b', 'exp_fcc4f6', 'a_s_16f7cf', 'false')
('H', 'exp_fcc4f6', '@', 'false')
('`', 'exp_fcc4f6', 'E', 'false')
*/

-- Prediction Query
WITH T1 AS (SELECT CASE WHEN LEFT_OPERAND = V1.NAME THEN V1.VALUE END AS LEFT_VALUE, CASE WHEN RIGHT_OPERAND = V2.NAME THEN V2.VALUE END AS RIGHT_VALUE, E.* FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME LEFT JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(LEFT_VALUE > RIGHT_VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(LEFT_VALUE < RIGHT_VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(LEFT_VALUE = RIGHT_VALUE, 'true', 'false') END AS VALUE FROM T1;

/*
Prediction Result:
('a_s_2f5d8b', 'a_s_5507dd', 'a_s_16f7cf', None)
('a_s_2f5d8b', '<', 'a_s_16f7cf', 'false')
('G', 'a_s_5507dd', 'a_s_16f7cf', None)
('a_s_2f5d8b', 'a_s_5507dd', 'A', None)
('a_s_2f5d8b', 'a_s_3eb27e', 'a_s_16f7cf', None)
('a_s_2f5d8b', 'A', 'a_s_16f7cf', None)
('a_s_2f5d8b', 'exp_fcc4f6', 'a_s_16f7cf', None)
('H', 'exp_fcc4f6', '@', None)
('`', 'exp_fcc4f6', 'E', None)
*/