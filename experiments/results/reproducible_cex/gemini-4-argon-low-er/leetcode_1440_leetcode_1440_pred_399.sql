-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Variables" ("name", "value") VALUES ('x', 1);
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES ('x', '=', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
*/

-- Prediction Query
WITH VALS AS (SELECT LEFT_OPERAND, V.VALUE AS L_VALUE, OPERATOR, RIGHT_OPERAND, V1.VALUE AS R_VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS V ON V.NAME = E.LEFT_OPERAND LEFT JOIN VARIABLES AS V1 ON V1.NAME = E.RIGHT_OPERAND) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' AND L_VALUE > R_VALUE THEN 'true' WHEN OPERATOR = '<' AND L_VALUE < R_VALUE THEN 'true' WHEN OPERATOR = '=' AND L_VALUE = R_VALUE THEN 'true' ELSE 'false' END AS VALUE FROM VALS;

/*
Prediction Result:
('x', '=', None, 'false')
*/