-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_3dbdd5', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_2c6b2d', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('_', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_399e63', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('D', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('b', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_3dbdd5', 'a_s_4f9fff', 'a_s_2c6b2d');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_3dbdd5', '<', 'a_s_2c6b2d');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_4f9fff', 'a_s_2c6b2d');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_3dbdd5', 'a_s_4f9fff', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_3dbdd5', 'a_s_c19e78', 'a_s_2c6b2d');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_3dbdd5', 'A', 'a_s_2c6b2d');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_3dbdd5', 'exp_fcc4f6', 'a_s_2c6b2d');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'b');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_3dbdd5', 'a_s_4f9fff', 'a_s_2c6b2d', 'false')
('a_s_3dbdd5', '<', 'a_s_2c6b2d', 'false')
('A', 'a_s_4f9fff', 'a_s_2c6b2d', 'false')
('a_s_3dbdd5', 'a_s_4f9fff', 'G', 'false')
('a_s_3dbdd5', 'a_s_c19e78', 'a_s_2c6b2d', 'false')
('a_s_3dbdd5', 'A', 'a_s_2c6b2d', 'false')
('a_s_3dbdd5', 'exp_fcc4f6', 'a_s_2c6b2d', 'false')
('D', 'exp_fcc4f6', '@', 'false')
('`', 'exp_fcc4f6', 'b', 'false')
*/

-- Prediction Query
SELECT E.*, CASE E.OPERATOR WHEN '=' THEN IIF(V1.VALUE = V2.VALUE, 'true', 'false') WHEN '>' THEN IIF(V1.VALUE > V2.VALUE, 'true', 'false') WHEN '<' THEN IIF(V1.VALUE < V2.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E CROSS JOIN VARIABLES AS V1 CROSS JOIN VARIABLES AS V2 WHERE E.LEFT_OPERAND = V1.NAME AND E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_3dbdd5', 'a_s_4f9fff', 'a_s_2c6b2d', None)
('a_s_3dbdd5', '<', 'a_s_2c6b2d', 'false')
('A', 'a_s_4f9fff', 'a_s_2c6b2d', None)
('a_s_3dbdd5', 'a_s_4f9fff', 'G', None)
('a_s_3dbdd5', 'a_s_c19e78', 'a_s_2c6b2d', None)
('a_s_3dbdd5', 'A', 'a_s_2c6b2d', None)
('a_s_3dbdd5', 'exp_fcc4f6', 'a_s_2c6b2d', None)
('D', 'exp_fcc4f6', '@', None)
('`', 'exp_fcc4f6', 'b', None)
*/