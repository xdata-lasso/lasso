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
WITH TEMP1 AS (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, V.VALUE AS LEFT_VALUE FROM EXPRESSIONS LEFT JOIN VARIABLES AS V ON LEFT_OPERAND = NAME), TEMP2 AS (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, LEFT_VALUE, V.VALUE AS RIGHT_VALUE FROM TEMP1 LEFT JOIN VARIABLES AS V ON RIGHT_OPERAND = NAME), TEMP3 AS (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN (LEFT_VALUE > RIGHT_VALUE) WHEN OPERATOR = '<' THEN (LEFT_VALUE < RIGHT_VALUE) ELSE (LEFT_VALUE = RIGHT_VALUE) END AS NUMB FROM TEMP2) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN NUMB = 1 THEN 'true' ELSE 'false' END AS VALUE FROM TEMP3;

/*
Prediction Result:
('v1', '<', 'v2', 'true')
('v1', '>', 'v2', 'false')
('v1', '!=', 'v2', 'false')
('v1', '<=', 'v3', 'true')
('v1', '>=', 'v3', 'true')
('v1', '==', 'v3', 'true')
*/