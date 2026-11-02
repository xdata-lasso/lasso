-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_eaff19', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_c39b5a', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('_', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_cde6d1', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('B', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eaff19', 'a_s_f53b2d', 'a_s_c39b5a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eaff19', '<', 'a_s_c39b5a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_f53b2d', 'a_s_c39b5a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eaff19', 'a_s_f53b2d', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_f53b2d', 'a_s_c39b5a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eaff19', 'a_s_f53b2d', '_');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eaff19', 'a_s_62eedc', 'a_s_c39b5a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eaff19', 'A', 'a_s_c39b5a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eaff19', 'exp_fcc4f6', 'a_s_c39b5a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_eaff19', 'a_s_f53b2d', 'a_s_c39b5a', 'false')
('a_s_eaff19', '<', 'a_s_c39b5a', 'false')
('G', 'a_s_f53b2d', 'a_s_c39b5a', 'false')
('a_s_eaff19', 'a_s_f53b2d', 'O', 'false')
('O', 'a_s_f53b2d', 'a_s_c39b5a', 'false')
('a_s_eaff19', 'a_s_f53b2d', '_', 'false')
('a_s_eaff19', 'a_s_62eedc', 'a_s_c39b5a', 'false')
('a_s_eaff19', 'A', 'a_s_c39b5a', 'false')
('a_s_eaff19', 'exp_fcc4f6', 'a_s_c39b5a', 'false')
('B', 'exp_fcc4f6', '@', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(LEFT_VALUE > RIGHT_VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(LEFT_VALUE < RIGHT_VALUE, 'true', 'false') ELSE IIF(LEFT_VALUE = RIGHT_VALUE, 'true', 'false') END AS VALUE FROM (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, SUM(CASE WHEN LEFT_OPERAND = NAME THEN VALUE ELSE NULL END) AS LEFT_VALUE, SUM(CASE WHEN RIGHT_OPERAND = NAME THEN VALUE ELSE NULL END) AS RIGHT_VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS V ON E.LEFT_OPERAND = NAME OR E.RIGHT_OPERAND = NAME GROUP BY LEFT_OPERAND, OPERATOR, RIGHT_OPERAND) AS T1;

/*
Prediction Result:
('B', 'exp_fcc4f6', '@', 'false')
('G', 'a_s_f53b2d', 'a_s_c39b5a', 'false')
('O', 'a_s_f53b2d', 'a_s_c39b5a', 'false')
('a_s_eaff19', '<', 'a_s_c39b5a', 'false')
('a_s_eaff19', 'A', 'a_s_c39b5a', 'true')
('a_s_eaff19', 'a_s_62eedc', 'a_s_c39b5a', 'true')
('a_s_eaff19', 'a_s_f53b2d', 'O', 'false')
('a_s_eaff19', 'a_s_f53b2d', '_', 'false')
('a_s_eaff19', 'a_s_f53b2d', 'a_s_c39b5a', 'true')
('a_s_eaff19', 'exp_fcc4f6', 'a_s_c39b5a', 'true')
*/