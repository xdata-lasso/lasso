-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Variables" ("name", "value") VALUES ('x', 1);
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES (NULL, '=', 'x');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, IIF((CASE WHEN OPERATOR = '>' THEN (LEFT_VAL > RIGHT_VAL) WHEN OPERATOR = '<' THEN (LEFT_VAL < RIGHT_VAL) WHEN OPERATOR = '=' THEN (LEFT_VAL = RIGHT_VAL) ELSE 0 END) = 1, 'true', 'false') AS VALUE FROM (SELECT E.*, X.VALUE AS LEFT_VAL, Y.VALUE AS RIGHT_VAL FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS X ON X.NAME = E.LEFT_OPERAND LEFT JOIN VARIABLES AS Y ON Y.NAME = E.RIGHT_OPERAND) AS XX;

/*
Prediction Result:
(None, '=', 'x', 'false')
*/