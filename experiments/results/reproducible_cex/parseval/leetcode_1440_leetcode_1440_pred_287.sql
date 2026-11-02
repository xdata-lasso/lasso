-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_8b0391', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_dc9595', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_604e26', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('P', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('B', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('C', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_8b0391', 'a_s_71f69d', 'a_s_dc9595');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_71f69d', 'a_s_dc9595');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_8b0391', 'a_s_71f69d', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_8b0391', 'a_s_71f69d', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_8b0391', 'a_s_2559c4', 'a_s_dc9595');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_8b0391', 'A', 'a_s_dc9595');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_8b0391', 'exp_fcc4f6', 'a_s_dc9595');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'P');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_8b0391', 'a_s_71f69d', 'a_s_dc9595', 'false')
('O', 'a_s_71f69d', 'a_s_dc9595', 'false')
('a_s_8b0391', 'a_s_71f69d', 'G', 'false')
('a_s_8b0391', 'a_s_71f69d', 'O', 'false')
('a_s_8b0391', 'a_s_2559c4', 'a_s_dc9595', 'false')
('a_s_8b0391', 'A', 'a_s_dc9595', 'false')
('a_s_8b0391', 'exp_fcc4f6', 'a_s_dc9595', 'false')
('@', 'exp_fcc4f6', 'P', 'false')
('B', 'exp_fcc4f6', 'C', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '<' THEN CASE WHEN V1.VALUE < V2.VALUE THEN 'true' ELSE 'false' END WHEN OPERATOR = '=' THEN CASE WHEN V1.VALUE = V2.VALUE THEN 'true' ELSE 'false' END ELSE CASE WHEN V1.VALUE > V2.VALUE THEN 'true' ELSE 'false' END END AS VALUE FROM EXPRESSIONS LEFT JOIN VARIABLES AS V1 ON EXPRESSIONS.LEFT_OPERAND = V1.NAME LEFT JOIN VARIABLES AS V2 ON EXPRESSIONS.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_8b0391', 'a_s_71f69d', 'a_s_dc9595', 'false')
('O', 'a_s_71f69d', 'a_s_dc9595', 'false')
('a_s_8b0391', 'a_s_71f69d', 'G', 'true')
('a_s_8b0391', 'a_s_71f69d', 'O', 'true')
('a_s_8b0391', 'a_s_2559c4', 'a_s_dc9595', 'false')
('a_s_8b0391', 'A', 'a_s_dc9595', 'false')
('a_s_8b0391', 'exp_fcc4f6', 'a_s_dc9595', 'false')
('@', 'exp_fcc4f6', 'P', 'true')
('B', 'exp_fcc4f6', 'C', 'true')
*/