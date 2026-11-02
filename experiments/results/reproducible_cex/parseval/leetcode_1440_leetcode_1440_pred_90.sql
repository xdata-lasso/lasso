-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_416882', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_b6b77d', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_8cc84a', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('E', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('"', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_416882', 'a_s_f0a55a', 'a_s_b6b77d');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_f0a55a', 'a_s_b6b77d');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_416882', 'a_s_f0a55a', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_416882', 'a_s_f0a55a', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_416882', 'a_s_115e33', 'a_s_b6b77d');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_416882', 'A', 'a_s_b6b77d');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_416882', 'exp_fcc4f6', 'a_s_b6b77d');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('"', 'exp_fcc4f6', 'E');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_416882', 'a_s_f0a55a', 'a_s_b6b77d', 'false')
('A', 'a_s_f0a55a', 'a_s_b6b77d', 'false')
('a_s_416882', 'a_s_f0a55a', 'O', 'false')
('a_s_416882', 'a_s_f0a55a', 'G', 'false')
('a_s_416882', 'a_s_115e33', 'a_s_b6b77d', 'false')
('a_s_416882', 'A', 'a_s_b6b77d', 'false')
('a_s_416882', 'exp_fcc4f6', 'a_s_b6b77d', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('"', 'exp_fcc4f6', 'E', 'false')
*/

-- Prediction Query
SELECT A.*, CASE WHEN OPERATOR = '>' THEN IIF(B.VALUE > C.VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(B.VALUE = C.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(B.VALUE < C.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS A INNER JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME INNER JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Prediction Result:
('a_s_416882', 'a_s_f0a55a', 'a_s_b6b77d', None)
('A', 'a_s_f0a55a', 'a_s_b6b77d', None)
('a_s_416882', 'a_s_f0a55a', 'O', None)
('a_s_416882', 'a_s_f0a55a', 'G', None)
('a_s_416882', 'a_s_115e33', 'a_s_b6b77d', None)
('a_s_416882', 'A', 'a_s_b6b77d', None)
('a_s_416882', 'exp_fcc4f6', 'a_s_b6b77d', None)
('B', 'exp_fcc4f6', '@', None)
('"', 'exp_fcc4f6', 'E', None)
*/