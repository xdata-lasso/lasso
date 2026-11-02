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
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, IIF(VAL = 0, 'false', 'true') AS VALUE FROM (WITH TEMP_TABLE AS (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, LEFT_VAL, VALUE AS RIGHT_VAL FROM VARIABLES AS V INNER JOIN (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, VALUE AS LEFT_VAL, NAME FROM EXPRESSIONS INNER JOIN VARIABLES ON NAME = LEFT_OPERAND) AS T ON V.NAME = T.RIGHT_OPERAND) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN (LEFT_VAL > RIGHT_VAL) WHEN OPERATOR = '<' THEN (LEFT_VAL < RIGHT_VAL) ELSE (LEFT_VAL = RIGHT_VAL) END AS VAL FROM TEMP_TABLE) AS D;

/*
Prediction Result:
('v_null_1', '=', 'v_null_2', 'true')
('v_null_1', '<', 'v_num', 'true')
('v_null_1', '>', 'v_num', 'true')
('v_num', '=', 'v_null_1', 'true')
('v_null_1', '=', 'v_null_1', 'true')
*/