-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_172ea4', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_5b1489', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('C', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('I', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_3eb883', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('!', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('K', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_172ea4', 'a_s_e61b99', 'a_s_5b1489');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_e61b99', 'a_s_5b1489');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_172ea4', 'a_s_e61b99', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_172ea4', 'a_s_bc7c77', 'a_s_5b1489');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_172ea4', 'A', 'a_s_5b1489');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('!', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_172ea4', 'exp_fcc4f6', 'a_s_5b1489');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('K', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_172ea4', 'a_s_e61b99', 'a_s_5b1489', 'false')
('A', 'a_s_e61b99', 'a_s_5b1489', 'false')
('a_s_172ea4', 'a_s_e61b99', 'A', 'false')
('a_s_172ea4', 'a_s_bc7c77', 'a_s_5b1489', 'false')
('a_s_172ea4', 'A', 'a_s_5b1489', 'false')
('!', 'exp_fcc4f6', '@', 'false')
('a_s_172ea4', 'exp_fcc4f6', 'a_s_5b1489', 'false')
('K', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN OPERATOR = '<' THEN IIF(L_V.VALUE < R_V.VALUE, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(L_V.VALUE > R_V.VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(L_V.VALUE = R_V.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS L_V ON (E.LEFT_OPERAND = L_V.NAME) JOIN VARIABLES AS R_V ON (E.RIGHT_OPERAND = R_V.NAME);

/*
Prediction Result:
('a_s_172ea4', 'a_s_e61b99', 'a_s_5b1489', None)
('A', 'a_s_e61b99', 'a_s_5b1489', None)
('a_s_172ea4', 'a_s_e61b99', 'A', None)
('a_s_172ea4', 'a_s_bc7c77', 'a_s_5b1489', None)
('a_s_172ea4', 'A', 'a_s_5b1489', None)
('!', 'exp_fcc4f6', '@', None)
('a_s_172ea4', 'exp_fcc4f6', 'a_s_5b1489', None)
('K', 'exp_fcc4f6', 'B', None)
*/