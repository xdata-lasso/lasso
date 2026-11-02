-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_9a2e78', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_2ccc59', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_d2c38d', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('P', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9a2e78', 'a_s_7d125d', 'a_s_2ccc59');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_7d125d', 'a_s_2ccc59');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9a2e78', 'a_s_7d125d', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9a2e78', 'a_s_afe03c', 'a_s_2ccc59');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9a2e78', 'A', 'a_s_2ccc59');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9a2e78', 'exp_fcc4f6', 'a_s_2ccc59');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'P');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_9a2e78', 'a_s_7d125d', 'a_s_2ccc59', 'false')
('A', 'a_s_7d125d', 'a_s_2ccc59', 'false')
('a_s_9a2e78', 'a_s_7d125d', 'O', 'false')
('a_s_9a2e78', 'a_s_afe03c', 'a_s_2ccc59', 'false')
('a_s_9a2e78', 'A', 'a_s_2ccc59', 'false')
('a_s_9a2e78', 'exp_fcc4f6', 'a_s_2ccc59', 'false')
('@', 'exp_fcc4f6', 'P', 'false')
('`', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT E.*, CASE WHEN E.OPERATOR = '>' AND V.VALUE > V2.VALUE THEN 'true' WHEN E.OPERATOR = '>' AND V.VALUE <= V2.VALUE THEN 'false' WHEN E.OPERATOR = '<' AND V.VALUE < V2.VALUE THEN 'true' WHEN E.OPERATOR = '<' AND V.VALUE >= V2.VALUE THEN 'false' WHEN E.OPERATOR = '=' AND V.VALUE = V2.VALUE THEN 'true' WHEN E.OPERATOR = '=' AND V.VALUE <> V2.VALUE THEN 'false' ELSE '' END AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V ON E.LEFT_OPERAND = V.NAME LEFT JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_9a2e78', 'a_s_7d125d', 'a_s_2ccc59', '')
('A', 'a_s_7d125d', 'a_s_2ccc59', '')
('a_s_9a2e78', 'a_s_7d125d', 'O', '')
('a_s_9a2e78', 'a_s_afe03c', 'a_s_2ccc59', '')
('a_s_9a2e78', 'A', 'a_s_2ccc59', '')
('a_s_9a2e78', 'exp_fcc4f6', 'a_s_2ccc59', '')
('@', 'exp_fcc4f6', 'P', '')
('`', 'exp_fcc4f6', 'B', '')
*/