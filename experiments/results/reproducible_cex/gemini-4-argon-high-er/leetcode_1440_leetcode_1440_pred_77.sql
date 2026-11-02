-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Variables (name, value) VALUES ('x', 10);
INSERT INTO Variables (name, value) VALUES ('y', 5);
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
WITH CTE AS (SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, (SELECT VALUE FROM VARIABLES WHERE NAME = E.LEFT_OPERAND) AS LEFT_VALUE, (SELECT VALUE FROM VARIABLES WHERE NAME = E.RIGHT_OPERAND) AS RIGHT_VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V ON V.NAME = E.LEFT_OPERAND OR V.NAME = E.RIGHT_OPERAND) SELECT DISTINCT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, IIF((CASE WHEN OPERATOR = '<' THEN LEFT_VALUE < RIGHT_VALUE WHEN OPERATOR = '=' THEN LEFT_VALUE = RIGHT_VALUE ELSE LEFT_VALUE > RIGHT_VALUE END), 'true', 'false') AS VALUE FROM CTE;

/*
Prediction Result:
('x', '!=', 'y', 'true')
*/