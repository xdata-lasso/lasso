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
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN VALUE = 1 THEN 'true' ELSE 'false' END AS VALUE FROM (SELECT J2.LEFT_OPERAND, J2.OPERATOR, J2.RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN (LEFT_VAL > RIGHT_VAL) WHEN OPERATOR = '<' THEN (LEFT_VAL < RIGHT_VAL) WHEN OPERATOR = '=' THEN (LEFT_VAL = RIGHT_VAL) END AS VALUE FROM (SELECT J1.*, V.VALUE AS RIGHT_VAL FROM (SELECT E.*, V.VALUE AS LEFT_VAL FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V ON E.LEFT_OPERAND = V.NAME) AS J1 LEFT JOIN VARIABLES AS V ON J1.RIGHT_OPERAND = V.NAME) AS J2) AS S;

/*
Prediction Result:
(None, '=', 'x', 'false')
*/