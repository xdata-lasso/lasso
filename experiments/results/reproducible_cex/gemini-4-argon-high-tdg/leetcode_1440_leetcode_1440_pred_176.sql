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
WITH T AS (SELECT VALUE AS LVALUE, OPERATOR, NAME AS LEFT_OPERAND, RIGHT_OPERAND FROM EXPRESSIONS JOIN VARIABLES ON EXPRESSIONS.LEFT_OPERAND = VARIABLES.NAME), R AS (SELECT OPERATOR, VALUE AS RVALUE, LEFT_OPERAND, RIGHT_OPERAND FROM EXPRESSIONS JOIN VARIABLES ON EXPRESSIONS.RIGHT_OPERAND = VARIABLES.NAME), TMP AS (SELECT T.LVALUE, T.LEFT_OPERAND, T.OPERATOR, T.RIGHT_OPERAND, R.RVALUE FROM T JOIN R ON T.LEFT_OPERAND = R.LEFT_OPERAND AND T.RIGHT_OPERAND = R.RIGHT_OPERAND AND T.OPERATOR = R.OPERATOR) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(LVALUE > RVALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(LVALUE = RVALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(LVALUE < RVALUE, 'true', 'false') END AS VALUE FROM TMP;

/*
Prediction Result:
('p', '!=', 'q', None)
('p', '<=', 'q', None)
('p', '>=', 'q', None)
('p', '!=', 'r', None)
('p', '<=', 'r', None)
('r', '>=', 'p', None)
*/