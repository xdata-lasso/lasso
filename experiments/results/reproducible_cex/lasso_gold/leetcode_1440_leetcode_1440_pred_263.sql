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
WITH C1 AS (SELECT E.*, V1.VALUE AS X, V2.VALUE AS Y FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME LEFT JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME), C2 AS (SELECT *, CASE WHEN X > Y THEN '>' WHEN X < Y THEN '<' ELSE '=' END AS RELATION FROM C1) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN RELATION = OPERATOR THEN 'true' ELSE 'false' END AS VALUE FROM C2;

/*
Prediction Result:
(None, 'evidence', None, 'false')
(None, 'news', None, 'false')
*/