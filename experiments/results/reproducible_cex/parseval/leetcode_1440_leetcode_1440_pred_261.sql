-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_46727d', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_17c427', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('_', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_054751', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('P', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('E', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_46727d', 'a_s_3b8be1', 'a_s_17c427');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_3b8be1', 'a_s_17c427');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_46727d', 'a_s_3b8be1', '_');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_46727d', 'a_s_3b8be1', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_46727d', 'a_s_818f7e', 'a_s_17c427');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_46727d', 'A', 'a_s_17c427');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_46727d', 'exp_fcc4f6', 'a_s_17c427');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'P');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('E', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_46727d', 'a_s_3b8be1', 'a_s_17c427', 'false')
('A', 'a_s_3b8be1', 'a_s_17c427', 'false')
('a_s_46727d', 'a_s_3b8be1', '_', 'false')
('a_s_46727d', 'a_s_3b8be1', 'O', 'false')
('a_s_46727d', 'a_s_818f7e', 'a_s_17c427', 'false')
('a_s_46727d', 'A', 'a_s_17c427', 'false')
('a_s_46727d', 'exp_fcc4f6', 'a_s_17c427', 'false')
('@', 'exp_fcc4f6', 'P', 'false')
('E', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(A.VALUE > B.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(A.VALUE < B.VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(A.VALUE = B.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E INNER JOIN VARIABLES AS A ON A.NAME = E.LEFT_OPERAND INNER JOIN VARIABLES AS B ON B.NAME = E.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_46727d', 'a_s_3b8be1', 'a_s_17c427', None)
('A', 'a_s_3b8be1', 'a_s_17c427', None)
('a_s_46727d', 'a_s_3b8be1', '_', None)
('a_s_46727d', 'a_s_3b8be1', 'O', None)
('a_s_46727d', 'a_s_818f7e', 'a_s_17c427', None)
('a_s_46727d', 'A', 'a_s_17c427', None)
('a_s_46727d', 'exp_fcc4f6', 'a_s_17c427', None)
('@', 'exp_fcc4f6', 'P', None)
('E', 'exp_fcc4f6', 'B', None)
*/