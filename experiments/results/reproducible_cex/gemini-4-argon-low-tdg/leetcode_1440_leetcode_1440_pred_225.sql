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
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(LEFT_VALUE > VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(LEFT_VALUE = VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(LEFT_VALUE < VALUE, 'true', 'false') END AS VALUE FROM ((SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, VALUE AS LEFT_VALUE FROM EXPRESSIONS JOIN VARIABLES ON EXPRESSIONS.LEFT_OPERAND = VARIABLES.NAME) AS TMP1 JOIN VARIABLES ON TMP1.RIGHT_OPERAND = VARIABLES.NAME);

/*
Prediction Result:
('v1', '<', 'v2', 'true')
('v1', '>', 'v2', 'false')
('v1', '!=', 'v2', None)
('v1', '<=', 'v3', None)
('v1', '>=', 'v3', None)
('v1', '==', 'v3', None)
*/