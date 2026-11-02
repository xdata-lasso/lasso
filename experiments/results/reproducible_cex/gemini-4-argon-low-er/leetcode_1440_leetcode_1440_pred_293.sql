-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Variables" ("name", "value") VALUES ('x', 1);
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES (NULL, '=', 'x');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, VALUE AS LEFT_VAL FROM EXPRESSIONS LEFT JOIN VARIABLES ON EXPRESSIONS.LEFT_OPERAND = VARIABLES.NAME), CTE2 AS (SELECT LEFT_OPERAND, LEFT_VAL, OPERATOR, RIGHT_OPERAND, VALUE AS RIGHT_VAL FROM CTE LEFT JOIN VARIABLES ON CTE.RIGHT_OPERAND = VARIABLES.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN (LEFT_VAL > RIGHT_VAL AND OPERATOR = '>') OR (LEFT_VAL < RIGHT_VAL AND OPERATOR = '<') OR (LEFT_VAL = RIGHT_VAL AND OPERATOR = '=') THEN 'true' ELSE 'false' END AS VALUE FROM CTE2;

/*
Prediction Result:
(None, '=', 'x', 'false')
*/