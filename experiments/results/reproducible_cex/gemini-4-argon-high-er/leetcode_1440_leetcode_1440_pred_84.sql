-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Variables (name, value) VALUES ('x', 1);
INSERT INTO Variables (name, value) VALUES ('y', 2);
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('x', '<', 'y');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('x', '!=', 'y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('x', '<', 'y', 'true')
('x', '!=', 'y', 'false')
*/

-- Prediction Query
WITH CTE AS (SELECT V.NAME AS LEFT_OPERAND, V.VALUE AS LEFT, OPERATOR, S.NAME AS RIGHT_OPERAND, S.VALUE AS RIGHT FROM EXPRESSIONS AS E JOIN VARIABLES AS V ON E.LEFT_OPERAND = V.NAME JOIN VARIABLES AS S ON E.RIGHT_OPERAND = S.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '=' THEN IIF(LEFT = RIGHT, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(LEFT > RIGHT, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(LEFT < RIGHT, 'true', 'false') ELSE NULL END AS VALUE FROM CTE;

/*
Prediction Result:
('x', '<', 'y', 'true')
('x', '!=', 'y', None)
*/