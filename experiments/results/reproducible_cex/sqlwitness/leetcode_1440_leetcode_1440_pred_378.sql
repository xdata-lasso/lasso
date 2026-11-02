-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO expressions (left_operand, operator, right_operand) VALUES ('>', '<', '='), ('default1', '>', '<'), ('=', '<', 'false'), ('<', '=', '>'), ('=', '=', 'default2');
INSERT INTO variables (name, value) VALUES ('true', NULL), ('default2', 0), ('false', 1), ('<', 0), ('>', 1), ('=', NULL), ('default1', NULL), ('unique_7', 1), ('unique_8', 1), ('unique_9', NULL), ('unique_10', NULL), ('unique_11', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('>', '<', '=', 'false')
('default1', '>', '<', 'false')
('=', '<', 'false', 'false')
('<', '=', '>', 'false')
('=', '=', 'default2', 'false')
*/

-- Prediction Query
WITH A AS (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN V1.VALUE > V2.VALUE THEN '>' WHEN V1.VALUE < V2.VALUE THEN '<' ELSE '=' END AS OPERATOR1 FROM EXPRESSIONS AS E INNER JOIN VARIABLES AS V1 ON V1.NAME = LEFT_OPERAND INNER JOIN VARIABLES AS V2 ON V2.NAME = RIGHT_OPERAND) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, IIF(OPERATOR = OPERATOR1, 'true', 'false') AS VALUE FROM A;

/*
Prediction Result:
('>', '<', '=', 'false')
('default1', '>', '<', 'false')
('=', '<', 'false', 'false')
('<', '=', '>', 'false')
('=', '=', 'default2', 'true')
*/