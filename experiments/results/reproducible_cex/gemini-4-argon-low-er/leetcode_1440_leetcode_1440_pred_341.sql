-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Variables" ("name", "value") VALUES ('a', 1);
INSERT INTO "Variables" ("name", "value") VALUES ('b', 2);
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES ('a', '!', 'b');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a', '!', 'b', 'false')
*/

-- Prediction Query
WITH CTE AS (SELECT V.VALUE AS LEFT_, E.LEFT_OPERAND, E.OPERATOR, ROW_NUMBER() OVER () AS RN FROM VARIABLES AS V INNER JOIN EXPRESSIONS AS E ON V.NAME = E.LEFT_OPERAND), CTE1 AS (SELECT V.VALUE AS RIGHT_, E.RIGHT_OPERAND, ROW_NUMBER() OVER () AS RN FROM VARIABLES AS V INNER JOIN EXPRESSIONS AS E ON V.NAME = E.RIGHT_OPERAND) SELECT CTE.LEFT_OPERAND, CTE.OPERATOR, CTE1.RIGHT_OPERAND, CASE WHEN CTE.OPERATOR = '=' THEN CASE WHEN CTE.LEFT_ = CTE1.RIGHT_ THEN 'true' ELSE 'false' END WHEN CTE.OPERATOR = '>' THEN CASE WHEN CTE.LEFT_ > CTE1.RIGHT_ THEN 'true' ELSE 'false' END WHEN CTE.OPERATOR = '<' THEN CASE WHEN CTE.LEFT_ < CTE1.RIGHT_ THEN 'true' ELSE 'false' END END AS VALUE FROM CTE INNER JOIN CTE1 ON CTE.RN = CTE1.RN;

/*
Prediction Result:
('a', '!', 'b', None)
*/