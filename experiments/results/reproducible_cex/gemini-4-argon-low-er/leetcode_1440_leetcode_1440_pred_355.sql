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
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE E.OPERATOR WHEN '>' THEN CASE WHEN LV.VALUE > RV.VALUE THEN 'true' ELSE 'false' END WHEN '<' THEN CASE WHEN LV.VALUE < RV.VALUE THEN 'true' ELSE 'false' END ELSE CASE WHEN LV.VALUE = RV.VALUE THEN 'true' ELSE 'false' END END AS VALUE FROM EXPRESSIONS AS E INNER JOIN VARIABLES AS LV ON E.LEFT_OPERAND = LV.NAME INNER JOIN VARIABLES AS RV ON E.RIGHT_OPERAND = RV.NAME;

/*
Prediction Result:
('x', '!=', 'x', 'true')
*/