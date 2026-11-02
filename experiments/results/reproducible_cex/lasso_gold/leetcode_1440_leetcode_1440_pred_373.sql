-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES (NULL, 'evidence', NULL);
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES (NULL, 'news', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.LEFT_OPERAND, A.OPERATOR, A.RIGHT_OPERAND, (CASE WHEN A.OPERATOR = '<' AND V1.VALUE < V2.VALUE THEN 'true' WHEN A.OPERATOR = '=' AND V1.VALUE = V2.VALUE THEN 'true' WHEN A.OPERATOR = '>' AND V1.VALUE > V2.VALUE THEN 'true' ELSE 'false' END) AS VALUE FROM EXPRESSIONS AS A LEFT JOIN VARIABLES AS V1 ON A.LEFT_OPERAND = V1.NAME LEFT JOIN VARIABLES AS V2 ON A.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
(None, 'evidence', None, 'false')
(None, 'news', None, 'false')
*/