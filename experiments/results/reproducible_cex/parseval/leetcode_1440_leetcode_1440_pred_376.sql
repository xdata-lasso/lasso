-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_2ac221', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_166513', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_107e79', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('C', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2ac221', 'a_s_af8488', 'a_s_166513');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_af8488', 'a_s_166513');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2ac221', 'a_s_af8488', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2ac221', 'a_s_af8488', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2ac221', 'a_s_9a9df4', 'a_s_166513');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2ac221', 'A', 'a_s_166513');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2ac221', 'exp_fcc4f6', 'a_s_166513');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_2ac221', 'a_s_af8488', 'a_s_166513', 'false')
('G', 'a_s_af8488', 'a_s_166513', 'false')
('a_s_2ac221', 'a_s_af8488', 'O', 'false')
('a_s_2ac221', 'a_s_af8488', 'G', 'false')
('a_s_2ac221', 'a_s_9a9df4', 'a_s_166513', 'false')
('a_s_2ac221', 'A', 'a_s_166513', 'false')
('a_s_2ac221', 'exp_fcc4f6', 'a_s_166513', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('C', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, (CASE WHEN OPERATOR = '<' THEN CASE WHEN V1.VALUE < V2.VALUE THEN 'true' ELSE 'false' END WHEN OPERATOR = '>' THEN CASE WHEN V1.VALUE > V2.VALUE THEN 'true' ELSE 'false' END ELSE CASE WHEN V1.VALUE = V2.VALUE THEN 'true' ELSE 'false' END END) AS VALUE FROM EXPRESSIONS AS E CROSS JOIN VARIABLES AS V1 CROSS JOIN VARIABLES AS V2 WHERE V1.NAME = E.LEFT_OPERAND AND V2.NAME = E.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_2ac221', 'a_s_af8488', 'a_s_166513', 'true')
('G', 'a_s_af8488', 'a_s_166513', 'false')
('a_s_2ac221', 'a_s_af8488', 'O', 'false')
('a_s_2ac221', 'a_s_af8488', 'G', 'false')
('a_s_2ac221', 'a_s_9a9df4', 'a_s_166513', 'true')
('a_s_2ac221', 'A', 'a_s_166513', 'true')
('a_s_2ac221', 'exp_fcc4f6', 'a_s_166513', 'true')
('B', 'exp_fcc4f6', '@', 'false')
('C', 'exp_fcc4f6', '`', 'false')
*/