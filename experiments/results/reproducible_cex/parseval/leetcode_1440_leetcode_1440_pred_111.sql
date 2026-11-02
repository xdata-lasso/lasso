-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_c3292a', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_2ea7c8', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_e62dc1', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('B', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('D', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('I', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c3292a', 'a_s_0c1d7d', 'a_s_2ea7c8');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c3292a', '<', 'a_s_2ea7c8');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_0c1d7d', 'a_s_2ea7c8');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c3292a', 'a_s_0c1d7d', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c3292a', 'a_s_bd3780', 'a_s_2ea7c8');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c3292a', 'A', 'a_s_2ea7c8');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c3292a', 'exp_fcc4f6', 'a_s_2ea7c8');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', 'I');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_c3292a', 'a_s_0c1d7d', 'a_s_2ea7c8', 'false')
('a_s_c3292a', '<', 'a_s_2ea7c8', 'false')
('A', 'a_s_0c1d7d', 'a_s_2ea7c8', 'false')
('a_s_c3292a', 'a_s_0c1d7d', 'A', 'false')
('a_s_c3292a', 'a_s_bd3780', 'a_s_2ea7c8', 'false')
('a_s_c3292a', 'A', 'a_s_2ea7c8', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('a_s_c3292a', 'exp_fcc4f6', 'a_s_2ea7c8', 'false')
('D', 'exp_fcc4f6', 'I', 'false')
*/

-- Prediction Query
SELECT E.*, CASE WHEN OPERATOR = '>' THEN IIF(V.VALUE > V1.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(V.VALUE < V1.VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(V.VALUE = V1.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS V ON V.NAME = E.LEFT_OPERAND JOIN VARIABLES AS V1 ON V1.NAME = E.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_c3292a', 'a_s_0c1d7d', 'a_s_2ea7c8', None)
('a_s_c3292a', '<', 'a_s_2ea7c8', 'false')
('A', 'a_s_0c1d7d', 'a_s_2ea7c8', None)
('a_s_c3292a', 'a_s_0c1d7d', 'A', None)
('a_s_c3292a', 'a_s_bd3780', 'a_s_2ea7c8', None)
('a_s_c3292a', 'A', 'a_s_2ea7c8', None)
('B', 'exp_fcc4f6', '@', None)
('a_s_c3292a', 'exp_fcc4f6', 'a_s_2ea7c8', None)
('D', 'exp_fcc4f6', 'I', None)
*/