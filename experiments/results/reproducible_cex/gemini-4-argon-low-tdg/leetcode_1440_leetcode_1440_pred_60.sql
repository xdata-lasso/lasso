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
SELECT R.LEFT_OPERAND, R.OPERATOR, R.RIGHT_OPERAND, (CASE WHEN R.OPERATOR = '=' AND R.LEFT_OPERAND_VAL = R.RIGHT_OPERAND_VAL THEN 'true' WHEN R.OPERATOR = '=' AND R.LEFT_OPERAND_VAL <> R.RIGHT_OPERAND_VAL THEN 'false' WHEN R.OPERATOR = '<' AND R.LEFT_OPERAND_VAL < R.RIGHT_OPERAND_VAL THEN 'true' WHEN R.OPERATOR = '<' AND R.LEFT_OPERAND_VAL >= R.RIGHT_OPERAND_VAL THEN 'false' WHEN R.OPERATOR = '>' AND R.LEFT_OPERAND_VAL > R.RIGHT_OPERAND_VAL THEN 'true' WHEN R.OPERATOR = '>' AND R.LEFT_OPERAND_VAL <= R.RIGHT_OPERAND_VAL THEN 'false' END) AS VALUE FROM (SELECT L.LEFT_OPERAND_VAL, L.OPERATOR, V.VALUE AS RIGHT_OPERAND_VAL, L.LEFT_OPERAND, L.RIGHT_OPERAND FROM (SELECT V.VALUE AS LEFT_OPERAND_VAL, E.OPERATOR, E.RIGHT_OPERAND, E.LEFT_OPERAND FROM EXPRESSIONS AS E JOIN VARIABLES AS V ON E.LEFT_OPERAND = V.NAME) AS L JOIN VARIABLES AS V ON L.RIGHT_OPERAND = V.NAME) AS R;

/*
Prediction Result:
('a', '<', 'b', None)
('a', '=', 'b', None)
('a', '>', 'b', None)
('b', '=', 'c', None)
('b', '<', 'c', None)
('b', '>', 'c', None)
*/