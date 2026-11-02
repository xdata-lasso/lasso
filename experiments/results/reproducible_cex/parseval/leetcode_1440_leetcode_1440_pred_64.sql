-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_79c815', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_e42da9', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('C', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_4cbce2', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('b', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('D', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_79c815', 'a_s_8d0ea3', 'a_s_e42da9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_8d0ea3', 'a_s_e42da9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_79c815', 'a_s_8d0ea3', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_79c815', 'a_s_f018e1', 'a_s_e42da9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_79c815', 'A', 'a_s_e42da9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_79c815', 'exp_fcc4f6', 'a_s_e42da9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', 'b');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_79c815', 'a_s_8d0ea3', 'a_s_e42da9', 'false')
('A', 'a_s_8d0ea3', 'a_s_e42da9', 'false')
('a_s_79c815', 'a_s_8d0ea3', 'O', 'false')
('a_s_79c815', 'a_s_f018e1', 'a_s_e42da9', 'false')
('a_s_79c815', 'A', 'a_s_e42da9', 'false')
('a_s_79c815', 'exp_fcc4f6', 'a_s_e42da9', 'false')
('`', 'exp_fcc4f6', '@', 'false')
('D', 'exp_fcc4f6', 'b', 'false')
*/

-- Prediction Query
SELECT A.LEFT_OPERAND AS LEFT_OPERAND, A.OPERATOR AS OPERATOR, A.RIGHT_OPERAND AS RIGHT_OPERAND, (CASE WHEN A.OPERATOR = '>' THEN IIF(B.VALUE > C.VALUE, 'true', 'false') WHEN A.OPERATOR = '<' THEN IIF(B.VALUE < C.VALUE, 'true', 'false') ELSE IIF(B.VALUE = C.VALUE, 'true', 'false') END) AS VALUE FROM EXPRESSIONS AS A LEFT JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME LEFT JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Prediction Result:
('a_s_79c815', 'a_s_8d0ea3', 'a_s_e42da9', 'true')
('A', 'a_s_8d0ea3', 'a_s_e42da9', 'false')
('a_s_79c815', 'a_s_8d0ea3', 'O', 'false')
('a_s_79c815', 'a_s_f018e1', 'a_s_e42da9', 'true')
('a_s_79c815', 'A', 'a_s_e42da9', 'true')
('a_s_79c815', 'exp_fcc4f6', 'a_s_e42da9', 'true')
('`', 'exp_fcc4f6', '@', 'false')
('D', 'exp_fcc4f6', 'b', 'false')
*/