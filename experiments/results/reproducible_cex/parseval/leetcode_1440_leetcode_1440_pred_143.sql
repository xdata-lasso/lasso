-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_97ea2a', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_12c5f2', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('I', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('G', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_7b1864', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('B', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('C', -1980249628);

INSERT INTO "variables" ("name", "value") VALUES ('#', -734455130);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_97ea2a', 'a_s_f2ee86', 'a_s_12c5f2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_f2ee86', 'a_s_12c5f2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_97ea2a', 'a_s_f2ee86', 'I');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_97ea2a', 'a_s_f2ee86', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_97ea2a', 'a_s_07a285', 'a_s_12c5f2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_97ea2a', 'A', 'a_s_12c5f2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_97ea2a', 'exp_fcc4f6', 'a_s_12c5f2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'B');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'exp_fcc4f6', '#');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_97ea2a', 'a_s_f2ee86', 'a_s_12c5f2', 'false')
('O', 'a_s_f2ee86', 'a_s_12c5f2', 'false')
('a_s_97ea2a', 'a_s_f2ee86', 'I', 'false')
('a_s_97ea2a', 'a_s_f2ee86', 'G', 'false')
('a_s_97ea2a', 'a_s_07a285', 'a_s_12c5f2', 'false')
('a_s_97ea2a', 'A', 'a_s_12c5f2', 'false')
('a_s_97ea2a', 'exp_fcc4f6', 'a_s_12c5f2', 'false')
('@', 'exp_fcc4f6', 'B', 'false')
('C', 'exp_fcc4f6', '#', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN CASE WHEN LEFT_VALUE > RIGHT_VALUE THEN 'true' ELSE 'false' END WHEN OPERATOR = '<' THEN CASE WHEN LEFT_VALUE < RIGHT_VALUE THEN 'true' ELSE 'false' END WHEN OPERATOR = '=' THEN CASE WHEN LEFT_VALUE = RIGHT_VALUE THEN 'true' ELSE 'false' END END AS VALUE FROM (SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, MAX(CASE WHEN E.LEFT_OPERAND = V.NAME THEN V.VALUE END) AS LEFT_VALUE, MAX(CASE WHEN E.RIGHT_OPERAND = V.NAME THEN V.VALUE END) AS RIGHT_VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS V ON E.LEFT_OPERAND = V.NAME OR E.RIGHT_OPERAND = V.NAME GROUP BY E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND) AS X;

/*
Prediction Result:
('@', 'exp_fcc4f6', 'B', None)
('C', 'exp_fcc4f6', '#', None)
('O', 'a_s_f2ee86', 'a_s_12c5f2', None)
('a_s_97ea2a', 'A', 'a_s_12c5f2', None)
('a_s_97ea2a', 'a_s_07a285', 'a_s_12c5f2', None)
('a_s_97ea2a', 'a_s_f2ee86', 'G', None)
('a_s_97ea2a', 'a_s_f2ee86', 'I', None)
('a_s_97ea2a', 'a_s_f2ee86', 'a_s_12c5f2', None)
('a_s_97ea2a', 'exp_fcc4f6', 'a_s_12c5f2', None)
*/