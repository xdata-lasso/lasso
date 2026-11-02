-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Variables (name, value) VALUES ('x', 1);
INSERT INTO Variables (name, value) VALUES ('y', 2);
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('x', '!=', 'y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('x', '!=', 'y', 'false')
*/

-- Prediction Query
WITH TB AS (SELECT E.*, V.VALUE AS LEFT_V, V1.VALUE AS RIGHT_V FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V ON E.LEFT_OPERAND = V.NAME LEFT JOIN VARIABLES AS V1 ON E.RIGHT_OPERAND = V1.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, (CASE WHEN OPERATOR = '>' THEN IIF(LEFT_V > RIGHT_V, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(LEFT_V = RIGHT_V, 'true', 'false') ELSE IIF(LEFT_V < RIGHT_V, 'true', 'false') END) AS VALUE FROM TB;

/*
Prediction Result:
('x', '!=', 'y', 'true')
*/