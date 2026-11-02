-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_9a877d', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_d196e3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('_', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_2e985d', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('C', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('b', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9a877d', 'a_s_e601ef', 'a_s_d196e3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9a877d', '<', 'a_s_d196e3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_e601ef', 'a_s_d196e3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9a877d', 'a_s_e601ef', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9a877d', 'a_s_c17f01', 'a_s_d196e3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9a877d', 'A', 'a_s_d196e3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9a877d', 'exp_fcc4f6', 'a_s_d196e3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'B');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'exp_fcc4f6', 'b');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_9a877d', 'a_s_e601ef', 'a_s_d196e3', 'false')
('a_s_9a877d', '<', 'a_s_d196e3', 'false')
('A', 'a_s_e601ef', 'a_s_d196e3', 'false')
('a_s_9a877d', 'a_s_e601ef', 'A', 'false')
('a_s_9a877d', 'a_s_c17f01', 'a_s_d196e3', 'false')
('a_s_9a877d', 'A', 'a_s_d196e3', 'false')
('a_s_9a877d', 'exp_fcc4f6', 'a_s_d196e3', 'false')
('@', 'exp_fcc4f6', 'B', 'false')
('C', 'exp_fcc4f6', 'b', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE OPERATOR WHEN '>' THEN IIF(L.VALUE > R.VALUE, 'true', 'false') WHEN '=' THEN IIF(L.VALUE = R.VALUE, 'true', 'false') ELSE IIF(L.VALUE < R.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS L ON E.LEFT_OPERAND = L.NAME JOIN VARIABLES AS R ON E.RIGHT_OPERAND = R.NAME;

/*
Prediction Result:
('a_s_9a877d', 'a_s_e601ef', 'a_s_d196e3', 'false')
('a_s_9a877d', '<', 'a_s_d196e3', 'false')
('A', 'a_s_e601ef', 'a_s_d196e3', 'true')
('a_s_9a877d', 'a_s_e601ef', 'A', 'false')
('a_s_9a877d', 'a_s_c17f01', 'a_s_d196e3', 'false')
('a_s_9a877d', 'A', 'a_s_d196e3', 'false')
('a_s_9a877d', 'exp_fcc4f6', 'a_s_d196e3', 'false')
('@', 'exp_fcc4f6', 'B', 'false')
('C', 'exp_fcc4f6', 'b', 'true')
*/