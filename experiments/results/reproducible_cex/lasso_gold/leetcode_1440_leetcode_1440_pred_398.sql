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
WITH C1 AS (SELECT E.*, V.VALUE AS LEFT_V FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V ON E.LEFT_OPERAND = V.NAME), C2 AS (SELECT E.*, V.VALUE AS RIGHT_V FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V ON E.RIGHT_OPERAND = V.NAME) SELECT C1.LEFT_OPERAND, C1.OPERATOR, C1.RIGHT_OPERAND, (CASE WHEN C1.OPERATOR = '>' AND C1.LEFT_V > C2.RIGHT_V THEN 'true' WHEN C1.OPERATOR = '>' AND C1.LEFT_V < C2.RIGHT_V THEN 'false' WHEN C1.OPERATOR = '<' AND C1.LEFT_V < C2.RIGHT_V THEN 'true' WHEN C1.OPERATOR = '<' AND C1.LEFT_V > C2.RIGHT_V THEN 'false' WHEN C1.OPERATOR = '=' AND C1.LEFT_V = C2.RIGHT_V THEN 'true' ELSE 'false' END) AS VALUE FROM C1 LEFT JOIN C2 ON C1.LEFT_OPERAND = C2.LEFT_OPERAND AND C1.OPERATOR = C2.OPERATOR AND C1.RIGHT_OPERAND = C2.RIGHT_OPERAND;

/*
Prediction Result:
(None, 'evidence', None, 'false')
(None, 'news', None, 'false')
*/