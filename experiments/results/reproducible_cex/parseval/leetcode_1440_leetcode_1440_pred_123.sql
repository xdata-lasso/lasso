-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_ff27e6', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_d80b78', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('I', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('O', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_0cab06', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('D', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1980249628);

INSERT INTO "variables" ("name", "value") VALUES ('`', -734455130);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ff27e6', 'a_s_b741ca', 'a_s_d80b78');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ff27e6', '<', 'a_s_d80b78');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_b741ca', 'a_s_d80b78');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ff27e6', 'a_s_b741ca', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ff27e6', 'a_s_b741ca', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ff27e6', 'a_s_232904', 'a_s_d80b78');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ff27e6', 'A', 'a_s_d80b78');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ff27e6', 'exp_fcc4f6', 'a_s_d80b78');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'E');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_ff27e6', 'a_s_b741ca', 'a_s_d80b78', 'false')
('a_s_ff27e6', '<', 'a_s_d80b78', 'false')
('A', 'a_s_b741ca', 'a_s_d80b78', 'false')
('a_s_ff27e6', 'a_s_b741ca', 'G', 'false')
('a_s_ff27e6', 'a_s_b741ca', 'O', 'false')
('a_s_ff27e6', 'a_s_232904', 'a_s_d80b78', 'false')
('a_s_ff27e6', 'A', 'a_s_d80b78', 'false')
('a_s_ff27e6', 'exp_fcc4f6', 'a_s_d80b78', 'false')
('D', 'exp_fcc4f6', '@', 'false')
('`', 'exp_fcc4f6', 'E', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN E.OPERATOR = '>' THEN IIF(LEFT_VAL.VALUE > RIGHT_VAL.VALUE, 'true', 'false') WHEN E.OPERATOR = '<' THEN IIF(LEFT_VAL.VALUE < RIGHT_VAL.VALUE, 'true', 'false') WHEN E.OPERATOR = '=' THEN IIF(LEFT_VAL.VALUE = RIGHT_VAL.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS LEFT_VAL ON E.LEFT_OPERAND = LEFT_VAL.NAME JOIN VARIABLES AS RIGHT_VAL ON E.RIGHT_OPERAND = RIGHT_VAL.NAME;

/*
Prediction Result:
('a_s_ff27e6', 'a_s_b741ca', 'a_s_d80b78', None)
('a_s_ff27e6', '<', 'a_s_d80b78', 'false')
('A', 'a_s_b741ca', 'a_s_d80b78', None)
('a_s_ff27e6', 'a_s_b741ca', 'G', None)
('a_s_ff27e6', 'a_s_b741ca', 'O', None)
('a_s_ff27e6', 'a_s_232904', 'a_s_d80b78', None)
('a_s_ff27e6', 'A', 'a_s_d80b78', None)
('a_s_ff27e6', 'exp_fcc4f6', 'a_s_d80b78', None)
('D', 'exp_fcc4f6', '@', None)
('`', 'exp_fcc4f6', 'E', None)
*/