-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "variables" ("name", "value") VALUES ('purpose', 1001);
INSERT INTO "variables" ("name", "value") VALUES ('brother', 1002);
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('purpose', 'ago', 'brother');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('purpose', 'ago', 'brother', 'false')
*/

-- Prediction Query
SELECT B.*, CASE WHEN B.OPERATOR = '>' THEN CASE WHEN A.VALUE > C.VALUE THEN 'true' ELSE 'false' END WHEN B.OPERATOR = '<' THEN CASE WHEN A.VALUE < C.VALUE THEN 'true' ELSE 'false' END WHEN B.OPERATOR = '=' THEN CASE WHEN A.VALUE = C.VALUE THEN 'true' ELSE 'false' END END AS VALUE FROM VARIABLES AS A INNER JOIN EXPRESSIONS AS B ON A.NAME = B.LEFT_OPERAND INNER JOIN VARIABLES AS C ON C.NAME = B.RIGHT_OPERAND;

/*
Prediction Result:
('purpose', 'ago', 'brother', None)
*/