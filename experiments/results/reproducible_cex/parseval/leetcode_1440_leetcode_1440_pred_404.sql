-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_568a7a', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_2bf85e', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('?', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('I', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('G', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_2c3d29', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('@', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('!', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_568a7a', 'a_s_c50251', 'a_s_2bf85e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_c50251', 'a_s_2bf85e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_568a7a', 'a_s_c50251', '?');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('I', 'a_s_c50251', 'a_s_2bf85e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_568a7a', 'a_s_c50251', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_568a7a', 'a_s_67cc82', 'a_s_2bf85e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_568a7a', 'A', 'a_s_2bf85e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_568a7a', 'exp_fcc4f6', 'a_s_2bf85e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', '!');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_568a7a', 'a_s_c50251', 'a_s_2bf85e', 'false')
('O', 'a_s_c50251', 'a_s_2bf85e', 'false')
('a_s_568a7a', 'a_s_c50251', '?', 'false')
('I', 'a_s_c50251', 'a_s_2bf85e', 'false')
('a_s_568a7a', 'a_s_c50251', 'G', 'false')
('a_s_568a7a', 'a_s_67cc82', 'a_s_2bf85e', 'false')
('a_s_568a7a', 'A', 'a_s_2bf85e', 'false')
('a_s_568a7a', 'exp_fcc4f6', 'a_s_2bf85e', 'false')
('@', 'exp_fcc4f6', '!', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE OPERATOR WHEN '<' THEN IIF(LV.VALUE < RV.VALUE, 'true', 'false') WHEN '>' THEN IIF(LV.VALUE > RV.VALUE, 'true', 'false') ELSE IIF(LV.VALUE = RV.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS JOIN VARIABLES AS LV ON LEFT_OPERAND = LV.NAME JOIN VARIABLES AS RV ON RIGHT_OPERAND = RV.NAME;

/*
Prediction Result:
('a_s_568a7a', 'a_s_c50251', 'a_s_2bf85e', 'true')
('O', 'a_s_c50251', 'a_s_2bf85e', 'false')
('a_s_568a7a', 'a_s_c50251', '?', 'false')
('I', 'a_s_c50251', 'a_s_2bf85e', 'false')
('a_s_568a7a', 'a_s_c50251', 'G', 'false')
('a_s_568a7a', 'a_s_67cc82', 'a_s_2bf85e', 'true')
('a_s_568a7a', 'A', 'a_s_2bf85e', 'true')
('a_s_568a7a', 'exp_fcc4f6', 'a_s_2bf85e', 'true')
('@', 'exp_fcc4f6', '!', 'false')
*/