-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_7e99b9', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_cebb04', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('I', 1);

INSERT INTO "variables" ("name", "value") VALUES ('_', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_2c96aa', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('C', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('!', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('B', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_7e99b9', 'a_s_b07eb3', 'a_s_cebb04');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_7e99b9', '<', 'a_s_cebb04');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_b07eb3', 'a_s_cebb04');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_7e99b9', 'a_s_b07eb3', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_7e99b9', 'a_s_794674', 'a_s_cebb04');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_7e99b9', 'A', 'a_s_cebb04');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_7e99b9', 'exp_fcc4f6', 'a_s_cebb04');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('!', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_7e99b9', 'a_s_b07eb3', 'a_s_cebb04', 'false')
('a_s_7e99b9', '<', 'a_s_cebb04', 'false')
('A', 'a_s_b07eb3', 'a_s_cebb04', 'false')
('a_s_7e99b9', 'a_s_b07eb3', 'A', 'false')
('a_s_7e99b9', 'a_s_794674', 'a_s_cebb04', 'false')
('a_s_7e99b9', 'A', 'a_s_cebb04', 'false')
('a_s_7e99b9', 'exp_fcc4f6', 'a_s_cebb04', 'false')
('C', 'exp_fcc4f6', '@', 'false')
('!', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT A.LEFT_OPERAND, A.OPERATOR, A.RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(B.VALUE > C.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(B.VALUE < C.VALUE, 'true', 'false') ELSE IIF(B.VALUE = C.VALUE, 'true', 'false') END AS VALUE FROM (EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME) JOIN VARIABLES AS C ON C.NAME = A.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_7e99b9', 'a_s_b07eb3', 'a_s_cebb04', 'true')
('a_s_7e99b9', '<', 'a_s_cebb04', 'false')
('A', 'a_s_b07eb3', 'a_s_cebb04', 'false')
('a_s_7e99b9', 'a_s_b07eb3', 'A', 'false')
('a_s_7e99b9', 'a_s_794674', 'a_s_cebb04', 'true')
('a_s_7e99b9', 'A', 'a_s_cebb04', 'true')
('a_s_7e99b9', 'exp_fcc4f6', 'a_s_cebb04', 'true')
('C', 'exp_fcc4f6', '@', 'false')
('!', 'exp_fcc4f6', 'B', 'false')
*/