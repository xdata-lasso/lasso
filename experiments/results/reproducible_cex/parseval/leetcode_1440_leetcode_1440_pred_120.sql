-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_150409', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_05a812', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('_', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_f140e4', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('C', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_150409', 'a_s_2c7eb7', 'a_s_05a812');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_2c7eb7', 'a_s_05a812');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_150409', 'a_s_2c7eb7', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_150409', 'a_s_8e1df8', 'a_s_05a812');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_150409', 'A', 'a_s_05a812');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_150409', 'exp_fcc4f6', 'a_s_05a812');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'E');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_150409', 'a_s_2c7eb7', 'a_s_05a812', 'false')
('G', 'a_s_2c7eb7', 'a_s_05a812', 'false')
('a_s_150409', 'a_s_2c7eb7', 'A', 'false')
('a_s_150409', 'a_s_8e1df8', 'a_s_05a812', 'false')
('a_s_150409', 'A', 'a_s_05a812', 'false')
('a_s_150409', 'exp_fcc4f6', 'a_s_05a812', 'false')
('@', 'exp_fcc4f6', 'E', 'false')
('`', 'exp_fcc4f6', 'C', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE E.OPERATOR WHEN '<' THEN IIF(L.VALUE < R.VALUE, 'true', 'false') WHEN '>' THEN IIF(L.VALUE > R.VALUE, 'true', 'false') WHEN '=' THEN IIF(L.VALUE = R.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS L ON E.LEFT_OPERAND = L.NAME JOIN VARIABLES AS R ON E.RIGHT_OPERAND = R.NAME;

/*
Prediction Result:
('a_s_150409', 'a_s_2c7eb7', 'a_s_05a812', None)
('G', 'a_s_2c7eb7', 'a_s_05a812', None)
('a_s_150409', 'a_s_2c7eb7', 'A', None)
('a_s_150409', 'a_s_8e1df8', 'a_s_05a812', None)
('a_s_150409', 'A', 'a_s_05a812', None)
('a_s_150409', 'exp_fcc4f6', 'a_s_05a812', None)
('@', 'exp_fcc4f6', 'E', None)
('`', 'exp_fcc4f6', 'C', None)
*/