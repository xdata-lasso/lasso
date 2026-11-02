-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Variables (name, value) VALUES ('v_null_1', NULL);
INSERT INTO Variables (name, value) VALUES ('v_null_2', NULL);
INSERT INTO Variables (name, value) VALUES ('v_num', 1);
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('v_null_1', '=', 'v_null_2');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('v_null_1', '<', 'v_num');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('v_null_1', '>', 'v_num');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('v_num', '=', 'v_null_1');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('v_null_1', '=', 'v_null_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('v_null_1', '=', 'v_null_2', 'false')
('v_null_1', '<', 'v_num', 'false')
('v_null_1', '>', 'v_num', 'false')
('v_num', '=', 'v_null_1', 'false')
('v_null_1', '=', 'v_null_1', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN V1.VALUE > V2.VALUE AND OPERATOR = '>' THEN 'true' WHEN V1.VALUE <= V2.VALUE AND OPERATOR = '>' THEN 'false' WHEN V1.VALUE < V2.VALUE AND OPERATOR = '<' THEN 'true' WHEN V1.VALUE >= V2.VALUE AND OPERATOR = '<' THEN 'false' WHEN V1.VALUE = V2.VALUE AND OPERATOR = '=' THEN 'true' WHEN V1.VALUE <> V2.VALUE AND OPERATOR = '=' THEN 'false' END AS VALUE FROM EXPRESSIONS JOIN VARIABLES AS V1 ON LEFT_OPERAND = V1.NAME JOIN VARIABLES AS V2 ON RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('v_null_1', '=', 'v_null_2', None)
('v_null_1', '<', 'v_num', None)
('v_null_1', '>', 'v_num', None)
('v_num', '=', 'v_null_1', None)
('v_null_1', '=', 'v_null_1', None)
*/