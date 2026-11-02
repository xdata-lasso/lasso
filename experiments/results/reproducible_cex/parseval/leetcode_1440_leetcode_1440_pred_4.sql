-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_742759', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_7b886e', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('I', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_b5e2b0', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('P', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('E', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_742759', 'a_s_a76e7e', 'a_s_7b886e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_742759', '<', 'a_s_7b886e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_a76e7e', 'a_s_7b886e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_742759', 'a_s_a76e7e', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_742759', 'a_s_2fed2f', 'a_s_7b886e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_742759', 'A', 'a_s_7b886e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_742759', 'exp_fcc4f6', 'a_s_7b886e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'P');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', 'E');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_742759', 'a_s_a76e7e', 'a_s_7b886e', 'false')
('a_s_742759', '<', 'a_s_7b886e', 'false')
('O', 'a_s_a76e7e', 'a_s_7b886e', 'false')
('a_s_742759', 'a_s_a76e7e', 'A', 'false')
('a_s_742759', 'a_s_2fed2f', 'a_s_7b886e', 'false')
('a_s_742759', 'A', 'a_s_7b886e', 'false')
('a_s_742759', 'exp_fcc4f6', 'a_s_7b886e', 'false')
('@', 'exp_fcc4f6', 'P', 'false')
('B', 'exp_fcc4f6', 'E', 'false')
*/

-- Prediction Query
SELECT DISTINCT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(V1.VALUE > V2.VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(V1.VALUE = V2.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(V1.VALUE < V2.VALUE, 'true', 'false') END AS VALUE FROM VARIABLES AS V1 INNER JOIN EXPRESSIONS AS E ON V1.NAME = E.LEFT_OPERAND INNER JOIN VARIABLES AS V2 ON V2.NAME = E.RIGHT_OPERAND;

/*
Prediction Result:
('@', 'exp_fcc4f6', 'P', None)
('B', 'exp_fcc4f6', 'E', None)
('O', 'a_s_a76e7e', 'a_s_7b886e', None)
('a_s_742759', '<', 'a_s_7b886e', 'false')
('a_s_742759', 'A', 'a_s_7b886e', None)
('a_s_742759', 'a_s_2fed2f', 'a_s_7b886e', None)
('a_s_742759', 'a_s_a76e7e', 'A', None)
('a_s_742759', 'a_s_a76e7e', 'a_s_7b886e', None)
('a_s_742759', 'exp_fcc4f6', 'a_s_7b886e', None)
*/