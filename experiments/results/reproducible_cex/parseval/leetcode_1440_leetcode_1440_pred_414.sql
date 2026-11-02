-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_56bd60', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_098fdd', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('C', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_86e6e0', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('a', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('D', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_56bd60', 'a_s_8024c8', 'a_s_098fdd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_56bd60', '<', 'a_s_098fdd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_8024c8', 'a_s_098fdd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_56bd60', 'a_s_8024c8', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_56bd60', 'a_s_8024c8', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_56bd60', 'a_s_17f92f', 'a_s_098fdd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_56bd60', 'A', 'a_s_098fdd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_56bd60', 'exp_fcc4f6', 'a_s_098fdd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_56bd60', 'a_s_8024c8', 'a_s_098fdd', 'false')
('a_s_56bd60', '<', 'a_s_098fdd', 'false')
('A', 'a_s_8024c8', 'a_s_098fdd', 'false')
('a_s_56bd60', 'a_s_8024c8', 'G', 'false')
('a_s_56bd60', 'a_s_8024c8', 'O', 'false')
('a_s_56bd60', 'a_s_17f92f', 'a_s_098fdd', 'false')
('a_s_56bd60', 'A', 'a_s_098fdd', 'false')
('a_s_56bd60', 'exp_fcc4f6', 'a_s_098fdd', 'false')
('a', 'exp_fcc4f6', '@', 'false')
('B', 'exp_fcc4f6', 'D', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN (CASE WHEN OPERATOR = '<' THEN LEFT_VALUE < RIGHT_VALUE WHEN OPERATOR = '>' THEN LEFT_VALUE > RIGHT_VALUE ELSE LEFT_VALUE = RIGHT_VALUE END) = 1 THEN 'true' ELSE 'false' END AS VALUE FROM (SELECT LEFT_OPERAND, T2.VALUE AS LEFT_VALUE, OPERATOR, RIGHT_OPERAND, T3.VALUE AS RIGHT_VALUE FROM EXPRESSIONS AS T1 LEFT JOIN VARIABLES AS T2 ON T1.LEFT_OPERAND = T2.NAME LEFT JOIN VARIABLES AS T3 ON T1.RIGHT_OPERAND = T3.NAME) AS SUBQ1;

/*
Prediction Result:
('a_s_56bd60', 'a_s_8024c8', 'a_s_098fdd', 'true')
('a_s_56bd60', '<', 'a_s_098fdd', 'false')
('A', 'a_s_8024c8', 'a_s_098fdd', 'false')
('a_s_56bd60', 'a_s_8024c8', 'G', 'false')
('a_s_56bd60', 'a_s_8024c8', 'O', 'true')
('a_s_56bd60', 'a_s_17f92f', 'a_s_098fdd', 'true')
('a_s_56bd60', 'A', 'a_s_098fdd', 'true')
('a_s_56bd60', 'exp_fcc4f6', 'a_s_098fdd', 'true')
('a', 'exp_fcc4f6', '@', 'false')
('B', 'exp_fcc4f6', 'D', 'false')
*/