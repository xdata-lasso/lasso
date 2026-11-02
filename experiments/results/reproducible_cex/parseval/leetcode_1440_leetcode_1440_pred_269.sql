-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_a633ab', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_a6465c', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_8a8a2d', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('I', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('P', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('C', -1980249628);

INSERT INTO "variables" ("name", "value") VALUES ('a', -734455130);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a633ab', 'a_s_aa0b66', 'a_s_a6465c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_aa0b66', 'a_s_a6465c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a633ab', 'a_s_aa0b66', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a633ab', 'a_s_d5bc4f', 'a_s_a6465c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a633ab', 'A', 'a_s_a6465c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a633ab', 'exp_fcc4f6', 'a_s_a6465c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'I');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'P');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a', 'exp_fcc4f6', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_a633ab', 'a_s_aa0b66', 'a_s_a6465c', 'false')
('A', 'a_s_aa0b66', 'a_s_a6465c', 'false')
('a_s_a633ab', 'a_s_aa0b66', 'O', 'false')
('a_s_a633ab', 'a_s_d5bc4f', 'a_s_a6465c', 'false')
('a_s_a633ab', 'A', 'a_s_a6465c', 'false')
('a_s_a633ab', 'exp_fcc4f6', 'a_s_a6465c', 'false')
('@', 'exp_fcc4f6', 'I', 'false')
('`', 'exp_fcc4f6', 'P', 'false')
('a', 'exp_fcc4f6', 'C', 'false')
*/

-- Prediction Query
SELECT E.*, (CASE WHEN E.OPERATOR = '>' AND V.VALUE > V1.VALUE THEN 'true' WHEN E.OPERATOR = '>' AND V.VALUE <= V1.VALUE THEN 'false' WHEN E.OPERATOR = '<' AND V.VALUE < V1.VALUE THEN 'true' WHEN E.OPERATOR = '<' AND V.VALUE >= V1.VALUE THEN 'false' WHEN E.OPERATOR = '=' AND V.VALUE = V1.VALUE THEN 'true' WHEN E.OPERATOR = '=' AND V.VALUE <> V1.VALUE THEN 'false' END) AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V ON E.LEFT_OPERAND = V.NAME LEFT JOIN VARIABLES AS V1 ON E.RIGHT_OPERAND = V1.NAME;

/*
Prediction Result:
('a_s_a633ab', 'a_s_aa0b66', 'a_s_a6465c', None)
('A', 'a_s_aa0b66', 'a_s_a6465c', None)
('a_s_a633ab', 'a_s_aa0b66', 'O', None)
('a_s_a633ab', 'a_s_d5bc4f', 'a_s_a6465c', None)
('a_s_a633ab', 'A', 'a_s_a6465c', None)
('a_s_a633ab', 'exp_fcc4f6', 'a_s_a6465c', None)
('@', 'exp_fcc4f6', 'I', None)
('`', 'exp_fcc4f6', 'P', None)
('a', 'exp_fcc4f6', 'C', None)
*/