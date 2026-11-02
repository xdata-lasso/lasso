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
SELECT A.*, CASE WHEN A.OPERATOR = '>' THEN CASE WHEN L.VALUE > R.VALUE THEN 'true' ELSE 'false' END WHEN A.OPERATOR = '<' THEN CASE WHEN L.VALUE > R.VALUE THEN 'true' ELSE 'false' END WHEN A.OPERATOR = '=' THEN CASE WHEN L.VALUE = R.VALUE THEN 'true' ELSE 'false' END ELSE NULL END AS VALUE FROM EXPRESSIONS AS A INNER JOIN VARIABLES AS L ON A.LEFT_OPERAND = L.NAME INNER JOIN VARIABLES AS R ON A.RIGHT_OPERAND = R.NAME;

/*
Prediction Result:
('x', '<', 'y', 'false')
('x', '=', 'y', 'false')
('x', '>', 'y', 'false')
('y', '<', 'x', 'true')
('y', '=', 'x', 'false')
('y', '>', 'x', 'true')
('x', '<', 'z', 'false')
('x', '=', 'z', 'true')
('x', '>', 'z', 'false')
*/