-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO expressions (left_operand, operator, right_operand) VALUES ('false', '>', 'default2'), ('<', '<', '<'), ('<', '<', '='), ('<', '<', 'default1'), ('false', '>', '>'), ('<', '<', 'false'), ('<', '>', 'default2');
INSERT INTO variables (name, value) VALUES ('default2', 1), ('=', 1), ('>', -1), ('false', -1), ('<', -1), ('true', -1), ('default1', NULL), ('unique_7', 0), ('unique_8', -1), ('unique_9', -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('false', '>', 'default2', 'false')
('<', '<', '<', 'false')
('<', '<', '=', 'true')
('<', '<', 'default1', 'false')
('false', '>', '>', 'false')
('<', '<', 'false', 'false')
('<', '>', 'default2', 'false')
*/

-- Prediction Query
WITH T AS (SELECT E.*, V1.VALUE - V2.VALUE AS DELTA FROM EXPRESSIONS AS E JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME ORDER BY RIGHT_OPERAND DESC, OPERATOR, E.left_operand NULLS LAST, V1.name NULLS LAST, V2.name NULLS LAST) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN (OPERATOR = '>' AND DELTA > 0) THEN 'true' WHEN (OPERATOR = '>' AND DELTA <= 0) THEN 'false' WHEN (OPERATOR = '<' AND DELTA >= 0) THEN 'false' WHEN (OPERATOR = '<' AND DELTA < 0) THEN 'true' WHEN (OPERATOR = '=' AND DELTA = 0) THEN 'true' WHEN (OPERATOR = '=' AND DELTA <> 0) THEN 'false' ELSE NULL END AS VALUE FROM T;

/*
Prediction Result:
('<', '<', 'false', 'false')
('<', '>', 'default2', 'false')
('false', '>', 'default2', 'false')
('<', '<', 'default1', None)
('false', '>', '>', 'false')
('<', '<', '=', 'true')
('<', '<', '<', 'false')
*/