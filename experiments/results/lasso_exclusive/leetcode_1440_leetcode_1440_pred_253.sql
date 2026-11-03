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
SELECT T2.LEFT_OPERAND, T2.OPERATOR, T2.RIGHT_OPERAND, (CASE WHEN T2.OPERATOR = '>' THEN IIF(T2.LEFT_VALUE > T2.RIGHT_VALUE, 'true', 'false') WHEN T2.OPERATOR = '<' THEN IIF(T2.LEFT_VALUE < T2.RIGHT_VALUE, 'true', 'false') WHEN T2.OPERATOR = '=' THEN IIF(T2.LEFT_VALUE = T2.RIGHT_VALUE, 'true', 'false') ELSE 'false' END) AS VALUE FROM (SELECT T1.LEFT_OPERAND, T1.OPERATOR, T1.RIGHT_OPERAND, T3.VALUE AS LEFT_VALUE, T4.VALUE AS RIGHT_VALUE FROM EXPRESSIONS AS T1 LEFT JOIN VARIABLES AS T3 ON T1.LEFT_OPERAND = T3.NAME LEFT JOIN VARIABLES AS T4 ON T1.RIGHT_OPERAND = T4.NAME) AS T2;

/*
Prediction Result:
(None, 'evidence', None, 'false')
(None, 'news', None, 'false')
*/