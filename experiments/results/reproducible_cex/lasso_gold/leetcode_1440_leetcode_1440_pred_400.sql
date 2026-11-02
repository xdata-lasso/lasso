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
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN E.OPERATOR = '<' AND E.LEFT_OPERAND = L.NAME AND E.RIGHT_OPERAND = R.NAME THEN CASE WHEN L.VALUE < R.VALUE THEN 'true' ELSE 'false' END WHEN E.OPERATOR = '<' AND E.LEFT_OPERAND = L.NAME AND E.RIGHT_OPERAND = R.NAME THEN CASE WHEN R.VALUE < L.VALUE THEN 'true' ELSE 'false' END WHEN E.OPERATOR = '>' AND E.LEFT_OPERAND = L.NAME AND E.RIGHT_OPERAND = R.NAME THEN CASE WHEN L.VALUE > R.VALUE THEN 'true' ELSE 'false' END WHEN E.OPERATOR = '>' AND E.LEFT_OPERAND = L.NAME AND E.RIGHT_OPERAND = R.NAME THEN CASE WHEN R.VALUE > L.VALUE THEN 'true' ELSE 'false' END WHEN E.OPERATOR = '=' THEN CASE WHEN E.LEFT_OPERAND = E.RIGHT_OPERAND AND L.VALUE = L.VALUE THEN 'true' WHEN E.LEFT_OPERAND <> E.RIGHT_OPERAND AND L.VALUE = R.VALUE THEN 'true' ELSE 'false' END ELSE 'false' END AS VALUE FROM EXPRESSIONS AS E LEFT OUTER JOIN VARIABLES AS L ON E.LEFT_OPERAND = L.NAME LEFT OUTER JOIN VARIABLES AS R ON E.RIGHT_OPERAND = R.NAME;

/*
Prediction Result:
(None, 'evidence', None, 'false')
(None, 'news', None, 'false')
*/