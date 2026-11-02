-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_b67935', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_7c655c', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_f0fc29', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('P', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b67935', 'a_s_9b0717', 'a_s_7c655c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b67935', '<', 'a_s_7c655c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_9b0717', 'a_s_7c655c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b67935', 'a_s_9b0717', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b67935', 'a_s_a3e0aa', 'a_s_7c655c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b67935', 'A', 'a_s_7c655c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b67935', 'exp_fcc4f6', 'a_s_7c655c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'P');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_b67935', 'a_s_9b0717', 'a_s_7c655c', 'false')
('a_s_b67935', '<', 'a_s_7c655c', 'false')
('G', 'a_s_9b0717', 'a_s_7c655c', 'false')
('a_s_b67935', 'a_s_9b0717', 'G', 'false')
('a_s_b67935', 'a_s_a3e0aa', 'a_s_7c655c', 'false')
('a_s_b67935', 'A', 'a_s_7c655c', 'false')
('a_s_b67935', 'exp_fcc4f6', 'a_s_7c655c', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('`', 'exp_fcc4f6', 'P', 'false')
*/

-- Prediction Query
WITH CTE AS (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, T1.VALUE AS LEFT_VAL, T2.VALUE AS RIGHT_VAL FROM EXPRESSIONS LEFT JOIN VARIABLES AS T1 ON LEFT_OPERAND = T1.NAME LEFT JOIN VARIABLES AS T2 ON RIGHT_OPERAND = T2.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '=' THEN CASE WHEN LEFT_VAL = RIGHT_VAL THEN 'true' ELSE 'false' END WHEN OPERATOR = '>' THEN CASE WHEN LEFT_VAL > RIGHT_VAL THEN 'true' ELSE 'false' END WHEN OPERATOR = '<' THEN CASE WHEN LEFT_VAL < RIGHT_VAL THEN 'true' ELSE 'false' END END AS VALUE FROM CTE;

/*
Prediction Result:
('a_s_b67935', 'a_s_9b0717', 'a_s_7c655c', None)
('a_s_b67935', '<', 'a_s_7c655c', 'false')
('G', 'a_s_9b0717', 'a_s_7c655c', None)
('a_s_b67935', 'a_s_9b0717', 'G', None)
('a_s_b67935', 'a_s_a3e0aa', 'a_s_7c655c', None)
('a_s_b67935', 'A', 'a_s_7c655c', None)
('a_s_b67935', 'exp_fcc4f6', 'a_s_7c655c', None)
('B', 'exp_fcc4f6', '@', None)
('`', 'exp_fcc4f6', 'P', None)
*/