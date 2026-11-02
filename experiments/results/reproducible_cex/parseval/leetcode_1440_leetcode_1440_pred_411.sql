-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_0e8dfb', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_d384e4', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_888ac2', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('C', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_0e8dfb', 'a_s_7e4d32', 'a_s_d384e4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_0e8dfb', '<', 'a_s_d384e4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_7e4d32', 'a_s_d384e4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_0e8dfb', 'a_s_7e4d32', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_0e8dfb', 'a_s_0fec89', 'a_s_d384e4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_0e8dfb', 'A', 'a_s_d384e4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_0e8dfb', 'exp_fcc4f6', 'a_s_d384e4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_0e8dfb', 'a_s_7e4d32', 'a_s_d384e4', 'false')
('a_s_0e8dfb', '<', 'a_s_d384e4', 'false')
('G', 'a_s_7e4d32', 'a_s_d384e4', 'false')
('a_s_0e8dfb', 'a_s_7e4d32', 'A', 'false')
('a_s_0e8dfb', 'a_s_0fec89', 'a_s_d384e4', 'false')
('a_s_0e8dfb', 'A', 'a_s_d384e4', 'false')
('a_s_0e8dfb', 'exp_fcc4f6', 'a_s_d384e4', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('`', 'exp_fcc4f6', 'C', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN E.OPERATOR = '=' THEN IIF(V.VALUE = VR.VALUE, 'true', 'false') WHEN E.OPERATOR = '>' THEN IIF(V.VALUE > VR.VALUE, 'true', 'false') WHEN E.OPERATOR = '<' THEN IIF(V.VALUE < VR.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V ON V.NAME = E.LEFT_OPERAND LEFT JOIN VARIABLES AS VR ON VR.NAME = E.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_0e8dfb', 'a_s_7e4d32', 'a_s_d384e4', None)
('a_s_0e8dfb', '<', 'a_s_d384e4', 'false')
('G', 'a_s_7e4d32', 'a_s_d384e4', None)
('a_s_0e8dfb', 'a_s_7e4d32', 'A', None)
('a_s_0e8dfb', 'a_s_0fec89', 'a_s_d384e4', None)
('a_s_0e8dfb', 'A', 'a_s_d384e4', None)
('a_s_0e8dfb', 'exp_fcc4f6', 'a_s_d384e4', None)
('B', 'exp_fcc4f6', '@', None)
('`', 'exp_fcc4f6', 'C', None)
*/