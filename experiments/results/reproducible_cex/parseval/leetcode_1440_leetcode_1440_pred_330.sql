-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_447891', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_03cd6b', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('_', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_86bbeb', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('B', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('C', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('F', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_447891', 'a_s_e0ebc8', 'a_s_03cd6b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_447891', '<', 'a_s_03cd6b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_e0ebc8', 'a_s_03cd6b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_447891', 'a_s_e0ebc8', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_447891', 'a_s_a65aa0', 'a_s_03cd6b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_447891', 'A', 'a_s_03cd6b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_447891', 'exp_fcc4f6', 'a_s_03cd6b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'exp_fcc4f6', 'F');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_447891', 'a_s_e0ebc8', 'a_s_03cd6b', 'false')
('a_s_447891', '<', 'a_s_03cd6b', 'false')
('A', 'a_s_e0ebc8', 'a_s_03cd6b', 'false')
('a_s_447891', 'a_s_e0ebc8', 'A', 'false')
('a_s_447891', 'a_s_a65aa0', 'a_s_03cd6b', 'false')
('a_s_447891', 'A', 'a_s_03cd6b', 'false')
('a_s_447891', 'exp_fcc4f6', 'a_s_03cd6b', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('C', 'exp_fcc4f6', 'F', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(L.VALUE > R.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(L.VALUE < R.VALUE, 'true', 'false') ELSE IIF(L.VALUE = R.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS INNER JOIN VARIABLES AS L ON LEFT_OPERAND = L.NAME INNER JOIN VARIABLES AS R ON RIGHT_OPERAND = R.NAME;

/*
Prediction Result:
('a_s_447891', 'a_s_e0ebc8', 'a_s_03cd6b', 'true')
('a_s_447891', '<', 'a_s_03cd6b', 'false')
('A', 'a_s_e0ebc8', 'a_s_03cd6b', 'false')
('a_s_447891', 'a_s_e0ebc8', 'A', 'false')
('a_s_447891', 'a_s_a65aa0', 'a_s_03cd6b', 'true')
('a_s_447891', 'A', 'a_s_03cd6b', 'true')
('a_s_447891', 'exp_fcc4f6', 'a_s_03cd6b', 'true')
('B', 'exp_fcc4f6', '@', 'false')
('C', 'exp_fcc4f6', 'F', 'false')
*/