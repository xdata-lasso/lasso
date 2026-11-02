-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_240c7a', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_8820c7', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('?', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('I', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_74c85b', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('C', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_240c7a', 'a_s_13eeea', 'a_s_8820c7');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_240c7a', '<', 'a_s_8820c7');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_13eeea', 'a_s_8820c7');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_240c7a', 'a_s_13eeea', '?');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_240c7a', 'a_s_13eeea', 'I');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_240c7a', 'a_s_19fb75', 'a_s_8820c7');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_240c7a', 'A', 'a_s_8820c7');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_240c7a', 'exp_fcc4f6', 'a_s_8820c7');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'B');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_240c7a', 'a_s_13eeea', 'a_s_8820c7', 'false')
('a_s_240c7a', '<', 'a_s_8820c7', 'false')
('A', 'a_s_13eeea', 'a_s_8820c7', 'false')
('a_s_240c7a', 'a_s_13eeea', '?', 'false')
('a_s_240c7a', 'a_s_13eeea', 'I', 'false')
('a_s_240c7a', 'a_s_19fb75', 'a_s_8820c7', 'false')
('a_s_240c7a', 'A', 'a_s_8820c7', 'false')
('a_s_240c7a', 'exp_fcc4f6', 'a_s_8820c7', 'false')
('@', 'exp_fcc4f6', 'B', 'false')
('`', 'exp_fcc4f6', 'C', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN E.OPERATOR = '>' THEN IIF(L.VALUE > R.VALUE, 'true', 'false') WHEN E.OPERATOR = '<' THEN IIF(L.VALUE < R.VALUE, 'true', 'false') ELSE IIF(L.VALUE = R.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS L ON E.LEFT_OPERAND = L.NAME LEFT JOIN VARIABLES AS R ON E.RIGHT_OPERAND = R.NAME;

/*
Prediction Result:
('a_s_240c7a', 'a_s_13eeea', 'a_s_8820c7', 'true')
('a_s_240c7a', '<', 'a_s_8820c7', 'false')
('A', 'a_s_13eeea', 'a_s_8820c7', 'false')
('a_s_240c7a', 'a_s_13eeea', '?', 'false')
('a_s_240c7a', 'a_s_13eeea', 'I', 'true')
('a_s_240c7a', 'a_s_19fb75', 'a_s_8820c7', 'true')
('a_s_240c7a', 'A', 'a_s_8820c7', 'true')
('a_s_240c7a', 'exp_fcc4f6', 'a_s_8820c7', 'true')
('@', 'exp_fcc4f6', 'B', 'false')
('`', 'exp_fcc4f6', 'C', 'false')
*/