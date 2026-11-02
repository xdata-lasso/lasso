-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_ba2d28', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_f78cfb', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_a84c47', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('C', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ba2d28', 'a_s_38d98a', 'a_s_f78cfb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ba2d28', '<', 'a_s_f78cfb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_38d98a', 'a_s_f78cfb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ba2d28', 'a_s_38d98a', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ba2d28', 'a_s_38d98a', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ba2d28', 'a_s_f53a57', 'a_s_f78cfb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ba2d28', 'A', 'a_s_f78cfb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ba2d28', 'exp_fcc4f6', 'a_s_f78cfb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'B');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_ba2d28', 'a_s_38d98a', 'a_s_f78cfb', 'false')
('a_s_ba2d28', '<', 'a_s_f78cfb', 'false')
('A', 'a_s_38d98a', 'a_s_f78cfb', 'false')
('a_s_ba2d28', 'a_s_38d98a', 'G', 'false')
('a_s_ba2d28', 'a_s_38d98a', 'O', 'false')
('a_s_ba2d28', 'a_s_f53a57', 'a_s_f78cfb', 'false')
('a_s_ba2d28', 'A', 'a_s_f78cfb', 'false')
('a_s_ba2d28', 'exp_fcc4f6', 'a_s_f78cfb', 'false')
('@', 'exp_fcc4f6', 'B', 'false')
('C', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '=' AND L.VALUE = R.VALUE THEN 'true' WHEN OPERATOR = '=' AND L.VALUE <> R.VALUE THEN 'false' WHEN OPERATOR = '>' AND L.VALUE > R.VALUE THEN 'true' WHEN OPERATOR = '>' AND L.VALUE <= R.VALUE THEN 'false' WHEN OPERATOR = '<' AND L.VALUE < R.VALUE THEN 'true' WHEN OPERATOR = '<' AND L.VALUE >= R.VALUE THEN 'false' END AS VALUE FROM EXPRESSIONS JOIN VARIABLES AS L ON EXPRESSIONS.LEFT_OPERAND = L.NAME JOIN VARIABLES AS R ON EXPRESSIONS.RIGHT_OPERAND = R.NAME;

/*
Prediction Result:
('a_s_ba2d28', 'a_s_38d98a', 'a_s_f78cfb', None)
('a_s_ba2d28', '<', 'a_s_f78cfb', 'false')
('A', 'a_s_38d98a', 'a_s_f78cfb', None)
('a_s_ba2d28', 'a_s_38d98a', 'G', None)
('a_s_ba2d28', 'a_s_38d98a', 'O', None)
('a_s_ba2d28', 'a_s_f53a57', 'a_s_f78cfb', None)
('a_s_ba2d28', 'A', 'a_s_f78cfb', None)
('a_s_ba2d28', 'exp_fcc4f6', 'a_s_f78cfb', None)
('@', 'exp_fcc4f6', 'B', None)
('C', 'exp_fcc4f6', '`', None)
*/