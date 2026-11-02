-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_a1c7a7', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_1d68fc', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_ac11b7', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('D', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a1c7a7', 'a_s_346836', 'a_s_1d68fc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_346836', 'a_s_1d68fc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a1c7a7', 'a_s_346836', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a1c7a7', 'a_s_c9aada', 'a_s_1d68fc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a1c7a7', 'A', 'a_s_1d68fc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a1c7a7', 'exp_fcc4f6', 'a_s_1d68fc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_a1c7a7', 'a_s_346836', 'a_s_1d68fc', 'false')
('A', 'a_s_346836', 'a_s_1d68fc', 'false')
('a_s_a1c7a7', 'a_s_346836', 'A', 'false')
('a_s_a1c7a7', 'a_s_c9aada', 'a_s_1d68fc', 'false')
('a_s_a1c7a7', 'A', 'a_s_1d68fc', 'false')
('a_s_a1c7a7', 'exp_fcc4f6', 'a_s_1d68fc', 'false')
('D', 'exp_fcc4f6', '@', 'false')
('`', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, (CASE WHEN E.OPERATOR = '>' THEN CASE WHEN V1.VALUE > V2.VALUE THEN 'true' ELSE 'false' END WHEN E.OPERATOR = '<' THEN CASE WHEN V1.VALUE < V2.VALUE THEN 'true' ELSE 'false' END ELSE CASE WHEN V1.VALUE = V2.VALUE THEN 'true' ELSE 'false' END END) AS VALUE FROM EXPRESSIONS AS E INNER JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME INNER JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_a1c7a7', 'a_s_346836', 'a_s_1d68fc', 'true')
('A', 'a_s_346836', 'a_s_1d68fc', 'false')
('a_s_a1c7a7', 'a_s_346836', 'A', 'false')
('a_s_a1c7a7', 'a_s_c9aada', 'a_s_1d68fc', 'true')
('a_s_a1c7a7', 'A', 'a_s_1d68fc', 'true')
('a_s_a1c7a7', 'exp_fcc4f6', 'a_s_1d68fc', 'true')
('D', 'exp_fcc4f6', '@', 'false')
('`', 'exp_fcc4f6', 'B', 'false')
*/