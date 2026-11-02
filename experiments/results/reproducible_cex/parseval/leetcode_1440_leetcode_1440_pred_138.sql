-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_d71f50', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_b8db7e', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_3e05fb', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('B', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('"', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('H', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d71f50', 'a_s_3a9b75', 'a_s_b8db7e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d71f50', '<', 'a_s_b8db7e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_3a9b75', 'a_s_b8db7e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d71f50', 'a_s_3a9b75', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d71f50', 'a_s_d63542', 'a_s_b8db7e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d71f50', 'A', 'a_s_b8db7e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d71f50', 'exp_fcc4f6', 'a_s_b8db7e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('"', 'exp_fcc4f6', 'H');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_d71f50', 'a_s_3a9b75', 'a_s_b8db7e', 'false')
('a_s_d71f50', '<', 'a_s_b8db7e', 'false')
('A', 'a_s_3a9b75', 'a_s_b8db7e', 'false')
('a_s_d71f50', 'a_s_3a9b75', 'O', 'false')
('a_s_d71f50', 'a_s_d63542', 'a_s_b8db7e', 'false')
('a_s_d71f50', 'A', 'a_s_b8db7e', 'false')
('a_s_d71f50', 'exp_fcc4f6', 'a_s_b8db7e', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('"', 'exp_fcc4f6', 'H', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, (CASE WHEN OPERATOR = '>' THEN IIF(L.VALUE > R.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(L.VALUE < R.VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(L.VALUE = R.VALUE, 'true', 'false') END) AS VALUE FROM EXPRESSIONS AS E INNER JOIN VARIABLES AS L ON E.LEFT_OPERAND = L.NAME INNER JOIN VARIABLES AS R ON R.NAME = E.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_d71f50', 'a_s_3a9b75', 'a_s_b8db7e', None)
('a_s_d71f50', '<', 'a_s_b8db7e', 'false')
('A', 'a_s_3a9b75', 'a_s_b8db7e', None)
('a_s_d71f50', 'a_s_3a9b75', 'O', None)
('a_s_d71f50', 'a_s_d63542', 'a_s_b8db7e', None)
('a_s_d71f50', 'A', 'a_s_b8db7e', None)
('a_s_d71f50', 'exp_fcc4f6', 'a_s_b8db7e', None)
('B', 'exp_fcc4f6', '@', None)
('"', 'exp_fcc4f6', 'H', None)
*/