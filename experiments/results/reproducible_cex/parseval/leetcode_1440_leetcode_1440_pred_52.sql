-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_184cb6', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_7a4aaa', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_b4af4a', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('H', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_184cb6', 'a_s_1b8482', 'a_s_7a4aaa');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_1b8482', 'a_s_7a4aaa');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_184cb6', 'a_s_1b8482', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_184cb6', 'a_s_360641', 'a_s_7a4aaa');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_184cb6', 'A', 'a_s_7a4aaa');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_184cb6', 'exp_fcc4f6', 'a_s_7a4aaa');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'H');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_184cb6', 'a_s_1b8482', 'a_s_7a4aaa', 'false')
('O', 'a_s_1b8482', 'a_s_7a4aaa', 'false')
('a_s_184cb6', 'a_s_1b8482', 'A', 'false')
('a_s_184cb6', 'a_s_360641', 'a_s_7a4aaa', 'false')
('a_s_184cb6', 'A', 'a_s_7a4aaa', 'false')
('a_s_184cb6', 'exp_fcc4f6', 'a_s_7a4aaa', 'false')
('@', 'exp_fcc4f6', 'H', 'false')
('B', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '=' THEN IIF(V1.VALUE = V2.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(V1.VALUE < V2.VALUE, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(V1.VALUE > V2.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_184cb6', 'a_s_1b8482', 'a_s_7a4aaa', None)
('O', 'a_s_1b8482', 'a_s_7a4aaa', None)
('a_s_184cb6', 'a_s_1b8482', 'A', None)
('a_s_184cb6', 'a_s_360641', 'a_s_7a4aaa', None)
('a_s_184cb6', 'A', 'a_s_7a4aaa', None)
('a_s_184cb6', 'exp_fcc4f6', 'a_s_7a4aaa', None)
('@', 'exp_fcc4f6', 'H', None)
('B', 'exp_fcc4f6', '`', None)
*/