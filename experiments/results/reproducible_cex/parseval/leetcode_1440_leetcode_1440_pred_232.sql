-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_e33cb1', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_a2e5ed', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('C', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('_', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('Q', 1);

INSERT INTO "variables" ("name", "value") VALUES ('?', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_9a2fc5', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('I', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('@', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e33cb1', 'a_s_601e89', 'a_s_a2e5ed');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e33cb1', '<', 'a_s_a2e5ed');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_601e89', 'a_s_a2e5ed');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e33cb1', 'a_s_601e89', '_');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e33cb1', 'a_s_601e89', '?');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e33cb1', 'a_s_9a7457', 'a_s_a2e5ed');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e33cb1', 'A', 'a_s_a2e5ed');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'I');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e33cb1', 'exp_fcc4f6', 'a_s_a2e5ed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_e33cb1', 'a_s_601e89', 'a_s_a2e5ed', 'false')
('a_s_e33cb1', '<', 'a_s_a2e5ed', 'false')
('A', 'a_s_601e89', 'a_s_a2e5ed', 'false')
('a_s_e33cb1', 'a_s_601e89', '_', 'false')
('a_s_e33cb1', 'a_s_601e89', '?', 'false')
('a_s_e33cb1', 'a_s_9a7457', 'a_s_a2e5ed', 'false')
('a_s_e33cb1', 'A', 'a_s_a2e5ed', 'false')
('@', 'exp_fcc4f6', 'I', 'false')
('a_s_e33cb1', 'exp_fcc4f6', 'a_s_a2e5ed', 'false')
*/

-- Prediction Query
SELECT B.LEFT_OPERAND, B.OPERATOR, B.RIGHT_OPERAND, CASE WHEN B.OPERATOR = '>' THEN IIF(A.VALUE > C.VALUE, 'true', 'false') WHEN B.OPERATOR = '<' THEN IIF(A.VALUE < C.VALUE, 'true', 'false') WHEN B.OPERATOR = '=' THEN IIF(A.VALUE = C.VALUE, 'true', 'false') END AS VALUE FROM VARIABLES AS A JOIN EXPRESSIONS AS B ON A.NAME = B.LEFT_OPERAND JOIN VARIABLES AS C ON C.NAME = B.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_e33cb1', 'a_s_601e89', 'a_s_a2e5ed', None)
('a_s_e33cb1', '<', 'a_s_a2e5ed', 'false')
('A', 'a_s_601e89', 'a_s_a2e5ed', None)
('a_s_e33cb1', 'a_s_601e89', '_', None)
('a_s_e33cb1', 'a_s_601e89', '?', None)
('a_s_e33cb1', 'a_s_9a7457', 'a_s_a2e5ed', None)
('a_s_e33cb1', 'A', 'a_s_a2e5ed', None)
('@', 'exp_fcc4f6', 'I', None)
('a_s_e33cb1', 'exp_fcc4f6', 'a_s_a2e5ed', None)
*/