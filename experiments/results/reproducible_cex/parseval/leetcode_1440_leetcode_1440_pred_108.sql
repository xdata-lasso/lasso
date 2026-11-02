-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_80734f', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_2854ec', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_8b7ecc', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('a', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_80734f', 'a_s_bb3f4b', 'a_s_2854ec');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_80734f', '<', 'a_s_2854ec');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_bb3f4b', 'a_s_2854ec');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_80734f', 'a_s_bb3f4b', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_80734f', 'a_s_bb3f4b', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_80734f', 'a_s_096756', 'a_s_2854ec');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_80734f', 'A', 'a_s_2854ec');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_80734f', 'exp_fcc4f6', 'a_s_2854ec');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'B');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_80734f', 'a_s_bb3f4b', 'a_s_2854ec', 'false')
('a_s_80734f', '<', 'a_s_2854ec', 'false')
('O', 'a_s_bb3f4b', 'a_s_2854ec', 'false')
('a_s_80734f', 'a_s_bb3f4b', 'G', 'false')
('a_s_80734f', 'a_s_bb3f4b', 'O', 'false')
('a_s_80734f', 'a_s_096756', 'a_s_2854ec', 'false')
('a_s_80734f', 'A', 'a_s_2854ec', 'false')
('a_s_80734f', 'exp_fcc4f6', 'a_s_2854ec', 'false')
('@', 'exp_fcc4f6', 'B', 'false')
('a', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
SELECT E.*, CASE WHEN E.OPERATOR = '>' THEN CASE WHEN LF.VALUE > RT.VALUE THEN 'true' ELSE 'false' END WHEN E.OPERATOR = '=' THEN CASE WHEN LF.VALUE = RT.VALUE THEN 'true' ELSE 'false' END WHEN E.OPERATOR = '<' THEN CASE WHEN LF.VALUE < RT.VALUE THEN 'true' ELSE 'false' END END AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS LF ON E.LEFT_OPERAND = LF.NAME LEFT JOIN VARIABLES AS RT ON E.RIGHT_OPERAND = RT.NAME;

/*
Prediction Result:
('a_s_80734f', 'a_s_bb3f4b', 'a_s_2854ec', None)
('a_s_80734f', '<', 'a_s_2854ec', 'false')
('O', 'a_s_bb3f4b', 'a_s_2854ec', None)
('a_s_80734f', 'a_s_bb3f4b', 'G', None)
('a_s_80734f', 'a_s_bb3f4b', 'O', None)
('a_s_80734f', 'a_s_096756', 'a_s_2854ec', None)
('a_s_80734f', 'A', 'a_s_2854ec', None)
('a_s_80734f', 'exp_fcc4f6', 'a_s_2854ec', None)
('@', 'exp_fcc4f6', 'B', None)
('a', 'exp_fcc4f6', '`', None)
*/