-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Variables (name, value) VALUES ('x', 1);
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('x', '!=', 'x');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('x', '!=', 'x', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN CASE WHEN V_LEFT.VALUE > V_RIGHT.VALUE THEN 'true' ELSE 'false' END WHEN OPERATOR = '<' THEN CASE WHEN V_LEFT.VALUE < V_RIGHT.VALUE THEN 'true' ELSE 'false' END ELSE CASE WHEN V_LEFT.VALUE = V_RIGHT.VALUE THEN 'true' ELSE 'false' END END AS VALUE FROM EXPRESSIONS AS E INNER JOIN VARIABLES AS V_LEFT ON TRUE INNER JOIN VARIABLES AS V_RIGHT ON E.LEFT_OPERAND = V_LEFT.NAME AND E.RIGHT_OPERAND = V_RIGHT.NAME;

/*
Prediction Result:
('x', '!=', 'x', 'true')
*/