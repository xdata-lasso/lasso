-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_f44f3a', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_28b3c0', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('C', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('?', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('_', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_521a2a', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f44f3a', 'a_s_a4d996', 'a_s_28b3c0');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f44f3a', '<', 'a_s_28b3c0');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'a_s_a4d996', 'a_s_28b3c0');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f44f3a', 'a_s_a4d996', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_a4d996', 'a_s_28b3c0');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f44f3a', 'a_s_8f322b', 'a_s_28b3c0');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f44f3a', 'A', 'a_s_28b3c0');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f44f3a', 'exp_fcc4f6', 'a_s_28b3c0');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_f44f3a', 'a_s_a4d996', 'a_s_28b3c0', 'false')
('a_s_f44f3a', '<', 'a_s_28b3c0', 'false')
('C', 'a_s_a4d996', 'a_s_28b3c0', 'false')
('a_s_f44f3a', 'a_s_a4d996', 'A', 'false')
('O', 'a_s_a4d996', 'a_s_28b3c0', 'false')
('a_s_f44f3a', 'a_s_8f322b', 'a_s_28b3c0', 'false')
('a_s_f44f3a', 'A', 'a_s_28b3c0', 'false')
('a_s_f44f3a', 'exp_fcc4f6', 'a_s_28b3c0', 'false')
('@', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN E.OPERATOR = '=' THEN IIF(V.VALUE = V1.VALUE, 'true', 'false') WHEN E.OPERATOR = '>' THEN IIF(V.VALUE > V1.VALUE, 'true', 'false') WHEN E.OPERATOR = '<' THEN IIF(V.VALUE < V1.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V ON V.NAME = E.LEFT_OPERAND LEFT JOIN VARIABLES AS V1 ON V1.NAME = E.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_f44f3a', 'a_s_a4d996', 'a_s_28b3c0', None)
('a_s_f44f3a', '<', 'a_s_28b3c0', 'false')
('C', 'a_s_a4d996', 'a_s_28b3c0', None)
('a_s_f44f3a', 'a_s_a4d996', 'A', None)
('O', 'a_s_a4d996', 'a_s_28b3c0', None)
('a_s_f44f3a', 'a_s_8f322b', 'a_s_28b3c0', None)
('a_s_f44f3a', 'A', 'a_s_28b3c0', None)
('a_s_f44f3a', 'exp_fcc4f6', 'a_s_28b3c0', None)
('@', 'exp_fcc4f6', 'B', None)
*/