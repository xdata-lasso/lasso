-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_563114', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_4b833b', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('I', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_1d7f1e', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('P', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_563114', 'a_s_1c5911', 'a_s_4b833b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_563114', '<', 'a_s_4b833b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_1c5911', 'a_s_4b833b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_563114', 'a_s_1c5911', 'I');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_563114', 'a_s_1c5911', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_563114', 'a_s_d0dc98', 'a_s_4b833b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_563114', 'A', 'a_s_4b833b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_563114', 'exp_fcc4f6', 'a_s_4b833b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('E', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('P', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_563114', 'a_s_1c5911', 'a_s_4b833b', 'false')
('a_s_563114', '<', 'a_s_4b833b', 'false')
('O', 'a_s_1c5911', 'a_s_4b833b', 'false')
('a_s_563114', 'a_s_1c5911', 'I', 'false')
('a_s_563114', 'a_s_1c5911', 'O', 'false')
('a_s_563114', 'a_s_d0dc98', 'a_s_4b833b', 'false')
('a_s_563114', 'A', 'a_s_4b833b', 'false')
('a_s_563114', 'exp_fcc4f6', 'a_s_4b833b', 'false')
('E', 'exp_fcc4f6', '@', 'false')
('P', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, (CASE WHEN OPERATOR = '=' THEN IIF(A.VALUE = B.VALUE, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(A.VALUE > B.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(A.VALUE < B.VALUE, 'true', 'false') END) AS VALUE FROM EXPRESSIONS AS X LEFT JOIN VARIABLES AS A ON X.LEFT_OPERAND = A.NAME LEFT JOIN VARIABLES AS B ON X.RIGHT_OPERAND = B.NAME;

/*
Prediction Result:
('a_s_563114', 'a_s_1c5911', 'a_s_4b833b', None)
('a_s_563114', '<', 'a_s_4b833b', 'false')
('O', 'a_s_1c5911', 'a_s_4b833b', None)
('a_s_563114', 'a_s_1c5911', 'I', None)
('a_s_563114', 'a_s_1c5911', 'O', None)
('a_s_563114', 'a_s_d0dc98', 'a_s_4b833b', None)
('a_s_563114', 'A', 'a_s_4b833b', None)
('a_s_563114', 'exp_fcc4f6', 'a_s_4b833b', None)
('E', 'exp_fcc4f6', '@', None)
('P', 'exp_fcc4f6', 'B', None)
*/