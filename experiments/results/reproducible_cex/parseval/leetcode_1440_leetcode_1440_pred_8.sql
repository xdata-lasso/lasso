-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_14e2a0', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_050e68', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('C', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('_', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('O', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_e815a7', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('I', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1980249628);

INSERT INTO "variables" ("name", "value") VALUES ('E', -734455130);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_14e2a0', 'a_s_16d2f3', 'a_s_050e68');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'a_s_16d2f3', 'a_s_050e68');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_14e2a0', 'a_s_16d2f3', '_');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_16d2f3', 'a_s_050e68');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_14e2a0', 'a_s_16d2f3', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_14e2a0', 'a_s_6b8e3d', 'a_s_050e68');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_14e2a0', 'A', 'a_s_050e68');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_14e2a0', 'exp_fcc4f6', 'a_s_050e68');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('I', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('E', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_14e2a0', 'a_s_16d2f3', 'a_s_050e68', 'false')
('C', 'a_s_16d2f3', 'a_s_050e68', 'false')
('a_s_14e2a0', 'a_s_16d2f3', '_', 'false')
('O', 'a_s_16d2f3', 'a_s_050e68', 'false')
('a_s_14e2a0', 'a_s_16d2f3', 'O', 'false')
('a_s_14e2a0', 'a_s_6b8e3d', 'a_s_050e68', 'false')
('a_s_14e2a0', 'A', 'a_s_050e68', 'false')
('a_s_14e2a0', 'exp_fcc4f6', 'a_s_050e68', 'false')
('I', 'exp_fcc4f6', '@', 'false')
('E', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN E.OPERATOR = '=' THEN IIF(L.VALUE = R.VALUE, 'true', 'false') WHEN E.OPERATOR = '>' THEN IIF(L.VALUE > R.VALUE, 'true', 'false') WHEN E.OPERATOR = '<' THEN IIF(L.VALUE < R.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E INNER JOIN VARIABLES AS L ON L.NAME = E.LEFT_OPERAND INNER JOIN VARIABLES AS R ON R.NAME = E.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_14e2a0', 'a_s_16d2f3', 'a_s_050e68', None)
('C', 'a_s_16d2f3', 'a_s_050e68', None)
('a_s_14e2a0', 'a_s_16d2f3', '_', None)
('O', 'a_s_16d2f3', 'a_s_050e68', None)
('a_s_14e2a0', 'a_s_16d2f3', 'O', None)
('a_s_14e2a0', 'a_s_6b8e3d', 'a_s_050e68', None)
('a_s_14e2a0', 'A', 'a_s_050e68', None)
('a_s_14e2a0', 'exp_fcc4f6', 'a_s_050e68', None)
('I', 'exp_fcc4f6', '@', None)
('E', 'exp_fcc4f6', 'B', None)
*/