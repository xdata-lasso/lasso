-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_fa2ea3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_a70fb4', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_69f716', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('Q', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('U', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fa2ea3', 'a_s_03c0d5', 'a_s_a70fb4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_03c0d5', 'a_s_a70fb4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fa2ea3', 'a_s_03c0d5', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fa2ea3', 'a_s_7f4e99', 'a_s_a70fb4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fa2ea3', 'A', 'a_s_a70fb4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fa2ea3', 'exp_fcc4f6', 'a_s_a70fb4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'Q');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', 'U');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_fa2ea3', 'a_s_03c0d5', 'a_s_a70fb4', 'false')
('A', 'a_s_03c0d5', 'a_s_a70fb4', 'false')
('a_s_fa2ea3', 'a_s_03c0d5', 'A', 'false')
('a_s_fa2ea3', 'a_s_7f4e99', 'a_s_a70fb4', 'false')
('a_s_fa2ea3', 'A', 'a_s_a70fb4', 'false')
('a_s_fa2ea3', 'exp_fcc4f6', 'a_s_a70fb4', 'false')
('@', 'exp_fcc4f6', 'Q', 'false')
('B', 'exp_fcc4f6', 'U', 'false')
*/

-- Prediction Query
WITH T1 AS (SELECT E.*, V1.VALUE AS L, V2.VALUE AS R FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME LEFT JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME), T2 AS (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, (CASE WHEN OPERATOR = '>' THEN L > R WHEN OPERATOR = '=' THEN L = R WHEN OPERATOR = '<' THEN L < R END) AS VALUE FROM T1) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, (CASE WHEN VALUE = 0 THEN 'false' ELSE 'true' END) AS VALUE FROM T2;

/*
Prediction Result:
('a_s_fa2ea3', 'a_s_03c0d5', 'a_s_a70fb4', 'true')
('A', 'a_s_03c0d5', 'a_s_a70fb4', 'true')
('a_s_fa2ea3', 'a_s_03c0d5', 'A', 'true')
('a_s_fa2ea3', 'a_s_7f4e99', 'a_s_a70fb4', 'true')
('a_s_fa2ea3', 'A', 'a_s_a70fb4', 'true')
('a_s_fa2ea3', 'exp_fcc4f6', 'a_s_a70fb4', 'true')
('@', 'exp_fcc4f6', 'Q', 'true')
('B', 'exp_fcc4f6', 'U', 'true')
*/