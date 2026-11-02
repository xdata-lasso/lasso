-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_f3ebc9', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_f7edbb', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_d5677d', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('B', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f3ebc9', 'a_s_d6c66c', 'a_s_f7edbb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_d6c66c', 'a_s_f7edbb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f3ebc9', 'a_s_d6c66c', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_d6c66c', 'a_s_f7edbb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f3ebc9', 'a_s_d6c66c', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f3ebc9', 'a_s_e7fdd0', 'a_s_f7edbb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f3ebc9', 'A', 'a_s_f7edbb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f3ebc9', 'exp_fcc4f6', 'a_s_f7edbb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'E');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_f3ebc9', 'a_s_d6c66c', 'a_s_f7edbb', 'false')
('G', 'a_s_d6c66c', 'a_s_f7edbb', 'false')
('a_s_f3ebc9', 'a_s_d6c66c', 'O', 'false')
('O', 'a_s_d6c66c', 'a_s_f7edbb', 'false')
('a_s_f3ebc9', 'a_s_d6c66c', 'G', 'false')
('a_s_f3ebc9', 'a_s_e7fdd0', 'a_s_f7edbb', 'false')
('a_s_f3ebc9', 'A', 'a_s_f7edbb', 'false')
('a_s_f3ebc9', 'exp_fcc4f6', 'a_s_f7edbb', 'false')
('@', 'exp_fcc4f6', 'E', 'false')
('`', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN OPERATOR = '=' THEN IIF(V1.VALUE = V2.VALUE, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(V1.VALUE > V2.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(V1.VALUE < V2.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME LEFT JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_f3ebc9', 'a_s_d6c66c', 'a_s_f7edbb', None)
('G', 'a_s_d6c66c', 'a_s_f7edbb', None)
('a_s_f3ebc9', 'a_s_d6c66c', 'O', None)
('O', 'a_s_d6c66c', 'a_s_f7edbb', None)
('a_s_f3ebc9', 'a_s_d6c66c', 'G', None)
('a_s_f3ebc9', 'a_s_e7fdd0', 'a_s_f7edbb', None)
('a_s_f3ebc9', 'A', 'a_s_f7edbb', None)
('a_s_f3ebc9', 'exp_fcc4f6', 'a_s_f7edbb', None)
('@', 'exp_fcc4f6', 'E', None)
('`', 'exp_fcc4f6', 'B', None)
*/