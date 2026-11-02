-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_95b10d', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_5a6f69', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('I', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_425028', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('C', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_95b10d', 'a_s_aa73a6', 'a_s_5a6f69');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_aa73a6', 'a_s_5a6f69');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_95b10d', 'a_s_aa73a6', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_95b10d', 'a_s_7de8d3', 'a_s_5a6f69');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_95b10d', 'A', 'a_s_5a6f69');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_95b10d', 'exp_fcc4f6', 'a_s_5a6f69');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'B');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_95b10d', 'a_s_aa73a6', 'a_s_5a6f69', 'false')
('A', 'a_s_aa73a6', 'a_s_5a6f69', 'false')
('a_s_95b10d', 'a_s_aa73a6', 'A', 'false')
('a_s_95b10d', 'a_s_7de8d3', 'a_s_5a6f69', 'false')
('a_s_95b10d', 'A', 'a_s_5a6f69', 'false')
('a_s_95b10d', 'exp_fcc4f6', 'a_s_5a6f69', 'false')
('@', 'exp_fcc4f6', 'B', 'false')
('`', 'exp_fcc4f6', 'C', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '=' THEN IIF(V1.VALUE = V2.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(V1.VALUE < V2.VALUE, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(V1.VALUE > V2.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS JOIN VARIABLES AS V1 ON LEFT_OPERAND = V1.NAME JOIN VARIABLES AS V2 ON RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_95b10d', 'a_s_aa73a6', 'a_s_5a6f69', None)
('A', 'a_s_aa73a6', 'a_s_5a6f69', None)
('a_s_95b10d', 'a_s_aa73a6', 'A', None)
('a_s_95b10d', 'a_s_7de8d3', 'a_s_5a6f69', None)
('a_s_95b10d', 'A', 'a_s_5a6f69', None)
('a_s_95b10d', 'exp_fcc4f6', 'a_s_5a6f69', None)
('@', 'exp_fcc4f6', 'B', None)
('`', 'exp_fcc4f6', 'C', None)
*/