-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO "Variables" ("name", "value") VALUES ('a', 5);
INSERT INTO "Variables" ("name", "value") VALUES ('b', NULL);
INSERT INTO "Variables" ("name", "value") VALUES ('c', NULL);
INSERT INTO "Variables" ("name", "value") VALUES ('unused', 100);
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES ('a', '<', 'b');
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES ('a', '=', 'b');
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES ('a', '>', 'b');
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES ('b', '=', 'c');
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES ('b', '<', 'c');
INSERT INTO "Expressions" ("left_operand", "operator", "right_operand") VALUES ('b', '>', 'c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a', '<', 'b', 'false')
('a', '=', 'b', 'false')
('a', '>', 'b', 'false')
('b', '=', 'c', 'false')
('b', '<', 'c', 'false')
('b', '>', 'c', 'false')
*/

-- Prediction Query
SELECT E.*, CASE WHEN E.OPERATOR = '>' AND V.VALUE > V2.VALUE THEN 'true' WHEN E.OPERATOR = '>' AND V.VALUE <= V2.VALUE THEN 'false' WHEN E.OPERATOR = '<' AND V.VALUE < V2.VALUE THEN 'true' WHEN E.OPERATOR = '<' AND V.VALUE >= V2.VALUE THEN 'false' WHEN E.OPERATOR = '=' AND V.VALUE = V2.VALUE THEN 'true' WHEN E.OPERATOR = '=' AND V.VALUE <> V2.VALUE THEN 'false' ELSE '' END AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V ON E.LEFT_OPERAND = V.NAME LEFT JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a', '<', 'b', '')
('a', '=', 'b', '')
('a', '>', 'b', '')
('b', '=', 'c', '')
('b', '<', 'c', '')
('b', '>', 'c', '')
*/