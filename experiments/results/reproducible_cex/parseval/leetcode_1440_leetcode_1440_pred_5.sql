-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_233852', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_5ed36a', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('C', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('_', 1);

INSERT INTO "variables" ("name", "value") VALUES ('I', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_740711', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('!', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('B', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('H', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_233852', 'a_s_db9e05', 'a_s_5ed36a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'a_s_db9e05', 'a_s_5ed36a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_233852', 'a_s_db9e05', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('I', 'a_s_db9e05', 'a_s_5ed36a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_233852', 'a_s_6889e7', 'a_s_5ed36a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_233852', 'A', 'a_s_5ed36a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_233852', 'exp_fcc4f6', 'a_s_5ed36a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('!', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('H', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_233852', 'a_s_db9e05', 'a_s_5ed36a', 'false')
('C', 'a_s_db9e05', 'a_s_5ed36a', 'false')
('a_s_233852', 'a_s_db9e05', 'A', 'false')
('I', 'a_s_db9e05', 'a_s_5ed36a', 'false')
('a_s_233852', 'a_s_6889e7', 'a_s_5ed36a', 'false')
('a_s_233852', 'A', 'a_s_5ed36a', 'false')
('a_s_233852', 'exp_fcc4f6', 'a_s_5ed36a', 'false')
('!', 'exp_fcc4f6', '@', 'false')
('H', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT E.*, (CASE WHEN OPERATOR = '>' THEN (CASE WHEN V1.VALUE > V2.VALUE THEN 'true' ELSE 'false' END) WHEN OPERATOR = '<' THEN (CASE WHEN V1.VALUE < V2.VALUE THEN 'true' ELSE 'false' END) WHEN OPERATOR = '=' THEN (CASE WHEN V1.VALUE = V2.VALUE THEN 'true' ELSE 'false' END) END) AS VALUE FROM EXPRESSIONS AS E INNER JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME INNER JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_233852', 'a_s_db9e05', 'a_s_5ed36a', None)
('C', 'a_s_db9e05', 'a_s_5ed36a', None)
('a_s_233852', 'a_s_db9e05', 'A', None)
('I', 'a_s_db9e05', 'a_s_5ed36a', None)
('a_s_233852', 'a_s_6889e7', 'a_s_5ed36a', None)
('a_s_233852', 'A', 'a_s_5ed36a', None)
('a_s_233852', 'exp_fcc4f6', 'a_s_5ed36a', None)
('!', 'exp_fcc4f6', '@', None)
('H', 'exp_fcc4f6', 'B', None)
*/