-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_a8724b', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_06ac1b', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_1c96f9', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('I', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('Q', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a8724b', 'a_s_f4bc0e', 'a_s_06ac1b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a8724b', '<', 'a_s_06ac1b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_f4bc0e', 'a_s_06ac1b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a8724b', 'a_s_f4bc0e', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a8724b', 'a_s_36fd7a', 'a_s_06ac1b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a8724b', 'A', 'a_s_06ac1b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'I');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a8724b', 'exp_fcc4f6', 'a_s_06ac1b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'Q');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_a8724b', 'a_s_f4bc0e', 'a_s_06ac1b', 'false')
('a_s_a8724b', '<', 'a_s_06ac1b', 'false')
('A', 'a_s_f4bc0e', 'a_s_06ac1b', 'false')
('a_s_a8724b', 'a_s_f4bc0e', 'A', 'false')
('a_s_a8724b', 'a_s_36fd7a', 'a_s_06ac1b', 'false')
('a_s_a8724b', 'A', 'a_s_06ac1b', 'false')
('@', 'exp_fcc4f6', 'I', 'false')
('a_s_a8724b', 'exp_fcc4f6', 'a_s_06ac1b', 'false')
('`', 'exp_fcc4f6', 'Q', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE VALUE WHEN 1 THEN 'true' WHEN 0 THEN 'false' END AS VALUE FROM (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, LEFT_VALUE, RIGHT_VALUE, CASE OPERATOR WHEN '>' THEN LEFT_VALUE > RIGHT_VALUE WHEN '=' THEN LEFT_VALUE = RIGHT_VALUE WHEN '<' THEN LEFT_VALUE < RIGHT_VALUE END AS VALUE FROM (SELECT *, (SELECT VALUE FROM VARIABLES WHERE NAME = LEFT_OPERAND) AS LEFT_VALUE, (SELECT VALUE FROM VARIABLES WHERE NAME = RIGHT_OPERAND) AS RIGHT_VALUE FROM EXPRESSIONS) AS SUB) AS SUB1;

/*
Prediction Result:
('a_s_a8724b', 'a_s_f4bc0e', 'a_s_06ac1b', None)
('a_s_a8724b', '<', 'a_s_06ac1b', 'false')
('A', 'a_s_f4bc0e', 'a_s_06ac1b', None)
('a_s_a8724b', 'a_s_f4bc0e', 'A', None)
('a_s_a8724b', 'a_s_36fd7a', 'a_s_06ac1b', None)
('a_s_a8724b', 'A', 'a_s_06ac1b', None)
('@', 'exp_fcc4f6', 'I', None)
('a_s_a8724b', 'exp_fcc4f6', 'a_s_06ac1b', None)
('`', 'exp_fcc4f6', 'Q', None)
*/