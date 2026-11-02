-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO Variables (name, value) VALUES ('p', 42);
INSERT INTO Variables (name, value) VALUES ('q', 42);
INSERT INTO Variables (name, value) VALUES ('unused', 99);
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('p', '!=', 'q');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('p', '<=', 'q');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('p', '>=', 'q');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('p', '=', 'q');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('p', '!=', 'q', 'false')
('p', '<=', 'q', 'false')
('p', '>=', 'q', 'false')
('p', '=', 'q', 'true')
*/

-- Prediction Query
SELECT E.*, (CASE WHEN E.OPERATOR = '<' THEN IIF(VX.VALUE < VY.VALUE, 'true', 'false') WHEN E.OPERATOR = '=' THEN IIF(VX.VALUE = VY.VALUE, 'true', 'false') WHEN E.OPERATOR = '>' THEN IIF(VX.VALUE > VY.VALUE, 'true', 'false') END) AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS VX ON E.LEFT_OPERAND = VX.NAME JOIN VARIABLES AS VY ON E.RIGHT_OPERAND = VY.NAME;

/*
Prediction Result:
('p', '!=', 'q', None)
('p', '<=', 'q', None)
('p', '>=', 'q', None)
('p', '=', 'q', 'true')
*/