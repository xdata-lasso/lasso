-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Variables" ("name", "value") VALUES ('x', 10);
INSERT INTO "Variables" ("name", "value") VALUES ('y', 20);
INSERT INTO "Variables" ("name", "value") VALUES ('z', 10);
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES ('x', '<', 'y');
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES ('x', '=', 'y');
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES ('x', '>', 'y');
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES ('y', '<', 'x');
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES ('y', '=', 'x');
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES ('y', '>', 'x');
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES ('x', '<', 'z');
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES ('x', '=', 'z');
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES ('x', '>', 'z');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('x', '<', 'y', 'true')
('x', '=', 'y', 'false')
('x', '>', 'y', 'false')
('y', '<', 'x', 'false')
('y', '=', 'x', 'false')
('y', '>', 'x', 'true')
('x', '<', 'z', 'false')
('x', '=', 'z', 'true')
('x', '>', 'z', 'false')
*/

-- Prediction Query
WITH STEP1 AS (SELECT LEFT_OPERAND, E.OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN VAR1.VALUE > VAR2.VALUE WHEN OPERATOR = '<' THEN VAR1.VALUE > VAR2.VALUE WHEN OPERATOR = '=' THEN VAR1.VALUE = VAR2.VALUE END AS CASE_ FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS VAR1 ON E.LEFT_OPERAND = VAR1.NAME LEFT JOIN VARIABLES AS VAR2 ON E.RIGHT_OPERAND = VAR2.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN CASE_ = 0 THEN 'false' ELSE 'true' END AS VALUE FROM STEP1;

/*
Prediction Result:
('x', '<', 'y', 'false')
('x', '=', 'y', 'false')
('x', '>', 'y', 'false')
('y', '<', 'x', 'true')
('y', '=', 'x', 'false')
('y', '>', 'x', 'true')
('x', '<', 'z', 'false')
('x', '=', 'z', 'true')
('x', '>', 'z', 'false')
*/