-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_e78a0f', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_971c68', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('Q', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('C', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_9be129', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('B', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e78a0f', 'a_s_02ea5c', 'a_s_971c68');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e78a0f', '<', 'a_s_971c68');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_02ea5c', 'a_s_971c68');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e78a0f', 'a_s_02ea5c', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('Q', 'a_s_02ea5c', 'a_s_971c68');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e78a0f', 'a_s_02ea5c', 'C');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e78a0f', 'a_s_0f90ee', 'a_s_971c68');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e78a0f', 'A', 'a_s_971c68');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e78a0f', 'exp_fcc4f6', 'a_s_971c68');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_e78a0f', 'a_s_02ea5c', 'a_s_971c68', 'false')
('a_s_e78a0f', '<', 'a_s_971c68', 'false')
('O', 'a_s_02ea5c', 'a_s_971c68', 'false')
('a_s_e78a0f', 'a_s_02ea5c', 'O', 'false')
('Q', 'a_s_02ea5c', 'a_s_971c68', 'false')
('a_s_e78a0f', 'a_s_02ea5c', 'C', 'false')
('a_s_e78a0f', 'a_s_0f90ee', 'a_s_971c68', 'false')
('a_s_e78a0f', 'A', 'a_s_971c68', 'false')
('a_s_e78a0f', 'exp_fcc4f6', 'a_s_971c68', 'false')
('@', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT E.*, CASE WHEN OPERATOR = '<' THEN IIF(V.VALUE < V2.VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(V.VALUE = V2.VALUE, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(V.VALUE > V2.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS V ON E.LEFT_OPERAND = V.NAME JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_e78a0f', 'a_s_02ea5c', 'a_s_971c68', None)
('a_s_e78a0f', '<', 'a_s_971c68', 'false')
('O', 'a_s_02ea5c', 'a_s_971c68', None)
('a_s_e78a0f', 'a_s_02ea5c', 'O', None)
('Q', 'a_s_02ea5c', 'a_s_971c68', None)
('a_s_e78a0f', 'a_s_02ea5c', 'C', None)
('a_s_e78a0f', 'a_s_0f90ee', 'a_s_971c68', None)
('a_s_e78a0f', 'A', 'a_s_971c68', None)
('a_s_e78a0f', 'exp_fcc4f6', 'a_s_971c68', None)
('@', 'exp_fcc4f6', 'B', None)
*/