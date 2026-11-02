-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "variables" ("name", "value") VALUES ('Allison Hill', 1001);
INSERT INTO "variables" ("name", "value") VALUES ('Leslie Johnson', 1001);
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('Allison Hill', 'dog', 'Allison Hill');
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('Allison Hill', 'better', 'Allison Hill');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('Allison Hill', 'dog', 'Allison Hill', 'false')
('Allison Hill', 'better', 'Allison Hill', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, IIF(OPERATOR = '>', IIF(VALUE1 > VALUE2, 'true', 'false'), IIF(OPERATOR = '<', IIF(VALUE1 < VALUE2, 'true', 'false'), IIF(VALUE1 = VALUE2, 'true', 'false'))) AS VALUE FROM (SELECT E.*, V.VALUE AS VALUE1, V1.VALUE AS VALUE2 FROM VARIABLES AS V JOIN EXPRESSIONS AS E ON E.LEFT_OPERAND = V.NAME JOIN VARIABLES AS V1 ON V1.NAME = E.RIGHT_OPERAND) AS FF;

/*
Prediction Result:
('Allison Hill', 'dog', 'Allison Hill', 'true')
('Allison Hill', 'better', 'Allison Hill', 'true')
*/