-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO expressions (left_operand, operator, right_operand) VALUES ('default1', '<', 'false'), ('false', '=', 'default2'), ('>', '<', 'true'), ('true', '<', 'true'), ('false', '>', '>'), ('=', '<', '<'), ('false', '<', '>');
INSERT INTO variables (name, value) VALUES ('false', 4), ('true', 3), ('=', NULL), ('<', 4), ('default2', 0), ('>', NULL), ('default1', 3), ('unique_7', 2), ('unique_8', 3), ('unique_9', NULL), ('unique_10', 2), ('unique_11', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('default1', '<', 'false', 'true')
('false', '=', 'default2', 'false')
('>', '<', 'true', 'false')
('true', '<', 'true', 'false')
('false', '>', '>', 'false')
('=', '<', '<', 'false')
('false', '<', '>', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '=' AND V1.VALUE = V2.VALUE THEN 'true' WHEN OPERATOR = '>' AND V1.VALUE > V2.VALUE THEN 'true' WHEN OPERATOR = '<' AND V1.VALUE < V2.VALUE THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS E1 JOIN VARIABLES AS V1 ON E1.LEFT_OPERAND = V1.NAME JOIN VARIABLES AS V2 ON E1.RIGHT_OPERAND = V2.NAME ORDER BY 1, 2, 3 DESC, E1.left_operand NULLS LAST, E1.operator NULLS LAST, E1.right_operand NULLS LAST, V1.name NULLS LAST, V2.name NULLS LAST;

/*
Prediction Result:
('=', '<', '<', 'false')
('>', '<', 'true', 'false')
('default1', '<', 'false', 'true')
('false', '<', '>', 'false')
('false', '=', 'default2', 'false')
('false', '>', '>', 'false')
('true', '<', 'true', 'false')
*/