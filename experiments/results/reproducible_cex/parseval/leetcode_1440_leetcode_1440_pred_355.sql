-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_70f4ba', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_8085fc', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('C', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('_', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_23b5c5', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('@', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('U', -1980249628);

INSERT INTO "variables" ("name", "value") VALUES ('B', -734455130);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_70f4ba', 'a_s_d473c5', 'a_s_8085fc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_d473c5', 'a_s_8085fc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_70f4ba', 'a_s_d473c5', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_70f4ba', 'a_s_d473c5', '_');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_70f4ba', 'a_s_124a76', 'a_s_8085fc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_70f4ba', 'A', 'a_s_8085fc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'E');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_70f4ba', 'exp_fcc4f6', 'a_s_8085fc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', 'U');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_70f4ba', 'a_s_d473c5', 'a_s_8085fc', 'false')
('A', 'a_s_d473c5', 'a_s_8085fc', 'false')
('a_s_70f4ba', 'a_s_d473c5', 'O', 'false')
('a_s_70f4ba', 'a_s_d473c5', '_', 'false')
('a_s_70f4ba', 'a_s_124a76', 'a_s_8085fc', 'false')
('a_s_70f4ba', 'A', 'a_s_8085fc', 'false')
('@', 'exp_fcc4f6', 'E', 'false')
('a_s_70f4ba', 'exp_fcc4f6', 'a_s_8085fc', 'false')
('B', 'exp_fcc4f6', 'U', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN VALUE = 1 THEN 'true' ELSE 'false' END AS VALUE FROM (SELECT E.*, CASE WHEN OPERATOR = '>' THEN (V1.VALUE > V2.VALUE) WHEN OPERATOR = '<' THEN (V1.VALUE < V2.VALUE) ELSE (V1.VALUE = V2.VALUE) END AS VALUE FROM EXPRESSIONS AS E INNER JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME INNER JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME) AS A;

/*
Prediction Result:
('a_s_70f4ba', 'a_s_d473c5', 'a_s_8085fc', 'true')
('A', 'a_s_d473c5', 'a_s_8085fc', 'false')
('a_s_70f4ba', 'a_s_d473c5', 'O', 'false')
('a_s_70f4ba', 'a_s_d473c5', '_', 'false')
('a_s_70f4ba', 'a_s_124a76', 'a_s_8085fc', 'true')
('a_s_70f4ba', 'A', 'a_s_8085fc', 'true')
('@', 'exp_fcc4f6', 'E', 'false')
('a_s_70f4ba', 'exp_fcc4f6', 'a_s_8085fc', 'true')
('B', 'exp_fcc4f6', 'U', 'false')
*/