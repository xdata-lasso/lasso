-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Variables" ("name", "value") VALUES ('x', 1);
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES ('x', '!=', 'x');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('x', '!=', 'x', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN VALUE = 1 THEN 'true' ELSE 'false' END AS VALUE FROM (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '<' THEN V1.VALUE < V2.VALUE WHEN OPERATOR = '>' THEN V1.VALUE > V2.VALUE ELSE V1.VALUE = V2.VALUE END AS VALUE FROM VARIABLES AS V1 CROSS JOIN EXPRESSIONS AS E CROSS JOIN VARIABLES AS V2 WHERE V1.NAME = E.LEFT_OPERAND AND V2.NAME = E.RIGHT_OPERAND) AS T;

/*
Prediction Result:
('x', '!=', 'x', 'true')
*/