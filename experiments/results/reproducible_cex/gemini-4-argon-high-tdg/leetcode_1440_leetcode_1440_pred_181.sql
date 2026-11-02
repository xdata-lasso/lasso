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
WITH TEM AS (SELECT A.*, B.VALUE AS LEFT_VALUE FROM EXPRESSIONS AS A LEFT JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME), TEM1 AS (SELECT T.*, B.VALUE AS RIGHT_VALUE FROM TEM AS T LEFT JOIN VARIABLES AS B ON T.RIGHT_OPERAND = B.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN VALUE = 1 THEN 'true' ELSE 'false' END AS VALUE FROM (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN (LEFT_VALUE > RIGHT_VALUE) WHEN OPERATOR = '=' THEN (LEFT_VALUE = RIGHT_VALUE) ELSE (LEFT_VALUE < RIGHT_VALUE) END AS VALUE FROM TEM1) AS A;

/*
Prediction Result:
('p', '!=', 'q', 'false')
('p', '<=', 'q', 'false')
('p', '>=', 'q', 'false')
('p', '!=', 'r', 'true')
('p', '<=', 'r', 'true')
('r', '>=', 'p', 'false')
*/