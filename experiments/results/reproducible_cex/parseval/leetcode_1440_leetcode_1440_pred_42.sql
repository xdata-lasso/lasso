-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_004982', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_fa9381', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('?', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_061e97', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('B', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('C', -1980249628);

INSERT INTO "variables" ("name", "value") VALUES ('I', -734455130);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_004982', 'a_s_3d82fb', 'a_s_fa9381');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_004982', '<', 'a_s_fa9381');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_3d82fb', 'a_s_fa9381');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_004982', 'a_s_3d82fb', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('?', 'a_s_3d82fb', 'a_s_fa9381');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_004982', 'a_s_de7971', 'a_s_fa9381');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_004982', 'A', 'a_s_fa9381');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_004982', 'exp_fcc4f6', 'a_s_fa9381');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'B');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'exp_fcc4f6', 'I');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_004982', 'a_s_3d82fb', 'a_s_fa9381', 'false')
('a_s_004982', '<', 'a_s_fa9381', 'false')
('O', 'a_s_3d82fb', 'a_s_fa9381', 'false')
('a_s_004982', 'a_s_3d82fb', 'G', 'false')
('?', 'a_s_3d82fb', 'a_s_fa9381', 'false')
('a_s_004982', 'a_s_de7971', 'a_s_fa9381', 'false')
('a_s_004982', 'A', 'a_s_fa9381', 'false')
('a_s_004982', 'exp_fcc4f6', 'a_s_fa9381', 'false')
('@', 'exp_fcc4f6', 'B', 'false')
('C', 'exp_fcc4f6', 'I', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, (CASE WHEN OPERATOR = '>' THEN IIF(X > Y, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(X < Y, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(X = Y, 'true', 'false') END) AS VALUE FROM (SELECT B.VALUE AS X, LEFT_OPERAND, OPERATOR, C.VALUE AS Y, RIGHT_OPERAND FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME) AS T;

/*
Prediction Result:
('a_s_004982', 'a_s_3d82fb', 'a_s_fa9381', None)
('a_s_004982', '<', 'a_s_fa9381', 'false')
('O', 'a_s_3d82fb', 'a_s_fa9381', None)
('a_s_004982', 'a_s_3d82fb', 'G', None)
('?', 'a_s_3d82fb', 'a_s_fa9381', None)
('a_s_004982', 'a_s_de7971', 'a_s_fa9381', None)
('a_s_004982', 'A', 'a_s_fa9381', None)
('a_s_004982', 'exp_fcc4f6', 'a_s_fa9381', None)
('@', 'exp_fcc4f6', 'B', None)
('C', 'exp_fcc4f6', 'I', None)
*/