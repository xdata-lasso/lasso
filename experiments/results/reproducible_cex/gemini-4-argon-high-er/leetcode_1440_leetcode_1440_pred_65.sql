-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Variables (name, value) VALUES ('x', 1);
INSERT INTO Variables (name, value) VALUES ('y', 2);
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('x', '=', 'y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('x', '=', 'y', 'false')
*/

-- Prediction Query
SELECT C1.LEFT_OPERAND, C1.OPERATOR, C1.RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(C1.VALUE > C1.OTHER, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(C1.VALUE < C1.OTHER, 'true', 'false') ELSE IIF(C1.VALUE = C1.OTHER, 'true', 'false') END AS VALUE FROM (WITH CTE AS (SELECT V.VALUE, E.* FROM VARIABLES AS V INNER JOIN EXPRESSIONS AS E ON V.NAME = E.LEFT_OPERAND UNION ALL SELECT E.*, V.VALUE FROM VARIABLES AS V INNER JOIN EXPRESSIONS AS E ON V.NAME = E.RIGHT_OPERAND) SELECT DISTINCT A1.*, A2.VALUE AS OTHER FROM CTE AS A1 INNER JOIN CTE AS A2 ON A1.RIGHT_OPERAND = A2.LEFT_OPERAND) AS C1;

/*
Prediction Result:
*/