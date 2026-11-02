-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_8c88fe', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_a89372', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('_', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_290ef4', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('P', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('b', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_8c88fe', 'a_s_615693', 'a_s_a89372');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_615693', 'a_s_a89372');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_8c88fe', 'a_s_615693', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_8c88fe', 'a_s_fde276', 'a_s_a89372');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_8c88fe', 'A', 'a_s_a89372');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_8c88fe', 'exp_fcc4f6', 'a_s_a89372');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('b', 'exp_fcc4f6', 'P');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_8c88fe', 'a_s_615693', 'a_s_a89372', 'false')
('A', 'a_s_615693', 'a_s_a89372', 'false')
('a_s_8c88fe', 'a_s_615693', 'A', 'false')
('a_s_8c88fe', 'a_s_fde276', 'a_s_a89372', 'false')
('a_s_8c88fe', 'A', 'a_s_a89372', 'false')
('a_s_8c88fe', 'exp_fcc4f6', 'a_s_a89372', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('b', 'exp_fcc4f6', 'P', 'false')
*/

-- Prediction Query
WITH CTE AS (SELECT B.LEFT_OPERAND, B.OPERATOR, B.RIGHT_OPERAND, A1.VALUE AS LEFT_VALUE, A2.VALUE AS RIGHT_VALUE FROM EXPRESSIONS AS B INNER JOIN VARIABLES AS A1 ON B.LEFT_OPERAND = A1.NAME INNER JOIN VARIABLES AS A2 ON B.RIGHT_OPERAND = A2.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(LEFT_VALUE > RIGHT_VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(LEFT_VALUE = RIGHT_VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(LEFT_VALUE < RIGHT_VALUE, 'true', 'false') END AS VALUE FROM CTE;

/*
Prediction Result:
('a_s_8c88fe', 'a_s_615693', 'a_s_a89372', None)
('A', 'a_s_615693', 'a_s_a89372', None)
('a_s_8c88fe', 'a_s_615693', 'A', None)
('a_s_8c88fe', 'a_s_fde276', 'a_s_a89372', None)
('a_s_8c88fe', 'A', 'a_s_a89372', None)
('a_s_8c88fe', 'exp_fcc4f6', 'a_s_a89372', None)
('B', 'exp_fcc4f6', '@', None)
('b', 'exp_fcc4f6', 'P', None)
*/