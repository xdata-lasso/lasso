-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_57c47c', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_bcb51d', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('_', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_f90e25', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('H', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('F', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('B', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_57c47c', 'a_s_57aaab', 'a_s_bcb51d');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_57c47c', '<', 'a_s_bcb51d');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_57aaab', 'a_s_bcb51d');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_57c47c', 'a_s_57aaab', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_57c47c', 'a_s_9b2e83', 'a_s_bcb51d');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_57c47c', 'A', 'a_s_bcb51d');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_57c47c', 'exp_fcc4f6', 'a_s_bcb51d');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'H');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', 'F');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_57c47c', 'a_s_57aaab', 'a_s_bcb51d', 'false')
('a_s_57c47c', '<', 'a_s_bcb51d', 'false')
('A', 'a_s_57aaab', 'a_s_bcb51d', 'false')
('a_s_57c47c', 'a_s_57aaab', 'A', 'false')
('a_s_57c47c', 'a_s_9b2e83', 'a_s_bcb51d', 'false')
('a_s_57c47c', 'A', 'a_s_bcb51d', 'false')
('a_s_57c47c', 'exp_fcc4f6', 'a_s_bcb51d', 'false')
('@', 'exp_fcc4f6', 'H', 'false')
('B', 'exp_fcc4f6', 'F', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN OPERATOR = '=' THEN IIF(T1.VALUE = T2.VALUE, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(T1.VALUE > T2.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(T1.VALUE < T2.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS T1 ON T1.NAME = E.LEFT_OPERAND JOIN VARIABLES AS T2 ON T2.NAME = E.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_57c47c', 'a_s_57aaab', 'a_s_bcb51d', None)
('a_s_57c47c', '<', 'a_s_bcb51d', 'false')
('A', 'a_s_57aaab', 'a_s_bcb51d', None)
('a_s_57c47c', 'a_s_57aaab', 'A', None)
('a_s_57c47c', 'a_s_9b2e83', 'a_s_bcb51d', None)
('a_s_57c47c', 'A', 'a_s_bcb51d', None)
('a_s_57c47c', 'exp_fcc4f6', 'a_s_bcb51d', None)
('@', 'exp_fcc4f6', 'H', None)
('B', 'exp_fcc4f6', 'F', None)
*/