-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_1ffc2d', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_7c0ee2', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('_', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('I', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_dc2d85', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('C', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('E', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_1ffc2d', 'a_s_9516b7', 'a_s_7c0ee2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_9516b7', 'a_s_7c0ee2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_1ffc2d', 'a_s_9516b7', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('_', 'a_s_9516b7', 'a_s_7c0ee2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_1ffc2d', 'a_s_8c6690', 'a_s_7c0ee2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_1ffc2d', 'A', 'a_s_7c0ee2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_1ffc2d', 'exp_fcc4f6', 'a_s_7c0ee2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'C');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', 'E');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_1ffc2d', 'a_s_9516b7', 'a_s_7c0ee2', 'false')
('O', 'a_s_9516b7', 'a_s_7c0ee2', 'false')
('a_s_1ffc2d', 'a_s_9516b7', 'A', 'false')
('_', 'a_s_9516b7', 'a_s_7c0ee2', 'false')
('a_s_1ffc2d', 'a_s_8c6690', 'a_s_7c0ee2', 'false')
('a_s_1ffc2d', 'A', 'a_s_7c0ee2', 'false')
('a_s_1ffc2d', 'exp_fcc4f6', 'a_s_7c0ee2', 'false')
('@', 'exp_fcc4f6', 'C', 'false')
('B', 'exp_fcc4f6', 'E', 'false')
*/

-- Prediction Query
WITH AA AS (SELECT L, LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, R FROM (SELECT VALUE AS L, LEFT_OPERAND, RIGHT_OPERAND, OPERATOR FROM VARIABLES JOIN EXPRESSIONS ON NAME = LEFT_OPERAND) AS A JOIN (SELECT LEFT_OPERAND, OPERATOR, VALUE AS R, RIGHT_OPERAND FROM VARIABLES JOIN EXPRESSIONS ON NAME = RIGHT_OPERAND) AS B USING (LEFT_OPERAND, OPERATOR, RIGHT_OPERAND)) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN VALUE = 1 THEN 'true' ELSE 'false' END AS VALUE FROM (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN L > R WHEN OPERATOR = '<' THEN L < R ELSE L = R END AS VALUE FROM AA) AS BB;

/*
Prediction Result:
('a_s_1ffc2d', 'a_s_9516b7', 'a_s_7c0ee2', 'true')
('O', 'a_s_9516b7', 'a_s_7c0ee2', 'false')
('a_s_1ffc2d', 'a_s_9516b7', 'A', 'true')
('_', 'a_s_9516b7', 'a_s_7c0ee2', 'false')
('a_s_1ffc2d', 'a_s_8c6690', 'a_s_7c0ee2', 'true')
('a_s_1ffc2d', 'A', 'a_s_7c0ee2', 'true')
('a_s_1ffc2d', 'exp_fcc4f6', 'a_s_7c0ee2', 'true')
('@', 'exp_fcc4f6', 'C', 'false')
('B', 'exp_fcc4f6', 'E', 'false')
*/