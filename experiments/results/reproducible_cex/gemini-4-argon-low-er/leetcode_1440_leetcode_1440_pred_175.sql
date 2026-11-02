-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES (NULL, '=', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
*/

-- Prediction Query
WITH T AS (SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, V.NAME AS NA, V.VALUE AS VA, V1.NAME AS NA2, V1.VALUE AS VA2 FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V ON V.NAME = E.LEFT_OPERAND LEFT JOIN VARIABLES AS V1 ON V1.NAME = E.RIGHT_OPERAND) SELECT T.LEFT_OPERAND, T.OPERATOR, T.RIGHT_OPERAND, CASE WHEN OPERATOR = '>' AND T.VA > T.VA2 THEN 'true' WHEN OPERATOR = '=' AND T.VA = T.VA2 THEN 'true' WHEN OPERATOR = '<' AND T.VA < T.VA2 THEN 'true' ELSE 'false' END AS VALUE FROM T;

/*
Prediction Result:
(None, '=', None, 'false')
*/