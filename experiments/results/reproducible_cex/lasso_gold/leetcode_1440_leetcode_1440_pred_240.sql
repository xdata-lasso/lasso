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
WITH T AS (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, VL.VALUE AS LEFT_OPERAND_VALUE, VR.VALUE AS RIGHT_OPERAND_VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS VL ON E.LEFT_OPERAND = VL.NAME LEFT JOIN VARIABLES AS VR ON E.RIGHT_OPERAND = VR.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, (CASE WHEN OPERATOR = '>' AND LEFT_OPERAND_VALUE > RIGHT_OPERAND_VALUE THEN 'true' WHEN OPERATOR = '<' AND LEFT_OPERAND_VALUE < RIGHT_OPERAND_VALUE THEN 'true' WHEN OPERATOR = '=' AND LEFT_OPERAND_VALUE = RIGHT_OPERAND_VALUE THEN 'true' ELSE 'false' END) AS VALUE FROM T;

/*
Prediction Result:
(None, 'evidence', None, 'false')
(None, 'news', None, 'false')
*/