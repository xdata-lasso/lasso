-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO expressions (left_operand, operator, right_operand) VALUES ('true', '<', '='), ('=', '>', 'default2'), ('false', '>', 'true'), ('<', '>', '='), ('=', '<', '>'), ('default1', '<', 'default2'), ('true', '=', '='), ('true', '>', '<'), ('<', '=', 'true'), ('default1', '<', '=');
INSERT INTO variables (name, value) VALUES ('default1', 0), ('true', 1), ('>', 1), ('<', 1), ('=', 1), ('false', NULL), ('default2', NULL), ('unique_7', 0), ('unique_8', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('true', '<', '=', 'false')
('=', '>', 'default2', 'false')
('false', '>', 'true', 'false')
('<', '>', '=', 'false')
('=', '<', '>', 'false')
('default1', '<', 'default2', 'false')
('true', '=', '=', 'true')
('true', '>', '<', 'false')
('<', '=', 'true', 'true')
('default1', '<', '=', 'true')
*/

-- Prediction Query
SELECT R.LEFT_OPERAND, R.OPERATOR, R.RIGHT_OPERAND, (CASE WHEN R.OPERATOR = '=' AND R.LEFT_OPERAND_VAL = R.RIGHT_OPERAND_VAL THEN 'true' WHEN R.OPERATOR = '=' AND R.LEFT_OPERAND_VAL <> R.RIGHT_OPERAND_VAL THEN 'false' WHEN R.OPERATOR = '<' AND R.LEFT_OPERAND_VAL < R.RIGHT_OPERAND_VAL THEN 'true' WHEN R.OPERATOR = '<' AND R.LEFT_OPERAND_VAL >= R.RIGHT_OPERAND_VAL THEN 'false' WHEN R.OPERATOR = '>' AND R.LEFT_OPERAND_VAL > R.RIGHT_OPERAND_VAL THEN 'true' WHEN R.OPERATOR = '>' AND R.LEFT_OPERAND_VAL <= R.RIGHT_OPERAND_VAL THEN 'false' END) AS VALUE FROM (SELECT L.LEFT_OPERAND_VAL, L.OPERATOR, V.VALUE AS RIGHT_OPERAND_VAL, L.LEFT_OPERAND, L.RIGHT_OPERAND FROM (SELECT V.VALUE AS LEFT_OPERAND_VAL, E.OPERATOR, E.RIGHT_OPERAND, E.LEFT_OPERAND FROM EXPRESSIONS AS E JOIN VARIABLES AS V ON E.LEFT_OPERAND = V.NAME) AS L JOIN VARIABLES AS V ON L.RIGHT_OPERAND = V.NAME) AS R;

/*
Prediction Result:
('true', '<', '=', 'false')
('=', '>', 'default2', None)
('false', '>', 'true', None)
('<', '>', '=', 'false')
('=', '<', '>', 'false')
('default1', '<', 'default2', None)
('true', '=', '=', 'true')
('true', '>', '<', 'false')
('<', '=', 'true', 'true')
('default1', '<', '=', 'true')
*/