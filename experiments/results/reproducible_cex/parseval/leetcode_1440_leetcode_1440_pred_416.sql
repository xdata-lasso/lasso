-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_43d53a', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_6433cb', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_a1f396', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('I', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('C', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_43d53a', 'a_s_5d994d', 'a_s_6433cb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_43d53a', '<', 'a_s_6433cb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_5d994d', 'a_s_6433cb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_43d53a', 'a_s_5d994d', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_43d53a', 'a_s_d0f104', 'a_s_6433cb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_43d53a', 'A', 'a_s_6433cb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_43d53a', 'exp_fcc4f6', 'a_s_6433cb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('I', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_43d53a', 'a_s_5d994d', 'a_s_6433cb', 'false')
('a_s_43d53a', '<', 'a_s_6433cb', 'false')
('A', 'a_s_5d994d', 'a_s_6433cb', 'false')
('a_s_43d53a', 'a_s_5d994d', 'A', 'false')
('a_s_43d53a', 'a_s_d0f104', 'a_s_6433cb', 'false')
('a_s_43d53a', 'A', 'a_s_6433cb', 'false')
('a_s_43d53a', 'exp_fcc4f6', 'a_s_6433cb', 'false')
('I', 'exp_fcc4f6', '@', 'false')
('C', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, (CASE WHEN OPERATOR = '>' THEN IIF(V1.VALUE > V2.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(V1.VALUE < V2.VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(V1.VALUE = V2.VALUE, 'true', 'false') END) AS VALUE FROM VARIABLES AS V1 INNER JOIN EXPRESSIONS AS E ON V1.NAME = E.LEFT_OPERAND INNER JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_43d53a', 'a_s_5d994d', 'a_s_6433cb', None)
('a_s_43d53a', '<', 'a_s_6433cb', 'false')
('A', 'a_s_5d994d', 'a_s_6433cb', None)
('a_s_43d53a', 'a_s_5d994d', 'A', None)
('a_s_43d53a', 'a_s_d0f104', 'a_s_6433cb', None)
('a_s_43d53a', 'A', 'a_s_6433cb', None)
('a_s_43d53a', 'exp_fcc4f6', 'a_s_6433cb', None)
('I', 'exp_fcc4f6', '@', None)
('C', 'exp_fcc4f6', '`', None)
*/