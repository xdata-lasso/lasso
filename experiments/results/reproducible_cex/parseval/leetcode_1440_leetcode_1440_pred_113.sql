-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_d69233', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_34ff7f', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('_', 1);

INSERT INTO "variables" ("name", "value") VALUES ('I', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_683723', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('D', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d69233', 'a_s_611b79', 'a_s_34ff7f');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d69233', '<', 'a_s_34ff7f');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_611b79', 'a_s_34ff7f');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d69233', 'a_s_611b79', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d69233', 'a_s_468d83', 'a_s_34ff7f');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d69233', 'A', 'a_s_34ff7f');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d69233', 'exp_fcc4f6', 'a_s_34ff7f');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'E');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_d69233', 'a_s_611b79', 'a_s_34ff7f', 'false')
('a_s_d69233', '<', 'a_s_34ff7f', 'false')
('A', 'a_s_611b79', 'a_s_34ff7f', 'false')
('a_s_d69233', 'a_s_611b79', 'A', 'false')
('a_s_d69233', 'a_s_468d83', 'a_s_34ff7f', 'false')
('a_s_d69233', 'A', 'a_s_34ff7f', 'false')
('a_s_d69233', 'exp_fcc4f6', 'a_s_34ff7f', 'false')
('D', 'exp_fcc4f6', '@', 'false')
('`', 'exp_fcc4f6', 'E', 'false')
*/

-- Prediction Query
SELECT E.*, IIF(CASE WHEN OPERATOR = '>' THEN L.VALUE > R.VALUE WHEN OPERATOR = '<' THEN L.VALUE < R.VALUE ELSE L.VALUE = R.VALUE END = 1, 'true', 'false') AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS L ON E.LEFT_OPERAND = L.NAME JOIN VARIABLES AS R ON E.RIGHT_OPERAND = R.NAME;

/*
Prediction Result:
('a_s_d69233', 'a_s_611b79', 'a_s_34ff7f', 'true')
('a_s_d69233', '<', 'a_s_34ff7f', 'false')
('A', 'a_s_611b79', 'a_s_34ff7f', 'false')
('a_s_d69233', 'a_s_611b79', 'A', 'false')
('a_s_d69233', 'a_s_468d83', 'a_s_34ff7f', 'true')
('a_s_d69233', 'A', 'a_s_34ff7f', 'true')
('a_s_d69233', 'exp_fcc4f6', 'a_s_34ff7f', 'true')
('D', 'exp_fcc4f6', '@', 'false')
('`', 'exp_fcc4f6', 'E', 'false')
*/