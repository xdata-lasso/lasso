-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES (NULL, 'evidence', NULL);
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES (NULL, 'news', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE1 AS (SELECT EXPRESSIONS.*, VARIABLES.VALUE AS LEFT_V FROM EXPRESSIONS LEFT JOIN VARIABLES ON EXPRESSIONS.LEFT_OPERAND = VARIABLES.NAME), CTE2 AS (SELECT CTE1.*, VARIABLES.VALUE AS RIGHT_V FROM CTE1 LEFT JOIN VARIABLES ON CTE1.RIGHT_OPERAND = VARIABLES.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, (CASE WHEN LEFT_V > RIGHT_V AND OPERATOR = '>' THEN 'true' WHEN LEFT_V = RIGHT_V AND OPERATOR = '=' THEN 'true' WHEN LEFT_V < RIGHT_V AND OPERATOR = '<' THEN 'true' ELSE 'false' END) AS VALUE FROM CTE2;

/*
Prediction Result:
(None, 'evidence', None, 'false')
(None, 'news', None, 'false')
*/