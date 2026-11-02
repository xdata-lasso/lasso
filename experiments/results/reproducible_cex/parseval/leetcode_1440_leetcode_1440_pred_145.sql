-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_09ba7e', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_29f0af', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_1d33b5', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('C', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_09ba7e', 'a_s_36bdd1', 'a_s_29f0af');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_36bdd1', 'a_s_29f0af');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_09ba7e', 'a_s_36bdd1', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_09ba7e', 'a_s_36bdd1', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_09ba7e', 'a_s_6b8afb', 'a_s_29f0af');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_09ba7e', 'A', 'a_s_29f0af');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_09ba7e', 'exp_fcc4f6', 'a_s_29f0af');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'B');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'exp_fcc4f6', 'E');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_09ba7e', 'a_s_36bdd1', 'a_s_29f0af', 'false')
('A', 'a_s_36bdd1', 'a_s_29f0af', 'false')
('a_s_09ba7e', 'a_s_36bdd1', 'O', 'false')
('a_s_09ba7e', 'a_s_36bdd1', 'G', 'false')
('a_s_09ba7e', 'a_s_6b8afb', 'a_s_29f0af', 'false')
('a_s_09ba7e', 'A', 'a_s_29f0af', 'false')
('a_s_09ba7e', 'exp_fcc4f6', 'a_s_29f0af', 'false')
('@', 'exp_fcc4f6', 'B', 'false')
('C', 'exp_fcc4f6', 'E', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(L.VALUE > R.VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(L.VALUE = R.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(L.VALUE < R.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS L ON E.LEFT_OPERAND = L.NAME LEFT JOIN VARIABLES AS R ON E.RIGHT_OPERAND = R.NAME;

/*
Prediction Result:
('a_s_09ba7e', 'a_s_36bdd1', 'a_s_29f0af', None)
('A', 'a_s_36bdd1', 'a_s_29f0af', None)
('a_s_09ba7e', 'a_s_36bdd1', 'O', None)
('a_s_09ba7e', 'a_s_36bdd1', 'G', None)
('a_s_09ba7e', 'a_s_6b8afb', 'a_s_29f0af', None)
('a_s_09ba7e', 'A', 'a_s_29f0af', None)
('a_s_09ba7e', 'exp_fcc4f6', 'a_s_29f0af', None)
('@', 'exp_fcc4f6', 'B', None)
('C', 'exp_fcc4f6', 'E', None)
*/