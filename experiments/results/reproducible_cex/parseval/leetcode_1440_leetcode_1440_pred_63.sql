-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_66cdfc', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_840ce5', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_b55639', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('I', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('H', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_66cdfc', 'a_s_2c1f22', 'a_s_840ce5');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_66cdfc', '<', 'a_s_840ce5');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_2c1f22', 'a_s_840ce5');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_66cdfc', 'a_s_2c1f22', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_2c1f22', 'a_s_840ce5');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_66cdfc', 'a_s_4484d7', 'a_s_840ce5');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_66cdfc', 'A', 'a_s_840ce5');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_66cdfc', 'exp_fcc4f6', 'a_s_840ce5');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'I');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'H');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_66cdfc', 'a_s_2c1f22', 'a_s_840ce5', 'false')
('a_s_66cdfc', '<', 'a_s_840ce5', 'false')
('G', 'a_s_2c1f22', 'a_s_840ce5', 'false')
('a_s_66cdfc', 'a_s_2c1f22', 'A', 'false')
('O', 'a_s_2c1f22', 'a_s_840ce5', 'false')
('a_s_66cdfc', 'a_s_4484d7', 'a_s_840ce5', 'false')
('a_s_66cdfc', 'A', 'a_s_840ce5', 'false')
('a_s_66cdfc', 'exp_fcc4f6', 'a_s_840ce5', 'false')
('@', 'exp_fcc4f6', 'I', 'false')
('`', 'exp_fcc4f6', 'H', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN E.OPERATOR = '<' THEN IIF(L.VALUE < R.VALUE, 'true', 'false') WHEN E.OPERATOR = '>' THEN IIF(L.VALUE > R.VALUE, 'true', 'false') ELSE IIF(L.VALUE = R.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS L ON E.LEFT_OPERAND = L.NAME LEFT JOIN VARIABLES AS R ON E.RIGHT_OPERAND = R.NAME;

/*
Prediction Result:
('a_s_66cdfc', 'a_s_2c1f22', 'a_s_840ce5', 'true')
('a_s_66cdfc', '<', 'a_s_840ce5', 'false')
('G', 'a_s_2c1f22', 'a_s_840ce5', 'false')
('a_s_66cdfc', 'a_s_2c1f22', 'A', 'true')
('O', 'a_s_2c1f22', 'a_s_840ce5', 'true')
('a_s_66cdfc', 'a_s_4484d7', 'a_s_840ce5', 'true')
('a_s_66cdfc', 'A', 'a_s_840ce5', 'true')
('a_s_66cdfc', 'exp_fcc4f6', 'a_s_840ce5', 'true')
('@', 'exp_fcc4f6', 'I', 'false')
('`', 'exp_fcc4f6', 'H', 'false')
*/