-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_25ed45', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_12e393', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_197f82', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('D', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('E', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_25ed45', 'a_s_4c0674', 'a_s_12e393');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_4c0674', 'a_s_12e393');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_25ed45', 'a_s_4c0674', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_25ed45', 'a_s_4c0674', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_25ed45', 'a_s_2fa9b4', 'a_s_12e393');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_25ed45', 'A', 'a_s_12e393');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_25ed45', 'exp_fcc4f6', 'a_s_12e393');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'D');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('E', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_25ed45', 'a_s_4c0674', 'a_s_12e393', 'false')
('O', 'a_s_4c0674', 'a_s_12e393', 'false')
('a_s_25ed45', 'a_s_4c0674', 'G', 'false')
('a_s_25ed45', 'a_s_4c0674', 'O', 'false')
('a_s_25ed45', 'a_s_2fa9b4', 'a_s_12e393', 'false')
('a_s_25ed45', 'A', 'a_s_12e393', 'false')
('a_s_25ed45', 'exp_fcc4f6', 'a_s_12e393', 'false')
('@', 'exp_fcc4f6', 'D', 'false')
('E', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '=' THEN IIF(LV = RV, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(LV > RV, 'true', 'false') ELSE IIF(LV < RV, 'true', 'false') END AS VALUE FROM (SELECT LV, A.OPERATOR, VALUE AS RV, A.LEFT_OPERAND, RIGHT_OPERAND FROM (SELECT LEFT_OPERAND, VALUE AS LV, OPERATOR, RIGHT_OPERAND FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V1 ON LEFT_OPERAND = NAME) AS A LEFT JOIN VARIABLES AS V2 ON RIGHT_OPERAND = NAME) AS NEW;

/*
Prediction Result:
('a_s_25ed45', 'a_s_4c0674', 'a_s_12e393', 'false')
('O', 'a_s_4c0674', 'a_s_12e393', 'true')
('a_s_25ed45', 'a_s_4c0674', 'G', 'false')
('a_s_25ed45', 'a_s_4c0674', 'O', 'false')
('a_s_25ed45', 'a_s_2fa9b4', 'a_s_12e393', 'false')
('a_s_25ed45', 'A', 'a_s_12e393', 'false')
('a_s_25ed45', 'exp_fcc4f6', 'a_s_12e393', 'false')
('@', 'exp_fcc4f6', 'D', 'false')
('E', 'exp_fcc4f6', 'B', 'false')
*/