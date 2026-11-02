-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_f7e92c', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_a1ad20', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_b25028', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('B', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('I', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f7e92c', 'a_s_62bdad', 'a_s_a1ad20');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f7e92c', '<', 'a_s_a1ad20');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_62bdad', 'a_s_a1ad20');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f7e92c', 'a_s_62bdad', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_62bdad', 'a_s_a1ad20');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f7e92c', 'a_s_62bdad', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f7e92c', 'a_s_fcc99b', 'a_s_a1ad20');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f7e92c', 'A', 'a_s_a1ad20');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f7e92c', 'exp_fcc4f6', 'a_s_a1ad20');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'E');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('I', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_f7e92c', 'a_s_62bdad', 'a_s_a1ad20', 'false')
('a_s_f7e92c', '<', 'a_s_a1ad20', 'false')
('G', 'a_s_62bdad', 'a_s_a1ad20', 'false')
('a_s_f7e92c', 'a_s_62bdad', 'O', 'false')
('O', 'a_s_62bdad', 'a_s_a1ad20', 'false')
('a_s_f7e92c', 'a_s_62bdad', 'G', 'false')
('a_s_f7e92c', 'a_s_fcc99b', 'a_s_a1ad20', 'false')
('a_s_f7e92c', 'A', 'a_s_a1ad20', 'false')
('a_s_f7e92c', 'exp_fcc4f6', 'a_s_a1ad20', 'false')
('@', 'exp_fcc4f6', 'E', 'false')
('I', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
WITH CTE AS (SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN E.OPERATOR = '>' THEN V.VALUE > V2.VALUE WHEN E.OPERATOR = '<' THEN V.VALUE < V2.VALUE ELSE V.VALUE = V2.VALUE END AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V ON E.LEFT_OPERAND = V.NAME LEFT JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN VALUE = 1 THEN 'true' ELSE 'false' END AS VALUE FROM CTE;

/*
Prediction Result:
('a_s_f7e92c', 'a_s_62bdad', 'a_s_a1ad20', 'true')
('a_s_f7e92c', '<', 'a_s_a1ad20', 'false')
('G', 'a_s_62bdad', 'a_s_a1ad20', 'false')
('a_s_f7e92c', 'a_s_62bdad', 'O', 'false')
('O', 'a_s_62bdad', 'a_s_a1ad20', 'false')
('a_s_f7e92c', 'a_s_62bdad', 'G', 'false')
('a_s_f7e92c', 'a_s_fcc99b', 'a_s_a1ad20', 'true')
('a_s_f7e92c', 'A', 'a_s_a1ad20', 'true')
('a_s_f7e92c', 'exp_fcc4f6', 'a_s_a1ad20', 'true')
('@', 'exp_fcc4f6', 'E', 'false')
('I', 'exp_fcc4f6', 'B', 'false')
*/