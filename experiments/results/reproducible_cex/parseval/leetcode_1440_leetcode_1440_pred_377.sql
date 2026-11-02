-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_fc6f9a', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_70d2c5', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('E', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_876889', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('D', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('C', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('I', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fc6f9a', 'a_s_545ffb', 'a_s_70d2c5');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fc6f9a', '<', 'a_s_70d2c5');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_545ffb', 'a_s_70d2c5');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fc6f9a', 'a_s_545ffb', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fc6f9a', 'a_s_c9e723', 'a_s_70d2c5');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fc6f9a', 'A', 'a_s_70d2c5');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fc6f9a', 'exp_fcc4f6', 'a_s_70d2c5');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'exp_fcc4f6', 'I');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_fc6f9a', 'a_s_545ffb', 'a_s_70d2c5', 'false')
('a_s_fc6f9a', '<', 'a_s_70d2c5', 'false')
('A', 'a_s_545ffb', 'a_s_70d2c5', 'false')
('a_s_fc6f9a', 'a_s_545ffb', 'A', 'false')
('a_s_fc6f9a', 'a_s_c9e723', 'a_s_70d2c5', 'false')
('a_s_fc6f9a', 'A', 'a_s_70d2c5', 'false')
('a_s_fc6f9a', 'exp_fcc4f6', 'a_s_70d2c5', 'false')
('D', 'exp_fcc4f6', '@', 'false')
('C', 'exp_fcc4f6', 'I', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, IIF(VAL = 0, 'false', 'true') AS VALUE FROM (WITH TEMP_TABLE AS (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, LEFT_VAL, VALUE AS RIGHT_VAL FROM VARIABLES AS V INNER JOIN (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, VALUE AS LEFT_VAL, NAME FROM EXPRESSIONS INNER JOIN VARIABLES ON NAME = LEFT_OPERAND) AS T ON V.NAME = T.RIGHT_OPERAND) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN (LEFT_VAL > RIGHT_VAL) WHEN OPERATOR = '<' THEN (LEFT_VAL < RIGHT_VAL) ELSE (LEFT_VAL = RIGHT_VAL) END AS VAL FROM TEMP_TABLE) AS D;

/*
Prediction Result:
('a_s_fc6f9a', 'a_s_545ffb', 'a_s_70d2c5', 'true')
('a_s_fc6f9a', '<', 'a_s_70d2c5', 'false')
('A', 'a_s_545ffb', 'a_s_70d2c5', 'false')
('a_s_fc6f9a', 'a_s_545ffb', 'A', 'false')
('a_s_fc6f9a', 'a_s_c9e723', 'a_s_70d2c5', 'true')
('a_s_fc6f9a', 'A', 'a_s_70d2c5', 'true')
('a_s_fc6f9a', 'exp_fcc4f6', 'a_s_70d2c5', 'true')
('D', 'exp_fcc4f6', '@', 'false')
('C', 'exp_fcc4f6', 'I', 'false')
*/