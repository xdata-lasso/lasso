-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO Variables (name, value) VALUES ('p', 7);
INSERT INTO Variables (name, value) VALUES ('q', 7);
INSERT INTO Variables (name, value) VALUES ('r', 8);
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('p', '!=', 'q');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('p', '<=', 'q');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('p', '>=', 'q');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('p', '!=', 'r');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('p', '<=', 'r');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('r', '>=', 'p');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('p', '!=', 'q', 'false')
('p', '<=', 'q', 'false')
('p', '>=', 'q', 'false')
('p', '!=', 'r', 'false')
('p', '<=', 'r', 'false')
('r', '>=', 'p', 'false')
*/

-- Prediction Query
WITH CTE1 AS (SELECT LEFT_OPERAND, VALUE AS LEFT_VALUE, OPERATOR, RIGHT_OPERAND AS RESERVED_RIGHT FROM EXPRESSIONS INNER JOIN VARIABLES ON LEFT_OPERAND = NAME), CTE2 AS (SELECT RIGHT_OPERAND, VALUE AS RIGHT_VALUE, OPERATOR, LEFT_OPERAND AS RESERVED_LEFT FROM EXPRESSIONS INNER JOIN VARIABLES ON RIGHT_OPERAND = NAME), CTE3 AS (SELECT LEFT_OPERAND, LEFT_VALUE, A.OPERATOR, RIGHT_OPERAND, RIGHT_VALUE FROM CTE1 AS A INNER JOIN CTE2 AS B ON A.OPERATOR = B.OPERATOR AND LEFT_OPERAND = RESERVED_LEFT AND RIGHT_OPERAND = RESERVED_RIGHT) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(LEFT_VALUE > RIGHT_VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(LEFT_VALUE = RIGHT_VALUE, 'true', 'false') ELSE IIF(LEFT_VALUE < RIGHT_VALUE, 'true', 'false') END AS VALUE FROM CTE3;

/*
Prediction Result:
('p', '!=', 'q', 'false')
('p', '<=', 'q', 'false')
('p', '>=', 'q', 'false')
('p', '!=', 'r', 'true')
('p', '<=', 'r', 'true')
('r', '>=', 'p', 'false')
*/