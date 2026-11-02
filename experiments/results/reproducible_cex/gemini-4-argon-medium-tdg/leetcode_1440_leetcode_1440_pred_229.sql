-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Variables (name, value) VALUES ('x', 10);
INSERT INTO Variables (name, value) VALUES ('y', 20);
INSERT INTO Variables (name, value) VALUES ('z', 10);
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('x', '<', 'y');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('x', '=', 'y');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('x', '>', 'y');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('y', '<', 'x');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('y', '=', 'x');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('y', '>', 'x');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('x', '<', 'z');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('x', '=', 'z');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('x', '>', 'z');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('x', '<', 'y', 'true')
('x', '=', 'y', 'false')
('x', '>', 'y', 'false')
('y', '<', 'x', 'false')
('y', '=', 'x', 'false')
('y', '>', 'x', 'true')
('x', '<', 'z', 'false')
('x', '=', 'z', 'true')
('x', '>', 'z', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '=' THEN IIF(RIGHT_VALUE = LEFT_VALUE, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(RIGHT_VALUE > LEFT_VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(RIGHT_VALUE < LEFT_VALUE, 'true', 'false') END AS VALUE FROM (SELECT LEFT_OPERAND, LEFT_VALUE, OPERATOR, RIGHT_OPERAND, VALUE AS RIGHT_VALUE FROM (SELECT T1.LEFT_OPERAND, VALUE AS LEFT_VALUE, OPERATOR, RIGHT_OPERAND FROM (SELECT * FROM EXPRESSIONS) AS T1 LEFT JOIN (SELECT * FROM VARIABLES) AS T2 ON T1.LEFT_OPERAND = T2.NAME) AS TT1 LEFT JOIN (SELECT * FROM VARIABLES) AS TT2 ON TT1.RIGHT_OPERAND = TT2.NAME) AS T;

/*
Prediction Result:
('x', '<', 'y', 'false')
('x', '=', 'y', 'false')
('x', '>', 'y', 'true')
('y', '<', 'x', 'true')
('y', '=', 'x', 'false')
('y', '>', 'x', 'false')
('x', '<', 'z', 'false')
('x', '=', 'z', 'true')
('x', '>', 'z', 'false')
*/