-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_70d6ce', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_cd12b9', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_51e3f4', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('D', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_70d6ce', 'a_s_34387f', 'a_s_cd12b9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_34387f', 'a_s_cd12b9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_70d6ce', 'a_s_34387f', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_34387f', 'a_s_cd12b9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_70d6ce', 'a_s_34387f', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_70d6ce', 'a_s_4f33c8', 'a_s_cd12b9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_70d6ce', 'A', 'a_s_cd12b9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_70d6ce', 'exp_fcc4f6', 'a_s_cd12b9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('E', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_70d6ce', 'a_s_34387f', 'a_s_cd12b9', 'false')
('G', 'a_s_34387f', 'a_s_cd12b9', 'false')
('a_s_70d6ce', 'a_s_34387f', 'O', 'false')
('O', 'a_s_34387f', 'a_s_cd12b9', 'false')
('a_s_70d6ce', 'a_s_34387f', 'G', 'false')
('a_s_70d6ce', 'a_s_4f33c8', 'a_s_cd12b9', 'false')
('a_s_70d6ce', 'A', 'a_s_cd12b9', 'false')
('a_s_70d6ce', 'exp_fcc4f6', 'a_s_cd12b9', 'false')
('E', 'exp_fcc4f6', '@', 'false')
('D', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
SELECT A.*, CASE WHEN OPERATOR = '>' THEN (CASE WHEN B.VALUE > C.VALUE THEN 'true' ELSE 'false' END) WHEN OPERATOR = '<' THEN (CASE WHEN B.VALUE < C.VALUE THEN 'true' ELSE 'false' END) WHEN OPERATOR = '=' THEN (CASE WHEN B.VALUE = C.VALUE THEN 'true' ELSE 'false' END) END AS VALUE FROM EXPRESSIONS AS A LEFT JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME LEFT JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Prediction Result:
('a_s_70d6ce', 'a_s_34387f', 'a_s_cd12b9', None)
('G', 'a_s_34387f', 'a_s_cd12b9', None)
('a_s_70d6ce', 'a_s_34387f', 'O', None)
('O', 'a_s_34387f', 'a_s_cd12b9', None)
('a_s_70d6ce', 'a_s_34387f', 'G', None)
('a_s_70d6ce', 'a_s_4f33c8', 'a_s_cd12b9', None)
('a_s_70d6ce', 'A', 'a_s_cd12b9', None)
('a_s_70d6ce', 'exp_fcc4f6', 'a_s_cd12b9', None)
('E', 'exp_fcc4f6', '@', None)
('D', 'exp_fcc4f6', '`', None)
*/