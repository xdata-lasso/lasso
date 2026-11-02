-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_826e83', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_3ebffd', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('_', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_3112bb', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('B', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_826e83', 'a_s_8f8238', 'a_s_3ebffd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_826e83', '<', 'a_s_3ebffd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_8f8238', 'a_s_3ebffd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_826e83', 'a_s_8f8238', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_8f8238', 'a_s_3ebffd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_826e83', 'a_s_8f8238', '_');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_826e83', 'a_s_0eddef', 'a_s_3ebffd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_826e83', 'A', 'a_s_3ebffd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_826e83', 'exp_fcc4f6', 'a_s_3ebffd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_826e83', 'a_s_8f8238', 'a_s_3ebffd', 'false')
('a_s_826e83', '<', 'a_s_3ebffd', 'false')
('G', 'a_s_8f8238', 'a_s_3ebffd', 'false')
('a_s_826e83', 'a_s_8f8238', 'O', 'false')
('O', 'a_s_8f8238', 'a_s_3ebffd', 'false')
('a_s_826e83', 'a_s_8f8238', '_', 'false')
('a_s_826e83', 'a_s_0eddef', 'a_s_3ebffd', 'false')
('a_s_826e83', 'A', 'a_s_3ebffd', 'false')
('a_s_826e83', 'exp_fcc4f6', 'a_s_3ebffd', 'false')
('B', 'exp_fcc4f6', '@', 'false')
*/

-- Prediction Query
WITH CONV_TABLE AS (SELECT V1.VALUE AS LEFT_VAL, OPERATOR, V2.VALUE AS RIGHT_VAL, LEFT_OPERAND, RIGHT_OPERAND FROM EXPRESSIONS JOIN VARIABLES AS V1 ON V1.NAME = LEFT_OPERAND JOIN VARIABLES AS V2 ON V2.NAME = RIGHT_OPERAND) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(LEFT_VAL > RIGHT_VAL, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(RIGHT_VAL > LEFT_VAL, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(RIGHT_VAL = LEFT_VAL, 'true', 'false') END AS VALUE FROM CONV_TABLE;

/*
Prediction Result:
('a_s_826e83', 'a_s_8f8238', 'a_s_3ebffd', None)
('a_s_826e83', '<', 'a_s_3ebffd', 'false')
('G', 'a_s_8f8238', 'a_s_3ebffd', None)
('a_s_826e83', 'a_s_8f8238', 'O', None)
('O', 'a_s_8f8238', 'a_s_3ebffd', None)
('a_s_826e83', 'a_s_8f8238', '_', None)
('a_s_826e83', 'a_s_0eddef', 'a_s_3ebffd', None)
('a_s_826e83', 'A', 'a_s_3ebffd', None)
('a_s_826e83', 'exp_fcc4f6', 'a_s_3ebffd', None)
('B', 'exp_fcc4f6', '@', None)
*/