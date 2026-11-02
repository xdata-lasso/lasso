-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "variables" ("name", "value") VALUES ('Matthew Gardner', 1007);
INSERT INTO "variables" ("name", "value") VALUES ('discussion', 1008);
INSERT INTO "variables" ("name", "value") VALUES ('list', NULL);
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('discussion', '=', 'list');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('discussion', '=', 'list', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, IIF(OPERATOR = RESULT, 'true', 'false') AS VALUE FROM (SELECT A.*, CASE WHEN B.VALUE > C.VALUE THEN '>' WHEN B.VALUE < C.VALUE THEN '<' ELSE '=' END AS RESULT FROM EXPRESSIONS AS A INNER JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME INNER JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME) AS T;

/*
Prediction Result:
('discussion', '=', 'list', 'true')
*/