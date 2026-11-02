-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_d89023', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_3110a5', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('_', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('O', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_d6941c', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('@', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d89023', 'a_s_596940', 'a_s_3110a5');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d89023', '<', 'a_s_3110a5');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_596940', 'a_s_3110a5');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d89023', 'a_s_596940', '_');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_596940', 'a_s_3110a5');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d89023', 'a_s_596940', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d89023', 'a_s_64051b', 'a_s_3110a5');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d89023', 'A', 'a_s_3110a5');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d89023', 'exp_fcc4f6', 'a_s_3110a5');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('E', 'exp_fcc4f6', '@');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_d89023', 'a_s_596940', 'a_s_3110a5', 'false')
('a_s_d89023', '<', 'a_s_3110a5', 'false')
('G', 'a_s_596940', 'a_s_3110a5', 'false')
('a_s_d89023', 'a_s_596940', '_', 'false')
('O', 'a_s_596940', 'a_s_3110a5', 'false')
('a_s_d89023', 'a_s_596940', 'G', 'false')
('a_s_d89023', 'a_s_64051b', 'a_s_3110a5', 'false')
('a_s_d89023', 'A', 'a_s_3110a5', 'false')
('a_s_d89023', 'exp_fcc4f6', 'a_s_3110a5', 'false')
('E', 'exp_fcc4f6', '@', 'false')
*/

-- Prediction Query
WITH TEMP AS (SELECT LEFT_OPERAND, COALESCE(L.VALUE, 0) AS LEFT_VAL, OPERATOR, RIGHT_OPERAND, COALESCE(R.VALUE, 0) AS RIGHT_VAL FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS L ON E.LEFT_OPERAND = L.NAME LEFT JOIN VARIABLES AS R ON E.RIGHT_OPERAND = R.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN (CASE WHEN LEFT_VAL > RIGHT_VAL THEN 'true' ELSE 'false' END) WHEN OPERATOR = '<' THEN (CASE WHEN LEFT_VAL < RIGHT_VAL THEN 'true' ELSE 'false' END) WHEN OPERATOR = '=' THEN (CASE WHEN LEFT_VAL = RIGHT_VAL THEN 'true' ELSE 'false' END) END AS VALUE FROM TEMP;

/*
Prediction Result:
('a_s_d89023', 'a_s_596940', 'a_s_3110a5', None)
('a_s_d89023', '<', 'a_s_3110a5', 'false')
('G', 'a_s_596940', 'a_s_3110a5', None)
('a_s_d89023', 'a_s_596940', '_', None)
('O', 'a_s_596940', 'a_s_3110a5', None)
('a_s_d89023', 'a_s_596940', 'G', None)
('a_s_d89023', 'a_s_64051b', 'a_s_3110a5', None)
('a_s_d89023', 'A', 'a_s_3110a5', None)
('a_s_d89023', 'exp_fcc4f6', 'a_s_3110a5', None)
('E', 'exp_fcc4f6', '@', None)
*/