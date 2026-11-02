-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO Variables (name, value) VALUES ('p', 7);
INSERT INTO Variables (name, value) VALUES ('q', 7);
INSERT INTO Variables (name, value) VALUES ('r', 8);
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('p', '!=', 'q');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('p', '<=', 'q');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('p', '>=', 'q');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('p', '!=', 'r');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('p', '<=', 'r');
INSERT INTO Expressions (left_operand, operator, right_operand) VALUES ('r', '>=', 'p');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('p', '!=', 'q', 'false')
('p', '<=', 'q', 'false')
('p', '>=', 'q', 'false')
('p', '!=', 'r', 'false')
('p', '<=', 'r', 'false')
('r', '>=', 'p', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '<' THEN IIF(VAR1.VALUE < VAR2.VALUE, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(VAR1.VALUE > VAR2.VALUE, 'true', 'false') ELSE IIF(VAR1.VALUE = VAR2.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS EXP JOIN VARIABLES AS VAR1 ON EXP.LEFT_OPERAND = VAR1.NAME JOIN VARIABLES AS VAR2 ON EXP.RIGHT_OPERAND = VAR2.NAME;

/*
Prediction Result:
('p', '!=', 'q', 'true')
('p', '<=', 'q', 'true')
('p', '>=', 'q', 'true')
('p', '!=', 'r', 'false')
('p', '<=', 'r', 'false')
('r', '>=', 'p', 'false')
*/