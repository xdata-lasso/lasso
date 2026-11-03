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
SELECT T.LEFT_OPERAND, T.OPERATOR, T.RIGHT_OPERAND, (CASE WHEN OPERATOR = '>' AND T.VX > T.VY THEN 'true' WHEN OPERATOR = '=' AND T.VX = T.VY THEN 'true' WHEN OPERATOR = '<' AND T.VX < T.VY THEN 'true' ELSE 'false' END) AS VALUE FROM (SELECT A.LEFT_OPERAND, A.OPERATOR, A.RIGHT_OPERAND, A.VX, VYY.VALUE AS VY FROM (SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, V.VALUE AS VX FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V ON E.LEFT_OPERAND = V.NAME) AS A LEFT JOIN VARIABLES AS VYY ON A.RIGHT_OPERAND = VYY.NAME) AS T;

/*
Prediction Result:
(None, 'evidence', None, 'false')
(None, 'news', None, 'false')
*/