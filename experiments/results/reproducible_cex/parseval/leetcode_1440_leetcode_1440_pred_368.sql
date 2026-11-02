-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_ffff80', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_1705e0', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_671d26', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('C', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('J', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ffff80', 'a_s_4df858', 'a_s_1705e0');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_4df858', 'a_s_1705e0');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ffff80', 'a_s_4df858', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ffff80', 'a_s_c7d0de', 'a_s_1705e0');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ffff80', 'A', 'a_s_1705e0');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ffff80', 'exp_fcc4f6', 'a_s_1705e0');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'B');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('J', 'exp_fcc4f6', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_ffff80', 'a_s_4df858', 'a_s_1705e0', 'false')
('A', 'a_s_4df858', 'a_s_1705e0', 'false')
('a_s_ffff80', 'a_s_4df858', 'O', 'false')
('a_s_ffff80', 'a_s_c7d0de', 'a_s_1705e0', 'false')
('a_s_ffff80', 'A', 'a_s_1705e0', 'false')
('a_s_ffff80', 'exp_fcc4f6', 'a_s_1705e0', 'false')
('@', 'exp_fcc4f6', 'B', 'false')
('J', 'exp_fcc4f6', 'C', 'false')
*/

-- Prediction Query
SELECT E.*, CASE WHEN OPERATOR LIKE '>' THEN IIF(V1.VALUE > V2.VALUE, 'true', 'false') WHEN OPERATOR LIKE '<' THEN IIF(V1.VALUE < V2.VALUE, 'true', 'false') WHEN OPERATOR LIKE '=' THEN IIF(V1.VALUE = V2.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_ffff80', 'a_s_4df858', 'a_s_1705e0', None)
('A', 'a_s_4df858', 'a_s_1705e0', None)
('a_s_ffff80', 'a_s_4df858', 'O', None)
('a_s_ffff80', 'a_s_c7d0de', 'a_s_1705e0', None)
('a_s_ffff80', 'A', 'a_s_1705e0', None)
('a_s_ffff80', 'exp_fcc4f6', 'a_s_1705e0', None)
('@', 'exp_fcc4f6', 'B', None)
('J', 'exp_fcc4f6', 'C', None)
*/