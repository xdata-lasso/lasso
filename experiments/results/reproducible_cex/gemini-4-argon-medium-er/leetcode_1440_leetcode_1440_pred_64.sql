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
SELECT A.LEFT_OPERAND AS LEFT_OPERAND, A.OPERATOR AS OPERATOR, A.RIGHT_OPERAND AS RIGHT_OPERAND, (CASE WHEN A.OPERATOR = '>' THEN IIF(B.VALUE > C.VALUE, 'true', 'false') WHEN A.OPERATOR = '<' THEN IIF(B.VALUE < C.VALUE, 'true', 'false') ELSE IIF(B.VALUE = C.VALUE, 'true', 'false') END) AS VALUE FROM EXPRESSIONS AS A LEFT JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME LEFT JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Prediction Result:
('x', '!=', 'x', 'true')
*/