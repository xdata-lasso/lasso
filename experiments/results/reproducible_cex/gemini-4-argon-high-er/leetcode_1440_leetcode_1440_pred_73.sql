-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Variables (name, value) VALUES ('x', 1);
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('x', '=', 'x');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES (NULL, '=', 'x');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('x', '=', 'x', 'true')
*/

-- Prediction Query
WITH LEFT_DATA AS (SELECT E.LEFT_OPERAND, ROW_NUMBER() OVER () AS LEFT_ROW, E.OPERATOR, V.VALUE AS LEFT_VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V ON E.LEFT_OPERAND = V.NAME), RIGHT_DATA AS (SELECT E.RIGHT_OPERAND, ROW_NUMBER() OVER () AS RIGHT_ROW, E.OPERATOR, V.VALUE AS RIGHT_VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V ON E.RIGHT_OPERAND = V.NAME) SELECT L.LEFT_OPERAND, L.OPERATOR, R.RIGHT_OPERAND, CASE WHEN L.LEFT_VALUE > R.RIGHT_VALUE AND L.OPERATOR = '>' THEN 'true' WHEN L.LEFT_VALUE < R.RIGHT_VALUE AND L.OPERATOR = '<' THEN 'true' WHEN L.LEFT_VALUE = R.RIGHT_VALUE AND L.OPERATOR = '=' THEN 'true' ELSE 'false' END AS VALUE FROM RIGHT_DATA AS R INNER JOIN LEFT_DATA AS L ON R.RIGHT_ROW = L.LEFT_ROW;

/*
Prediction Result:
('x', '=', 'x', 'true')
(None, '=', 'x', 'false')
*/