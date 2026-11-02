-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_e968bc', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_782fd2', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_e9842b', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('!', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('D', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e968bc', 'a_s_8072b6', 'a_s_782fd2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e968bc', '<', 'a_s_782fd2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_8072b6', 'a_s_782fd2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e968bc', 'a_s_8072b6', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_8072b6', 'a_s_782fd2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e968bc', 'a_s_8072b6', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e968bc', 'a_s_3b10bd', 'a_s_782fd2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e968bc', 'A', 'a_s_782fd2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e968bc', 'exp_fcc4f6', 'a_s_782fd2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('!', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_e968bc', 'a_s_8072b6', 'a_s_782fd2', 'false')
('a_s_e968bc', '<', 'a_s_782fd2', 'false')
('G', 'a_s_8072b6', 'a_s_782fd2', 'false')
('a_s_e968bc', 'a_s_8072b6', 'O', 'false')
('O', 'a_s_8072b6', 'a_s_782fd2', 'false')
('a_s_e968bc', 'a_s_8072b6', 'G', 'false')
('a_s_e968bc', 'a_s_3b10bd', 'a_s_782fd2', 'false')
('a_s_e968bc', 'A', 'a_s_782fd2', 'false')
('a_s_e968bc', 'exp_fcc4f6', 'a_s_782fd2', 'false')
('!', 'exp_fcc4f6', '@', 'false')
('D', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT B.*, CASE WHEN B.OPERATOR = '>' THEN CASE WHEN A.VALUE > C.VALUE THEN 'true' ELSE 'false' END WHEN B.OPERATOR = '<' THEN CASE WHEN A.VALUE < C.VALUE THEN 'true' ELSE 'false' END WHEN B.OPERATOR = '=' THEN CASE WHEN A.VALUE = C.VALUE THEN 'true' ELSE 'false' END END AS VALUE FROM VARIABLES AS A INNER JOIN EXPRESSIONS AS B ON A.NAME = B.LEFT_OPERAND INNER JOIN VARIABLES AS C ON C.NAME = B.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_e968bc', 'a_s_8072b6', 'a_s_782fd2', None)
('a_s_e968bc', '<', 'a_s_782fd2', 'false')
('G', 'a_s_8072b6', 'a_s_782fd2', None)
('a_s_e968bc', 'a_s_8072b6', 'O', None)
('O', 'a_s_8072b6', 'a_s_782fd2', None)
('a_s_e968bc', 'a_s_8072b6', 'G', None)
('a_s_e968bc', 'a_s_3b10bd', 'a_s_782fd2', None)
('a_s_e968bc', 'A', 'a_s_782fd2', None)
('a_s_e968bc', 'exp_fcc4f6', 'a_s_782fd2', None)
('!', 'exp_fcc4f6', '@', None)
('D', 'exp_fcc4f6', 'B', None)
*/