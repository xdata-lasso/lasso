-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_f0682d', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_5e04e6', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('?', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('_', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_352031', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('F', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('J', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f0682d', 'a_s_06ac9c', 'a_s_5e04e6');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f0682d', '<', 'a_s_5e04e6');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_06ac9c', 'a_s_5e04e6');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f0682d', 'a_s_06ac9c', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('?', 'a_s_06ac9c', 'a_s_5e04e6');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f0682d', 'a_s_017907', 'a_s_5e04e6');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f0682d', 'A', 'a_s_5e04e6');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f0682d', 'exp_fcc4f6', 'a_s_5e04e6');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'B');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('J', 'exp_fcc4f6', 'F');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_f0682d', 'a_s_06ac9c', 'a_s_5e04e6', 'false')
('a_s_f0682d', '<', 'a_s_5e04e6', 'false')
('G', 'a_s_06ac9c', 'a_s_5e04e6', 'false')
('a_s_f0682d', 'a_s_06ac9c', 'A', 'false')
('?', 'a_s_06ac9c', 'a_s_5e04e6', 'false')
('a_s_f0682d', 'a_s_017907', 'a_s_5e04e6', 'false')
('a_s_f0682d', 'A', 'a_s_5e04e6', 'false')
('a_s_f0682d', 'exp_fcc4f6', 'a_s_5e04e6', 'false')
('@', 'exp_fcc4f6', 'B', 'false')
('J', 'exp_fcc4f6', 'F', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' AND V1.VALUE > V2.VALUE THEN 'true' WHEN OPERATOR = '>' AND V1.VALUE <= V2.VALUE THEN 'false' WHEN OPERATOR = '<' AND V1.VALUE < V2.VALUE THEN 'true' WHEN OPERATOR = '<' AND V1.VALUE >= V2.VALUE THEN 'false' WHEN OPERATOR = '=' AND V1.VALUE = V2.VALUE THEN 'true' WHEN OPERATOR = '=' AND V1.VALUE <> V2.VALUE THEN 'false' END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_f0682d', 'a_s_06ac9c', 'a_s_5e04e6', None)
('a_s_f0682d', '<', 'a_s_5e04e6', 'false')
('G', 'a_s_06ac9c', 'a_s_5e04e6', None)
('a_s_f0682d', 'a_s_06ac9c', 'A', None)
('?', 'a_s_06ac9c', 'a_s_5e04e6', None)
('a_s_f0682d', 'a_s_017907', 'a_s_5e04e6', None)
('a_s_f0682d', 'A', 'a_s_5e04e6', None)
('a_s_f0682d', 'exp_fcc4f6', 'a_s_5e04e6', None)
('@', 'exp_fcc4f6', 'B', None)
('J', 'exp_fcc4f6', 'F', None)
*/