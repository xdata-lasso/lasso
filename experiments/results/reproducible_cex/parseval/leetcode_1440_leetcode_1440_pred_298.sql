-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_a1f66a', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_8ad362', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_912c53', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('B', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a1f66a', 'a_s_e71b82', 'a_s_8ad362');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a1f66a', '<', 'a_s_8ad362');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_e71b82', 'a_s_8ad362');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a1f66a', 'a_s_e71b82', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a1f66a', 'a_s_59e079', 'a_s_8ad362');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a1f66a', 'A', 'a_s_8ad362');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a1f66a', 'exp_fcc4f6', 'a_s_8ad362');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('E', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_a1f66a', 'a_s_e71b82', 'a_s_8ad362', 'false')
('a_s_a1f66a', '<', 'a_s_8ad362', 'false')
('O', 'a_s_e71b82', 'a_s_8ad362', 'false')
('a_s_a1f66a', 'a_s_e71b82', 'A', 'false')
('a_s_a1f66a', 'a_s_59e079', 'a_s_8ad362', 'false')
('a_s_a1f66a', 'A', 'a_s_8ad362', 'false')
('a_s_a1f66a', 'exp_fcc4f6', 'a_s_8ad362', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('E', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
SELECT EXPRESSIONS.*, CASE EXPRESSIONS.OPERATOR WHEN '>' THEN (IIF(LEFT_VARIABLES.VALUE > RIGHT_VARIABLES.VALUE, 'true', 'false')) WHEN '<' THEN (IIF(LEFT_VARIABLES.VALUE < RIGHT_VARIABLES.VALUE, 'true', 'false')) WHEN '=' THEN (IIF(LEFT_VARIABLES.VALUE = RIGHT_VARIABLES.VALUE, 'true', 'false')) END AS VALUE FROM EXPRESSIONS JOIN VARIABLES AS LEFT_VARIABLES ON LEFT_VARIABLES.NAME = EXPRESSIONS.LEFT_OPERAND JOIN VARIABLES AS RIGHT_VARIABLES ON RIGHT_VARIABLES.NAME = EXPRESSIONS.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_a1f66a', 'a_s_e71b82', 'a_s_8ad362', None)
('a_s_a1f66a', '<', 'a_s_8ad362', 'false')
('O', 'a_s_e71b82', 'a_s_8ad362', None)
('a_s_a1f66a', 'a_s_e71b82', 'A', None)
('a_s_a1f66a', 'a_s_59e079', 'a_s_8ad362', None)
('a_s_a1f66a', 'A', 'a_s_8ad362', None)
('a_s_a1f66a', 'exp_fcc4f6', 'a_s_8ad362', None)
('B', 'exp_fcc4f6', '@', None)
('E', 'exp_fcc4f6', '`', None)
*/