-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_ad05d7', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_ef907b', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_12e284', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('D', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('a', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('B', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ad05d7', 'a_s_b67c3f', 'a_s_ef907b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ad05d7', '<', 'a_s_ef907b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_b67c3f', 'a_s_ef907b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ad05d7', 'a_s_b67c3f', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ad05d7', 'a_s_1514e7', 'a_s_ef907b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ad05d7', 'A', 'a_s_ef907b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ad05d7', 'exp_fcc4f6', 'a_s_ef907b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'D');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_ad05d7', 'a_s_b67c3f', 'a_s_ef907b', 'false')
('a_s_ad05d7', '<', 'a_s_ef907b', 'false')
('A', 'a_s_b67c3f', 'a_s_ef907b', 'false')
('a_s_ad05d7', 'a_s_b67c3f', 'A', 'false')
('a_s_ad05d7', 'a_s_1514e7', 'a_s_ef907b', 'false')
('a_s_ad05d7', 'A', 'a_s_ef907b', 'false')
('a_s_ad05d7', 'exp_fcc4f6', 'a_s_ef907b', 'false')
('@', 'exp_fcc4f6', 'D', 'false')
('a', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '<' THEN IIF(VAR1.VALUE < VAR2.VALUE, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(VAR1.VALUE > VAR2.VALUE, 'true', 'false') ELSE IIF(VAR1.VALUE = VAR2.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS EXP JOIN VARIABLES AS VAR1 ON EXP.LEFT_OPERAND = VAR1.NAME JOIN VARIABLES AS VAR2 ON EXP.RIGHT_OPERAND = VAR2.NAME;

/*
Prediction Result:
('a_s_ad05d7', 'a_s_b67c3f', 'a_s_ef907b', 'true')
('a_s_ad05d7', '<', 'a_s_ef907b', 'false')
('A', 'a_s_b67c3f', 'a_s_ef907b', 'false')
('a_s_ad05d7', 'a_s_b67c3f', 'A', 'false')
('a_s_ad05d7', 'a_s_1514e7', 'a_s_ef907b', 'true')
('a_s_ad05d7', 'A', 'a_s_ef907b', 'true')
('a_s_ad05d7', 'exp_fcc4f6', 'a_s_ef907b', 'true')
('@', 'exp_fcc4f6', 'D', 'false')
('a', 'exp_fcc4f6', 'B', 'false')
*/