-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_fe48ac', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_4de5e3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('I', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_3c1d0f', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('D', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1980249628);

INSERT INTO "variables" ("name", "value") VALUES ('M', -734455130);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fe48ac', 'a_s_cee67d', 'a_s_4de5e3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_cee67d', 'a_s_4de5e3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fe48ac', 'a_s_cee67d', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fe48ac', 'a_s_cee67d', 'I');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fe48ac', 'a_s_5d5e0d', 'a_s_4de5e3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fe48ac', 'A', 'a_s_4de5e3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fe48ac', 'exp_fcc4f6', 'a_s_4de5e3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('M', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_fe48ac', 'a_s_cee67d', 'a_s_4de5e3', 'false')
('A', 'a_s_cee67d', 'a_s_4de5e3', 'false')
('a_s_fe48ac', 'a_s_cee67d', 'O', 'false')
('a_s_fe48ac', 'a_s_cee67d', 'I', 'false')
('a_s_fe48ac', 'a_s_5d5e0d', 'a_s_4de5e3', 'false')
('a_s_fe48ac', 'A', 'a_s_4de5e3', 'false')
('a_s_fe48ac', 'exp_fcc4f6', 'a_s_4de5e3', 'false')
('D', 'exp_fcc4f6', '@', 'false')
('M', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, IIF(IIF(E.OPERATOR = '=', L.VALUE = R.VALUE, IIF(E.OPERATOR = '>', L.VALUE > R.VALUE, L.VALUE < R.VALUE)), 'true', 'false') AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS L ON (E.LEFT_OPERAND = L.NAME) LEFT JOIN VARIABLES AS R ON (E.RIGHT_OPERAND = R.NAME);

/*
Prediction Result:
('a_s_fe48ac', 'a_s_cee67d', 'a_s_4de5e3', 'false')
('A', 'a_s_cee67d', 'a_s_4de5e3', 'true')
('a_s_fe48ac', 'a_s_cee67d', 'O', 'false')
('a_s_fe48ac', 'a_s_cee67d', 'I', 'false')
('a_s_fe48ac', 'a_s_5d5e0d', 'a_s_4de5e3', 'false')
('a_s_fe48ac', 'A', 'a_s_4de5e3', 'false')
('a_s_fe48ac', 'exp_fcc4f6', 'a_s_4de5e3', 'false')
('D', 'exp_fcc4f6', '@', 'false')
('M', 'exp_fcc4f6', 'B', 'false')
*/