-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_ea1599', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_6805f6', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('_', 1);

INSERT INTO "variables" ("name", "value") VALUES ('I', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_99d3b0', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('D', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('E', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('C', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ea1599', 'a_s_4c0a10', 'a_s_6805f6');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_4c0a10', 'a_s_6805f6');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ea1599', 'a_s_4c0a10', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('I', 'a_s_4c0a10', 'a_s_6805f6');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ea1599', 'a_s_f12d81', 'a_s_6805f6');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ea1599', 'A', 'a_s_6805f6');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ea1599', 'exp_fcc4f6', 'a_s_6805f6');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('E', 'exp_fcc4f6', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_ea1599', 'a_s_4c0a10', 'a_s_6805f6', 'false')
('G', 'a_s_4c0a10', 'a_s_6805f6', 'false')
('a_s_ea1599', 'a_s_4c0a10', 'A', 'false')
('I', 'a_s_4c0a10', 'a_s_6805f6', 'false')
('a_s_ea1599', 'a_s_f12d81', 'a_s_6805f6', 'false')
('a_s_ea1599', 'A', 'a_s_6805f6', 'false')
('a_s_ea1599', 'exp_fcc4f6', 'a_s_6805f6', 'false')
('D', 'exp_fcc4f6', '@', 'false')
('E', 'exp_fcc4f6', 'C', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, IIF(CASE WHEN OPERATOR = '=' THEN L.VALUE = R.VALUE WHEN OPERATOR = '>' THEN L.VALUE > R.VALUE ELSE L.VALUE < R.VALUE END, 'true', 'false') AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS L ON E.LEFT_OPERAND = L.NAME LEFT JOIN VARIABLES AS R ON E.RIGHT_OPERAND = R.NAME;

/*
Prediction Result:
('a_s_ea1599', 'a_s_4c0a10', 'a_s_6805f6', 'false')
('G', 'a_s_4c0a10', 'a_s_6805f6', 'true')
('a_s_ea1599', 'a_s_4c0a10', 'A', 'false')
('I', 'a_s_4c0a10', 'a_s_6805f6', 'true')
('a_s_ea1599', 'a_s_f12d81', 'a_s_6805f6', 'false')
('a_s_ea1599', 'A', 'a_s_6805f6', 'false')
('a_s_ea1599', 'exp_fcc4f6', 'a_s_6805f6', 'false')
('D', 'exp_fcc4f6', '@', 'false')
('E', 'exp_fcc4f6', 'C', 'false')
*/