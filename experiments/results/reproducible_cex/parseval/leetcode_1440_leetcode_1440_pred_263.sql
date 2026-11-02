-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_f6f72d', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_833645', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('I', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_3564be', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('Q', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f6f72d', 'a_s_381ba1', 'a_s_833645');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_381ba1', 'a_s_833645');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f6f72d', 'a_s_381ba1', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f6f72d', 'a_s_7d6576', 'a_s_833645');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f6f72d', 'A', 'a_s_833645');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f6f72d', 'exp_fcc4f6', 'a_s_833645');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'Q');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_f6f72d', 'a_s_381ba1', 'a_s_833645', 'false')
('A', 'a_s_381ba1', 'a_s_833645', 'false')
('a_s_f6f72d', 'a_s_381ba1', 'A', 'false')
('a_s_f6f72d', 'a_s_7d6576', 'a_s_833645', 'false')
('a_s_f6f72d', 'A', 'a_s_833645', 'false')
('a_s_f6f72d', 'exp_fcc4f6', 'a_s_833645', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('`', 'exp_fcc4f6', 'Q', 'false')
*/

-- Prediction Query
WITH C1 AS (SELECT LEFT_OPERAND, VALUE AS LEFT_VALUE, OPERATOR, RIGHT_OPERAND FROM EXPRESSIONS AS E JOIN VARIABLES AS V ON E.LEFT_OPERAND = V.NAME), C2 AS (SELECT C1.LEFT_OPERAND, C1.LEFT_VALUE, C1.OPERATOR, C1.RIGHT_OPERAND, V.VALUE AS RIGHT_VALUE FROM C1 JOIN VARIABLES AS V ON C1.RIGHT_OPERAND = V.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '=' THEN IIF(LEFT_VALUE = RIGHT_VALUE, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(LEFT_VALUE > RIGHT_VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(LEFT_VALUE < RIGHT_VALUE, 'true', 'false') END AS VALUE FROM C2;

/*
Prediction Result:
('a_s_f6f72d', 'a_s_381ba1', 'a_s_833645', None)
('A', 'a_s_381ba1', 'a_s_833645', None)
('a_s_f6f72d', 'a_s_381ba1', 'A', None)
('a_s_f6f72d', 'a_s_7d6576', 'a_s_833645', None)
('a_s_f6f72d', 'A', 'a_s_833645', None)
('a_s_f6f72d', 'exp_fcc4f6', 'a_s_833645', None)
('B', 'exp_fcc4f6', '@', None)
('`', 'exp_fcc4f6', 'Q', None)
*/