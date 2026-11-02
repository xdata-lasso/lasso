-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_c39453', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_0941f1', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_a4f1b1', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('C', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c39453', 'a_s_a275be', 'a_s_0941f1');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c39453', '<', 'a_s_0941f1');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_a275be', 'a_s_0941f1');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c39453', 'a_s_a275be', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_a275be', 'a_s_0941f1');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c39453', 'a_s_0aa9ea', 'a_s_0941f1');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c39453', 'A', 'a_s_0941f1');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c39453', 'exp_fcc4f6', 'a_s_0941f1');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'E');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_c39453', 'a_s_a275be', 'a_s_0941f1', 'false')
('a_s_c39453', '<', 'a_s_0941f1', 'false')
('O', 'a_s_a275be', 'a_s_0941f1', 'false')
('a_s_c39453', 'a_s_a275be', 'A', 'false')
('G', 'a_s_a275be', 'a_s_0941f1', 'false')
('a_s_c39453', 'a_s_0aa9ea', 'a_s_0941f1', 'false')
('a_s_c39453', 'A', 'a_s_0941f1', 'false')
('a_s_c39453', 'exp_fcc4f6', 'a_s_0941f1', 'false')
('@', 'exp_fcc4f6', 'E', 'false')
('`', 'exp_fcc4f6', 'C', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(A.VALUE > B.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(A.VALUE < B.VALUE, 'true', 'false') ELSE IIF(A.VALUE = B.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS A ON A.NAME = LEFT_OPERAND JOIN VARIABLES AS B ON B.NAME = RIGHT_OPERAND;

/*
Prediction Result:
('a_s_c39453', 'a_s_a275be', 'a_s_0941f1', 'true')
('a_s_c39453', '<', 'a_s_0941f1', 'false')
('O', 'a_s_a275be', 'a_s_0941f1', 'false')
('a_s_c39453', 'a_s_a275be', 'A', 'true')
('G', 'a_s_a275be', 'a_s_0941f1', 'false')
('a_s_c39453', 'a_s_0aa9ea', 'a_s_0941f1', 'true')
('a_s_c39453', 'A', 'a_s_0941f1', 'true')
('a_s_c39453', 'exp_fcc4f6', 'a_s_0941f1', 'true')
('@', 'exp_fcc4f6', 'E', 'false')
('`', 'exp_fcc4f6', 'C', 'false')
*/