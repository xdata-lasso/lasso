-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_6275f5', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_14471c', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('I', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_d39a2a', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('C', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('F', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6275f5', 'a_s_1618bb', 'a_s_14471c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_1618bb', 'a_s_14471c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6275f5', 'a_s_1618bb', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6275f5', 'a_s_1618bb', 'I');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6275f5', 'a_s_c0c903', 'a_s_14471c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6275f5', 'A', 'a_s_14471c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6275f5', 'exp_fcc4f6', 'a_s_14471c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'exp_fcc4f6', 'F');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_6275f5', 'a_s_1618bb', 'a_s_14471c', 'false')
('G', 'a_s_1618bb', 'a_s_14471c', 'false')
('a_s_6275f5', 'a_s_1618bb', 'G', 'false')
('a_s_6275f5', 'a_s_1618bb', 'I', 'false')
('a_s_6275f5', 'a_s_c0c903', 'a_s_14471c', 'false')
('a_s_6275f5', 'A', 'a_s_14471c', 'false')
('a_s_6275f5', 'exp_fcc4f6', 'a_s_14471c', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('C', 'exp_fcc4f6', 'F', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, (CASE WHEN OPERATOR = '>' AND LEFT_VAL > RIGHT_VAL THEN 'true' WHEN OPERATOR = '>' AND LEFT_VAL <= RIGHT_VAL THEN 'false' WHEN OPERATOR = '<' AND LEFT_VAL < RIGHT_VAL THEN 'true' WHEN OPERATOR = '<' AND LEFT_VAL >= RIGHT_VAL THEN 'false' WHEN OPERATOR = '=' AND LEFT_VAL = RIGHT_VAL THEN 'true' WHEN OPERATOR = '=' AND LEFT_VAL <> RIGHT_VAL THEN 'false' END) AS VALUE FROM (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, (SELECT VALUE FROM VARIABLES WHERE NAME = E.LEFT_OPERAND) AS LEFT_VAL, (SELECT VALUE FROM VARIABLES WHERE NAME = E.RIGHT_OPERAND) AS RIGHT_VAL FROM EXPRESSIONS AS E) AS T;

/*
Prediction Result:
('a_s_6275f5', 'a_s_1618bb', 'a_s_14471c', None)
('G', 'a_s_1618bb', 'a_s_14471c', None)
('a_s_6275f5', 'a_s_1618bb', 'G', None)
('a_s_6275f5', 'a_s_1618bb', 'I', None)
('a_s_6275f5', 'a_s_c0c903', 'a_s_14471c', None)
('a_s_6275f5', 'A', 'a_s_14471c', None)
('a_s_6275f5', 'exp_fcc4f6', 'a_s_14471c', None)
('B', 'exp_fcc4f6', '@', None)
('C', 'exp_fcc4f6', 'F', None)
*/