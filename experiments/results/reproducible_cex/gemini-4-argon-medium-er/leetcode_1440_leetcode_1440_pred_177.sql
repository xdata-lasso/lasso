-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Variables" ("name", "value") VALUES ('x', 1);
INSERT INTO "Variables" ("name", "value") VALUES ('y', 2);
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES ('x', '!', 'y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('x', '!', 'y', 'false')
*/

-- Prediction Query
WITH T AS (SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, LV.NAME AS LV_NAME, LV.VALUE AS LV_VALUE, RV.NAME AS RV_NAME, RV.VALUE AS RV_VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS LV ON E.LEFT_OPERAND = LV.NAME LEFT JOIN VARIABLES AS RV ON E.RIGHT_OPERAND = RV.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(LV_VALUE > RV_VALUE = 1, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(LV_VALUE = RV_VALUE = 1, 'true', 'false') ELSE IIF(LV_VALUE < RV_VALUE = 1, 'true', 'false') END AS VALUE FROM T;

/*
Prediction Result:
('x', '!', 'y', 'true')
*/