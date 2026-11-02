-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_42d107', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_32bdb1', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_2a3ba9', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('D', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('P', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('C', -1980249628);

INSERT INTO "variables" ("name", "value") VALUES ('E', -734455130);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_42d107', 'a_s_29c107', 'a_s_32bdb1');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_29c107', 'a_s_32bdb1');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_42d107', 'a_s_29c107', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_42d107', 'a_s_8b311c', 'a_s_32bdb1');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_42d107', 'A', 'a_s_32bdb1');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_42d107', 'exp_fcc4f6', 'a_s_32bdb1');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('P', 'exp_fcc4f6', '`');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'exp_fcc4f6', 'E');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_42d107', 'a_s_29c107', 'a_s_32bdb1', 'false')
('G', 'a_s_29c107', 'a_s_32bdb1', 'false')
('a_s_42d107', 'a_s_29c107', 'G', 'false')
('a_s_42d107', 'a_s_8b311c', 'a_s_32bdb1', 'false')
('a_s_42d107', 'A', 'a_s_32bdb1', 'false')
('a_s_42d107', 'exp_fcc4f6', 'a_s_32bdb1', 'false')
('D', 'exp_fcc4f6', '@', 'false')
('P', 'exp_fcc4f6', '`', 'false')
('C', 'exp_fcc4f6', 'E', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' AND L.VALUE > R.VALUE THEN 'true' WHEN OPERATOR = '>' AND L.VALUE <= R.VALUE THEN 'false' WHEN OPERATOR = '<' AND L.VALUE >= R.VALUE THEN 'false' WHEN OPERATOR = '<' AND L.VALUE < R.VALUE THEN 'true' WHEN OPERATOR = '=' AND L.VALUE = R.VALUE THEN 'true' WHEN OPERATOR = '=' AND L.VALUE <> R.VALUE THEN 'false' END AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS L ON E.LEFT_OPERAND = L.NAME LEFT JOIN VARIABLES AS R ON E.RIGHT_OPERAND = R.NAME;

/*
Prediction Result:
('a_s_42d107', 'a_s_29c107', 'a_s_32bdb1', None)
('G', 'a_s_29c107', 'a_s_32bdb1', None)
('a_s_42d107', 'a_s_29c107', 'G', None)
('a_s_42d107', 'a_s_8b311c', 'a_s_32bdb1', None)
('a_s_42d107', 'A', 'a_s_32bdb1', None)
('a_s_42d107', 'exp_fcc4f6', 'a_s_32bdb1', None)
('D', 'exp_fcc4f6', '@', None)
('P', 'exp_fcc4f6', '`', None)
('C', 'exp_fcc4f6', 'E', None)
*/