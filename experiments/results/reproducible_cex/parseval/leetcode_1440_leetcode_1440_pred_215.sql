-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_d0122d', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_a4f907', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('I', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_7aacc4', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('B', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('R', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('P', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d0122d', 'a_s_7287cb', 'a_s_a4f907');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('I', 'a_s_7287cb', 'a_s_a4f907');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d0122d', 'a_s_7287cb', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_7287cb', 'a_s_a4f907');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d0122d', 'a_s_9aa476', 'a_s_a4f907');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d0122d', 'A', 'a_s_a4f907');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d0122d', 'exp_fcc4f6', 'a_s_a4f907');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'B');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('P', 'exp_fcc4f6', 'R');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_d0122d', 'a_s_7287cb', 'a_s_a4f907', 'false')
('I', 'a_s_7287cb', 'a_s_a4f907', 'false')
('a_s_d0122d', 'a_s_7287cb', 'A', 'false')
('G', 'a_s_7287cb', 'a_s_a4f907', 'false')
('a_s_d0122d', 'a_s_9aa476', 'a_s_a4f907', 'false')
('a_s_d0122d', 'A', 'a_s_a4f907', 'false')
('a_s_d0122d', 'exp_fcc4f6', 'a_s_a4f907', 'false')
('@', 'exp_fcc4f6', 'B', 'false')
('P', 'exp_fcc4f6', 'R', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN E.OPERATOR = '>' THEN IIF(A.VALUE > B.VALUE, 'true', 'false') WHEN E.OPERATOR = '<' THEN IIF(A.VALUE < B.VALUE, 'true', 'false') WHEN E.OPERATOR = '=' THEN IIF(A.VALUE = B.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS A ON A.NAME = E.LEFT_OPERAND LEFT JOIN VARIABLES AS B ON B.NAME = E.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_d0122d', 'a_s_7287cb', 'a_s_a4f907', None)
('I', 'a_s_7287cb', 'a_s_a4f907', None)
('a_s_d0122d', 'a_s_7287cb', 'A', None)
('G', 'a_s_7287cb', 'a_s_a4f907', None)
('a_s_d0122d', 'a_s_9aa476', 'a_s_a4f907', None)
('a_s_d0122d', 'A', 'a_s_a4f907', None)
('a_s_d0122d', 'exp_fcc4f6', 'a_s_a4f907', None)
('@', 'exp_fcc4f6', 'B', None)
('P', 'exp_fcc4f6', 'R', None)
*/