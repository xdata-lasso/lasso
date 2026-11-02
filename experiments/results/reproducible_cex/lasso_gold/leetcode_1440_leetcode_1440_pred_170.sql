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
WITH CTE AS (SELECT LEFT_OPERAND, LEFT_T.VALUE AS LEFT_VALUE, OPERATOR, RIGHT_OPERAND, RIGHT_T.VALUE AS RIGHT_VALUE FROM EXPRESSIONS LEFT JOIN VARIABLES AS LEFT_T ON LEFT_T.NAME = EXPRESSIONS.LEFT_OPERAND LEFT JOIN VARIABLES AS RIGHT_T ON RIGHT_T.NAME = EXPRESSIONS.RIGHT_OPERAND) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, (CASE WHEN OPERATOR = '>' AND LEFT_VALUE > RIGHT_VALUE THEN 'true' WHEN OPERATOR = '<' AND LEFT_VALUE < RIGHT_VALUE THEN 'true' WHEN OPERATOR = '=' AND LEFT_VALUE = RIGHT_VALUE THEN 'true' ELSE 'false' END) AS VALUE FROM CTE;

/*
Prediction Result:
(None, 'evidence', None, 'false')
(None, 'news', None, 'false')
*/