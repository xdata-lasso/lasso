-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_4947f9', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_0185d1', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('C', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_59edc1', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('Q', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('I', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_4947f9', 'a_s_655208', 'a_s_0185d1');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_655208', 'a_s_0185d1');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_4947f9', 'a_s_655208', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_4947f9', 'a_s_991fd7', 'a_s_0185d1');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_4947f9', 'A', 'a_s_0185d1');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('Q', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_4947f9', 'exp_fcc4f6', 'a_s_0185d1');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', 'I');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_4947f9', 'a_s_655208', 'a_s_0185d1', 'false')
('A', 'a_s_655208', 'a_s_0185d1', 'false')
('a_s_4947f9', 'a_s_655208', 'O', 'false')
('a_s_4947f9', 'a_s_991fd7', 'a_s_0185d1', 'false')
('a_s_4947f9', 'A', 'a_s_0185d1', 'false')
('Q', 'exp_fcc4f6', '@', 'false')
('a_s_4947f9', 'exp_fcc4f6', 'a_s_0185d1', 'false')
('B', 'exp_fcc4f6', 'I', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN E.OPERATOR = '=' THEN IIF(LEFT_V.VALUE = RIGHT_V.VALUE, 'true', 'false') WHEN E.OPERATOR = '<' THEN IIF(LEFT_V.VALUE < RIGHT_V.VALUE, 'true', 'false') WHEN E.OPERATOR = '>' THEN IIF(LEFT_V.VALUE > RIGHT_V.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS LEFT_V ON E.LEFT_OPERAND = LEFT_V.NAME JOIN VARIABLES AS RIGHT_V ON E.RIGHT_OPERAND = RIGHT_V.NAME;

/*
Prediction Result:
('a_s_4947f9', 'a_s_655208', 'a_s_0185d1', None)
('A', 'a_s_655208', 'a_s_0185d1', None)
('a_s_4947f9', 'a_s_655208', 'O', None)
('a_s_4947f9', 'a_s_991fd7', 'a_s_0185d1', None)
('a_s_4947f9', 'A', 'a_s_0185d1', None)
('Q', 'exp_fcc4f6', '@', None)
('a_s_4947f9', 'exp_fcc4f6', 'a_s_0185d1', None)
('B', 'exp_fcc4f6', 'I', None)
*/