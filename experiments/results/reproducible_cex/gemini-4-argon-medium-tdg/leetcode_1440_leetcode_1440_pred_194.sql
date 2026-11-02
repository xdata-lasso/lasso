-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Variables (name, value) VALUES ('n1', NULL);
INSERT INTO Variables (name, value) VALUES ('n2', NULL);
INSERT INTO Variables (name, value) VALUES ('v1', 10);
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('n1', '=', 'n2');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('n1', '<', 'v1');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('v1', '>', 'n1');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('n1', '=', 'n1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('n1', '=', 'n2', 'false')
('n1', '<', 'v1', 'false')
('v1', '>', 'n1', 'false')
('n1', '=', 'n1', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' AND V1.VALUE > V2.VALUE THEN 'true' WHEN OPERATOR = '>' AND V1.VALUE <= V2.VALUE THEN 'false' WHEN OPERATOR = '<' AND V1.VALUE < V2.VALUE THEN 'true' WHEN OPERATOR = '<' AND V1.VALUE >= V2.VALUE THEN 'false' WHEN OPERATOR = '=' AND V1.VALUE = V2.VALUE THEN 'true' WHEN OPERATOR = '=' AND V1.VALUE <> V2.VALUE THEN 'false' END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('n1', '=', 'n2', None)
('n1', '<', 'v1', None)
('v1', '>', 'n1', None)
('n1', '=', 'n1', None)
*/