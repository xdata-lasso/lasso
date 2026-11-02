-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_3f8270', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_a51ebd', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('I', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_f1abe6', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('D', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('T', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_3f8270', 'a_s_4b9788', 'a_s_a51ebd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_3f8270', '<', 'a_s_a51ebd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_4b9788', 'a_s_a51ebd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_3f8270', 'a_s_4b9788', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_3f8270', 'a_s_4b9788', 'I');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_3f8270', 'a_s_ef6c2a', 'a_s_a51ebd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_3f8270', 'A', 'a_s_a51ebd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_3f8270', 'exp_fcc4f6', 'a_s_a51ebd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('T', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_3f8270', 'a_s_4b9788', 'a_s_a51ebd', 'false')
('a_s_3f8270', '<', 'a_s_a51ebd', 'false')
('A', 'a_s_4b9788', 'a_s_a51ebd', 'false')
('a_s_3f8270', 'a_s_4b9788', 'G', 'false')
('a_s_3f8270', 'a_s_4b9788', 'I', 'false')
('a_s_3f8270', 'a_s_ef6c2a', 'a_s_a51ebd', 'false')
('a_s_3f8270', 'A', 'a_s_a51ebd', 'false')
('a_s_3f8270', 'exp_fcc4f6', 'a_s_a51ebd', 'false')
('D', 'exp_fcc4f6', '@', 'false')
('T', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '=' THEN IIF(RIGHT_VALUE = LEFT_VALUE, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(RIGHT_VALUE > LEFT_VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(RIGHT_VALUE < LEFT_VALUE, 'true', 'false') END AS VALUE FROM (SELECT LEFT_OPERAND, LEFT_VALUE, OPERATOR, RIGHT_OPERAND, VALUE AS RIGHT_VALUE FROM (SELECT T1.LEFT_OPERAND, VALUE AS LEFT_VALUE, OPERATOR, RIGHT_OPERAND FROM (SELECT * FROM EXPRESSIONS) AS T1 LEFT JOIN (SELECT * FROM VARIABLES) AS T2 ON T1.LEFT_OPERAND = T2.NAME) AS TT1 LEFT JOIN (SELECT * FROM VARIABLES) AS TT2 ON TT1.RIGHT_OPERAND = TT2.NAME) AS T;

/*
Prediction Result:
('a_s_3f8270', 'a_s_4b9788', 'a_s_a51ebd', None)
('a_s_3f8270', '<', 'a_s_a51ebd', 'false')
('A', 'a_s_4b9788', 'a_s_a51ebd', None)
('a_s_3f8270', 'a_s_4b9788', 'G', None)
('a_s_3f8270', 'a_s_4b9788', 'I', None)
('a_s_3f8270', 'a_s_ef6c2a', 'a_s_a51ebd', None)
('a_s_3f8270', 'A', 'a_s_a51ebd', None)
('a_s_3f8270', 'exp_fcc4f6', 'a_s_a51ebd', None)
('D', 'exp_fcc4f6', '@', None)
('T', 'exp_fcc4f6', '`', None)
*/