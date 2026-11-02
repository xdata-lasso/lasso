-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO "Variables" ("name", "value") VALUES ('v1', 2);
INSERT INTO "Variables" ("name", "value") VALUES ('v2', 10);
INSERT INTO "Variables" ("name", "value") VALUES ('v3', 2);
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES ('v1', '<', 'v2');
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES ('v1', '>', 'v2');
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES ('v1', '!=', 'v2');
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES ('v1', '<=', 'v3');
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES ('v1', '>=', 'v3');
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES ('v1', '==', 'v3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('v1', '<', 'v2', 'true')
('v1', '>', 'v2', 'false')
('v1', '!=', 'v2', 'false')
('v1', '<=', 'v3', 'false')
('v1', '>=', 'v3', 'false')
('v1', '==', 'v3', 'false')
*/

-- Prediction Query
WITH T AS (SELECT VALUE AS LVALUE, OPERATOR, NAME AS LEFT_OPERAND, RIGHT_OPERAND FROM EXPRESSIONS JOIN VARIABLES ON EXPRESSIONS.LEFT_OPERAND = VARIABLES.NAME), R AS (SELECT OPERATOR, VALUE AS RVALUE, LEFT_OPERAND, RIGHT_OPERAND FROM EXPRESSIONS JOIN VARIABLES ON EXPRESSIONS.RIGHT_OPERAND = VARIABLES.NAME), TMP AS (SELECT T.LVALUE, T.LEFT_OPERAND, T.OPERATOR, T.RIGHT_OPERAND, R.RVALUE FROM T JOIN R ON T.LEFT_OPERAND = R.LEFT_OPERAND AND T.RIGHT_OPERAND = R.RIGHT_OPERAND AND T.OPERATOR = R.OPERATOR) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(LVALUE > RVALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(LVALUE = RVALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(LVALUE < RVALUE, 'true', 'false') END AS VALUE FROM TMP;

/*
Prediction Result:
('v1', '<', 'v2', 'true')
('v1', '>', 'v2', 'false')
('v1', '!=', 'v2', None)
('v1', '<=', 'v3', None)
('v1', '>=', 'v3', None)
('v1', '==', 'v3', None)
*/