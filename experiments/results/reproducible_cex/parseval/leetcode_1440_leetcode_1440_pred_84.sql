-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_b836d1', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_d93597', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_ce0f22', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('!', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('H', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b836d1', 'a_s_f54988', 'a_s_d93597');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b836d1', '<', 'a_s_d93597');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_f54988', 'a_s_d93597');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b836d1', 'a_s_f54988', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b836d1', 'a_s_da9ee8', 'a_s_d93597');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b836d1', 'A', 'a_s_d93597');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b836d1', 'exp_fcc4f6', 'a_s_d93597');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', '!');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('H', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_b836d1', 'a_s_f54988', 'a_s_d93597', 'false')
('a_s_b836d1', '<', 'a_s_d93597', 'false')
('O', 'a_s_f54988', 'a_s_d93597', 'false')
('a_s_b836d1', 'a_s_f54988', 'O', 'false')
('a_s_b836d1', 'a_s_da9ee8', 'a_s_d93597', 'false')
('a_s_b836d1', 'A', 'a_s_d93597', 'false')
('a_s_b836d1', 'exp_fcc4f6', 'a_s_d93597', 'false')
('@', 'exp_fcc4f6', '!', 'false')
('H', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
WITH CTE AS (SELECT V.NAME AS LEFT_OPERAND, V.VALUE AS LEFT, OPERATOR, S.NAME AS RIGHT_OPERAND, S.VALUE AS RIGHT FROM EXPRESSIONS AS E JOIN VARIABLES AS V ON E.LEFT_OPERAND = V.NAME JOIN VARIABLES AS S ON E.RIGHT_OPERAND = S.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '=' THEN IIF(LEFT = RIGHT, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(LEFT > RIGHT, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(LEFT < RIGHT, 'true', 'false') ELSE NULL END AS VALUE FROM CTE;

/*
Prediction Result:
('a_s_b836d1', 'a_s_f54988', 'a_s_d93597', None)
('a_s_b836d1', '<', 'a_s_d93597', 'false')
('O', 'a_s_f54988', 'a_s_d93597', None)
('a_s_b836d1', 'a_s_f54988', 'O', None)
('a_s_b836d1', 'a_s_da9ee8', 'a_s_d93597', None)
('a_s_b836d1', 'A', 'a_s_d93597', None)
('a_s_b836d1', 'exp_fcc4f6', 'a_s_d93597', None)
('@', 'exp_fcc4f6', '!', None)
('H', 'exp_fcc4f6', 'B', None)
*/