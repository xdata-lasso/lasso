-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_c6ec51', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_c76290', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('C', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_de5d78', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('H', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('B', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c6ec51', 'a_s_667570', 'a_s_c76290');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c6ec51', '<', 'a_s_c76290');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_667570', 'a_s_c76290');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c6ec51', 'a_s_667570', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c6ec51', 'a_s_667570', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c6ec51', 'a_s_c367c6', 'a_s_c76290');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c6ec51', 'A', 'a_s_c76290');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('H', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c6ec51', 'exp_fcc4f6', 'a_s_c76290');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_c6ec51', 'a_s_667570', 'a_s_c76290', 'false')
('a_s_c6ec51', '<', 'a_s_c76290', 'false')
('A', 'a_s_667570', 'a_s_c76290', 'false')
('a_s_c6ec51', 'a_s_667570', 'O', 'false')
('a_s_c6ec51', 'a_s_667570', 'G', 'false')
('a_s_c6ec51', 'a_s_c367c6', 'a_s_c76290', 'false')
('a_s_c6ec51', 'A', 'a_s_c76290', 'false')
('H', 'exp_fcc4f6', '@', 'false')
('a_s_c6ec51', 'exp_fcc4f6', 'a_s_c76290', 'false')
('`', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN E.OPERATOR = '=' THEN IIF(L.VALUE = R.VALUE, 'true', 'false') WHEN E.OPERATOR = '<' THEN IIF(L.VALUE < R.VALUE, 'true', 'false') WHEN E.OPERATOR = '>' THEN IIF(L.VALUE > R.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E INNER JOIN VARIABLES AS L ON L.NAME = E.LEFT_OPERAND INNER JOIN VARIABLES AS R ON R.NAME = E.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_c6ec51', 'a_s_667570', 'a_s_c76290', None)
('a_s_c6ec51', '<', 'a_s_c76290', 'false')
('A', 'a_s_667570', 'a_s_c76290', None)
('a_s_c6ec51', 'a_s_667570', 'O', None)
('a_s_c6ec51', 'a_s_667570', 'G', None)
('a_s_c6ec51', 'a_s_c367c6', 'a_s_c76290', None)
('a_s_c6ec51', 'A', 'a_s_c76290', None)
('H', 'exp_fcc4f6', '@', None)
('a_s_c6ec51', 'exp_fcc4f6', 'a_s_c76290', None)
('`', 'exp_fcc4f6', 'B', None)
*/