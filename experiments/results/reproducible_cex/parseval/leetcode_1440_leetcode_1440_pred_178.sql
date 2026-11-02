-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_821471', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_f99940', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_98527a', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('D', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('B', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_821471', 'a_s_27237f', 'a_s_f99940');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_821471', '<', 'a_s_f99940');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_27237f', 'a_s_f99940');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_821471', 'a_s_27237f', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_821471', 'a_s_e4c3a2', 'a_s_f99940');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_821471', 'A', 'a_s_f99940');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_821471', 'exp_fcc4f6', 'a_s_f99940');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'D');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_821471', 'a_s_27237f', 'a_s_f99940', 'false')
('a_s_821471', '<', 'a_s_f99940', 'false')
('A', 'a_s_27237f', 'a_s_f99940', 'false')
('a_s_821471', 'a_s_27237f', 'O', 'false')
('a_s_821471', 'a_s_e4c3a2', 'a_s_f99940', 'false')
('a_s_821471', 'A', 'a_s_f99940', 'false')
('a_s_821471', 'exp_fcc4f6', 'a_s_f99940', 'false')
('@', 'exp_fcc4f6', 'D', 'false')
('B', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
WITH T AS (SELECT VALUE AS LVALUE, OPERATOR, NAME AS LEFT_OPERAND, RIGHT_OPERAND FROM EXPRESSIONS JOIN VARIABLES ON EXPRESSIONS.LEFT_OPERAND = VARIABLES.NAME), R AS (SELECT OPERATOR, VALUE AS RVALUE, LEFT_OPERAND, RIGHT_OPERAND FROM EXPRESSIONS JOIN VARIABLES ON EXPRESSIONS.RIGHT_OPERAND = VARIABLES.NAME), TMP AS (SELECT T.LVALUE, T.LEFT_OPERAND, T.OPERATOR, T.RIGHT_OPERAND, R.RVALUE FROM T JOIN R ON T.LEFT_OPERAND = R.LEFT_OPERAND AND T.RIGHT_OPERAND = R.RIGHT_OPERAND AND T.OPERATOR = R.OPERATOR) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(LVALUE > RVALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(LVALUE = RVALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(LVALUE < RVALUE, 'true', 'false') END AS VALUE FROM TMP;

/*
Prediction Result:
('a_s_821471', 'a_s_27237f', 'a_s_f99940', None)
('a_s_821471', '<', 'a_s_f99940', 'false')
('A', 'a_s_27237f', 'a_s_f99940', None)
('a_s_821471', 'a_s_27237f', 'O', None)
('a_s_821471', 'a_s_e4c3a2', 'a_s_f99940', None)
('a_s_821471', 'A', 'a_s_f99940', None)
('a_s_821471', 'exp_fcc4f6', 'a_s_f99940', None)
('@', 'exp_fcc4f6', 'D', None)
('B', 'exp_fcc4f6', '`', None)
*/