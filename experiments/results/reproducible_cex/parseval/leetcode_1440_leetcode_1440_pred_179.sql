-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_55c187', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_c1b71a', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_82f6fc', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('D', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('M', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_55c187', 'a_s_40a1de', 'a_s_c1b71a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_55c187', '<', 'a_s_c1b71a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_40a1de', 'a_s_c1b71a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_55c187', 'a_s_40a1de', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_40a1de', 'a_s_c1b71a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_55c187', 'a_s_37ba85', 'a_s_c1b71a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_55c187', 'A', 'a_s_c1b71a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_55c187', 'exp_fcc4f6', 'a_s_c1b71a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'E');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', 'M');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_55c187', 'a_s_40a1de', 'a_s_c1b71a', 'false')
('a_s_55c187', '<', 'a_s_c1b71a', 'false')
('G', 'a_s_40a1de', 'a_s_c1b71a', 'false')
('a_s_55c187', 'a_s_40a1de', 'A', 'false')
('O', 'a_s_40a1de', 'a_s_c1b71a', 'false')
('a_s_55c187', 'a_s_37ba85', 'a_s_c1b71a', 'false')
('a_s_55c187', 'A', 'a_s_c1b71a', 'false')
('a_s_55c187', 'exp_fcc4f6', 'a_s_c1b71a', 'false')
('@', 'exp_fcc4f6', 'E', 'false')
('D', 'exp_fcc4f6', 'M', 'false')
*/

-- Prediction Query
WITH T AS (SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, LV.NAME AS LV_NAME, LV.VALUE AS LV_VALUE, RV.NAME AS RV_NAME, RV.VALUE AS RV_VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS LV ON E.LEFT_OPERAND = LV.NAME LEFT JOIN VARIABLES AS RV ON E.RIGHT_OPERAND = RV.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(LV_VALUE > RV_VALUE = 1, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(LV_VALUE = RV_VALUE = 1, 'true', 'false') ELSE IIF(LV_VALUE < RV_VALUE = 1, 'true', 'false') END AS VALUE FROM T;

/*
Prediction Result:
('a_s_55c187', 'a_s_40a1de', 'a_s_c1b71a', 'false')
('a_s_55c187', '<', 'a_s_c1b71a', 'false')
('G', 'a_s_40a1de', 'a_s_c1b71a', 'true')
('a_s_55c187', 'a_s_40a1de', 'A', 'false')
('O', 'a_s_40a1de', 'a_s_c1b71a', 'true')
('a_s_55c187', 'a_s_37ba85', 'a_s_c1b71a', 'false')
('a_s_55c187', 'A', 'a_s_c1b71a', 'false')
('a_s_55c187', 'exp_fcc4f6', 'a_s_c1b71a', 'false')
('@', 'exp_fcc4f6', 'E', 'false')
('D', 'exp_fcc4f6', 'M', 'false')
*/