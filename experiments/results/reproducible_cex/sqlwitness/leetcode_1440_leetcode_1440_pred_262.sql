-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO expressions (left_operand, operator, right_operand) VALUES ('false', '>', 'default1'), ('<', '<', 'default2'), ('<', '>', '>'), ('true', '=', 'true'), ('default2', '=', 'default1'), ('=', '=', '<');
INSERT INTO variables (name, value) VALUES ('>', 1), ('=', 0), ('<', 1), ('true', 0), ('false', 1), ('default1', 0), ('default2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('false', '>', 'default1', 'true')
('<', '<', 'default2', 'false')
('<', '>', '>', 'false')
('true', '=', 'true', 'true')
('default2', '=', 'default1', 'false')
('=', '=', '<', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '<' THEN IIF(V1.VALUE < V2.VALUE, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(V1.VALUE < V2.VALUE, 'true', 'false') ELSE IIF(V1.VALUE = V2.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS V1 ON V1.NAME = E.LEFT_OPERAND JOIN VARIABLES AS V2 ON V2.NAME = E.RIGHT_OPERAND;

/*
Prediction Result:
('false', '>', 'default1', 'false')
('<', '<', 'default2', 'false')
('<', '>', '>', 'false')
('true', '=', 'true', 'true')
('default2', '=', 'default1', 'false')
('=', '=', '<', 'false')
*/