-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_5bb245', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_e64e1f', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_cb8e29', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('!', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('Q', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_5bb245', 'a_s_1767bb', 'a_s_e64e1f');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_1767bb', 'a_s_e64e1f');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_5bb245', 'a_s_1767bb', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_5bb245', 'a_s_1767bb', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_5bb245', 'a_s_707417', 'a_s_e64e1f');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_5bb245', 'A', 'a_s_e64e1f');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_5bb245', 'exp_fcc4f6', 'a_s_e64e1f');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('!', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('Q', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_5bb245', 'a_s_1767bb', 'a_s_e64e1f', 'false')
('O', 'a_s_1767bb', 'a_s_e64e1f', 'false')
('a_s_5bb245', 'a_s_1767bb', 'O', 'false')
('a_s_5bb245', 'a_s_1767bb', 'G', 'false')
('a_s_5bb245', 'a_s_707417', 'a_s_e64e1f', 'false')
('a_s_5bb245', 'A', 'a_s_e64e1f', 'false')
('a_s_5bb245', 'exp_fcc4f6', 'a_s_e64e1f', 'false')
('!', 'exp_fcc4f6', '@', 'false')
('Q', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, (CASE WHEN OPERATOR = '>' THEN IIF(VAR1.VALUE > VAR2.VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(VAR1.VALUE = VAR2.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(VAR1.VALUE < VAR2.VALUE, 'true', 'false') END) AS VALUE FROM EXPRESSIONS AS EXP JOIN VARIABLES AS VAR1 ON EXP.LEFT_OPERAND = VAR1.NAME JOIN VARIABLES AS VAR2 ON EXP.RIGHT_OPERAND = VAR2.NAME;

/*
Prediction Result:
('a_s_5bb245', 'a_s_1767bb', 'a_s_e64e1f', None)
('O', 'a_s_1767bb', 'a_s_e64e1f', None)
('a_s_5bb245', 'a_s_1767bb', 'O', None)
('a_s_5bb245', 'a_s_1767bb', 'G', None)
('a_s_5bb245', 'a_s_707417', 'a_s_e64e1f', None)
('a_s_5bb245', 'A', 'a_s_e64e1f', None)
('a_s_5bb245', 'exp_fcc4f6', 'a_s_e64e1f', None)
('!', 'exp_fcc4f6', '@', None)
('Q', 'exp_fcc4f6', 'B', None)
*/