-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_604c39', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_ac4436', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('I', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_e248a8', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('?', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('@', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1980249628);

INSERT INTO "variables" ("name", "value") VALUES ('B', -734455130);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_604c39', 'a_s_a3c9e7', 'a_s_ac4436');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_a3c9e7', 'a_s_ac4436');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_604c39', 'a_s_a3c9e7', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_604c39', 'a_s_a3c9e7', 'I');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_604c39', 'a_s_17339a', 'a_s_ac4436');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_604c39', 'A', 'a_s_ac4436');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_604c39', 'exp_fcc4f6', 'a_s_ac4436');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', '?');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_604c39', 'a_s_a3c9e7', 'a_s_ac4436', 'false')
('A', 'a_s_a3c9e7', 'a_s_ac4436', 'false')
('a_s_604c39', 'a_s_a3c9e7', 'O', 'false')
('a_s_604c39', 'a_s_a3c9e7', 'I', 'false')
('a_s_604c39', 'a_s_17339a', 'a_s_ac4436', 'false')
('a_s_604c39', 'A', 'a_s_ac4436', 'false')
('a_s_604c39', 'exp_fcc4f6', 'a_s_ac4436', 'false')
('@', 'exp_fcc4f6', '?', 'false')
('B', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF((V1.VALUE - V2.VALUE) > 0, 'true', 'false') WHEN OPERATOR = '<' THEN IIF((V1.VALUE - V2.VALUE) < 0, 'true', 'false') WHEN OPERATOR = '=' THEN IIF((V1.VALUE - V2.VALUE) = 0, 'true', 'false') END AS VALUE FROM EXPRESSIONS LEFT JOIN VARIABLES AS V1 ON EXPRESSIONS.LEFT_OPERAND = V1.NAME LEFT JOIN VARIABLES AS V2 ON EXPRESSIONS.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_604c39', 'a_s_a3c9e7', 'a_s_ac4436', None)
('A', 'a_s_a3c9e7', 'a_s_ac4436', None)
('a_s_604c39', 'a_s_a3c9e7', 'O', None)
('a_s_604c39', 'a_s_a3c9e7', 'I', None)
('a_s_604c39', 'a_s_17339a', 'a_s_ac4436', None)
('a_s_604c39', 'A', 'a_s_ac4436', None)
('a_s_604c39', 'exp_fcc4f6', 'a_s_ac4436', None)
('@', 'exp_fcc4f6', '?', None)
('B', 'exp_fcc4f6', '`', None)
*/