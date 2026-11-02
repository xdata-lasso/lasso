-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_4334e5', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_2bc40c', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('Q', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_ee9b00', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('B', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('C', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('b', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_4334e5', 'a_s_ce428b', 'a_s_2bc40c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_ce428b', 'a_s_2bc40c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_4334e5', 'a_s_ce428b', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_4334e5', 'a_s_957f9c', 'a_s_2bc40c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_4334e5', 'A', 'a_s_2bc40c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_4334e5', 'exp_fcc4f6', 'a_s_2bc40c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'exp_fcc4f6', 'b');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_4334e5', 'a_s_ce428b', 'a_s_2bc40c', 'false')
('A', 'a_s_ce428b', 'a_s_2bc40c', 'false')
('a_s_4334e5', 'a_s_ce428b', 'A', 'false')
('a_s_4334e5', 'a_s_957f9c', 'a_s_2bc40c', 'false')
('a_s_4334e5', 'A', 'a_s_2bc40c', 'false')
('a_s_4334e5', 'exp_fcc4f6', 'a_s_2bc40c', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('C', 'exp_fcc4f6', 'b', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN E.OPERATOR = '<' THEN IIF(V1.VALUE < V2.VALUE, 'true', 'false') WHEN E.OPERATOR = '>' THEN IIF(V1.VALUE > V2.VALUE, 'true', 'false') ELSE IIF(V1.VALUE = V2.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS V1 ON V1.NAME = E.LEFT_OPERAND JOIN VARIABLES AS V2 ON V2.NAME = E.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_4334e5', 'a_s_ce428b', 'a_s_2bc40c', 'true')
('A', 'a_s_ce428b', 'a_s_2bc40c', 'false')
('a_s_4334e5', 'a_s_ce428b', 'A', 'false')
('a_s_4334e5', 'a_s_957f9c', 'a_s_2bc40c', 'true')
('a_s_4334e5', 'A', 'a_s_2bc40c', 'true')
('a_s_4334e5', 'exp_fcc4f6', 'a_s_2bc40c', 'true')
('B', 'exp_fcc4f6', '@', 'false')
('C', 'exp_fcc4f6', 'b', 'false')
*/