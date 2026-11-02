-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_eda887', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_3552ec', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_6ea430', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('H', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('P', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eda887', 'a_s_1b41d8', 'a_s_3552ec');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eda887', '<', 'a_s_3552ec');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_1b41d8', 'a_s_3552ec');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eda887', 'a_s_1b41d8', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_1b41d8', 'a_s_3552ec');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eda887', 'a_s_af24a7', 'a_s_3552ec');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eda887', 'A', 'a_s_3552ec');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eda887', 'exp_fcc4f6', 'a_s_3552ec');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'E');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('P', 'exp_fcc4f6', 'H');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_eda887', 'a_s_1b41d8', 'a_s_3552ec', 'false')
('a_s_eda887', '<', 'a_s_3552ec', 'false')
('O', 'a_s_1b41d8', 'a_s_3552ec', 'false')
('a_s_eda887', 'a_s_1b41d8', 'A', 'false')
('G', 'a_s_1b41d8', 'a_s_3552ec', 'false')
('a_s_eda887', 'a_s_af24a7', 'a_s_3552ec', 'false')
('a_s_eda887', 'A', 'a_s_3552ec', 'false')
('a_s_eda887', 'exp_fcc4f6', 'a_s_3552ec', 'false')
('@', 'exp_fcc4f6', 'E', 'false')
('P', 'exp_fcc4f6', 'H', 'false')
*/

-- Prediction Query
SELECT C1.LEFT_OPERAND, C1.OPERATOR, C1.RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(C1.VALUE > C1.OTHER, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(C1.VALUE < C1.OTHER, 'true', 'false') ELSE IIF(C1.VALUE = C1.OTHER, 'true', 'false') END AS VALUE FROM (WITH CTE AS (SELECT V.VALUE, E.* FROM VARIABLES AS V INNER JOIN EXPRESSIONS AS E ON V.NAME = E.LEFT_OPERAND UNION ALL SELECT E.*, V.VALUE FROM VARIABLES AS V INNER JOIN EXPRESSIONS AS E ON V.NAME = E.RIGHT_OPERAND) SELECT DISTINCT A1.*, A2.VALUE AS OTHER FROM CTE AS A1 INNER JOIN CTE AS A2 ON A1.RIGHT_OPERAND = A2.LEFT_OPERAND) AS C1;

/*
Prediction Result:
('a_s_eda887', 'a_s_1b41d8', 'A', 'false')
*/