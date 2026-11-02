-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_54583f', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_4a054e', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_f72cc3', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('C', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('D', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_54583f', 'a_s_1463c4', 'a_s_4a054e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_54583f', '<', 'a_s_4a054e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_1463c4', 'a_s_4a054e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_54583f', 'a_s_1463c4', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_54583f', 'a_s_6056f6', 'a_s_4a054e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_54583f', 'A', 'a_s_4a054e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_54583f', 'exp_fcc4f6', 'a_s_4a054e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_54583f', 'a_s_1463c4', 'a_s_4a054e', 'false')
('a_s_54583f', '<', 'a_s_4a054e', 'false')
('A', 'a_s_1463c4', 'a_s_4a054e', 'false')
('a_s_54583f', 'a_s_1463c4', 'G', 'false')
('a_s_54583f', 'a_s_6056f6', 'a_s_4a054e', 'false')
('a_s_54583f', 'A', 'a_s_4a054e', 'false')
('a_s_54583f', 'exp_fcc4f6', 'a_s_4a054e', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('D', 'exp_fcc4f6', 'C', 'false')
*/

-- Prediction Query
SELECT A.LEFT_OPERAND, A.OPERATOR, A.RIGHT_OPERAND, CASE WHEN (CASE WHEN A.OPERATOR = '>' THEN A.VALUE > B.VALUE WHEN A.OPERATOR = '=' THEN A.VALUE = B.VALUE ELSE A.VALUE < B.VALUE END) = 1 THEN 'true' ELSE 'false' END AS VALUE FROM (SELECT * FROM EXPRESSIONS AS E JOIN VARIABLES AS O ON E.LEFT_OPERAND = O.NAME) AS A JOIN (SELECT * FROM EXPRESSIONS AS E JOIN VARIABLES AS O ON E.RIGHT_OPERAND = O.NAME) AS B ON A.LEFT_OPERAND = B.LEFT_OPERAND AND A.OPERATOR = B.OPERATOR AND A.RIGHT_OPERAND = B.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_54583f', 'a_s_1463c4', 'a_s_4a054e', 'false')
('a_s_54583f', '<', 'a_s_4a054e', 'false')
('A', 'a_s_1463c4', 'a_s_4a054e', 'true')
('a_s_54583f', 'a_s_1463c4', 'G', 'false')
('a_s_54583f', 'a_s_6056f6', 'a_s_4a054e', 'false')
('a_s_54583f', 'A', 'a_s_4a054e', 'false')
('a_s_54583f', 'exp_fcc4f6', 'a_s_4a054e', 'false')
('B', 'exp_fcc4f6', '@', 'true')
('D', 'exp_fcc4f6', 'C', 'false')
*/