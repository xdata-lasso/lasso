-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_87f059', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_c71af9', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('I', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('G', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_e8ed34', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('H', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('@', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('i', -1980249628);

INSERT INTO "variables" ("name", "value") VALUES ('B', -734455130);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_87f059', 'a_s_47a592', 'a_s_c71af9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_87f059', '<', 'a_s_c71af9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_47a592', 'a_s_c71af9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_87f059', 'a_s_47a592', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_87f059', 'a_s_47a592', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_87f059', 'a_s_c0b181', 'a_s_c71af9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_87f059', 'A', 'a_s_c71af9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_87f059', 'exp_fcc4f6', 'a_s_c71af9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'H');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', 'i');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_87f059', 'a_s_47a592', 'a_s_c71af9', 'false')
('a_s_87f059', '<', 'a_s_c71af9', 'false')
('A', 'a_s_47a592', 'a_s_c71af9', 'false')
('a_s_87f059', 'a_s_47a592', 'O', 'false')
('a_s_87f059', 'a_s_47a592', 'G', 'false')
('a_s_87f059', 'a_s_c0b181', 'a_s_c71af9', 'false')
('a_s_87f059', 'A', 'a_s_c71af9', 'false')
('a_s_87f059', 'exp_fcc4f6', 'a_s_c71af9', 'false')
('@', 'exp_fcc4f6', 'H', 'false')
('B', 'exp_fcc4f6', 'i', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(V.VALUE > V1.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(V.VALUE < V1.VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(V.VALUE = V1.VALUE, 'true', 'false') END AS VALUE FROM VARIABLES AS V JOIN EXPRESSIONS AS E ON V.NAME = E.LEFT_OPERAND JOIN VARIABLES AS V1 ON V1.NAME = E.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_87f059', 'a_s_47a592', 'a_s_c71af9', None)
('a_s_87f059', '<', 'a_s_c71af9', 'false')
('A', 'a_s_47a592', 'a_s_c71af9', None)
('a_s_87f059', 'a_s_47a592', 'O', None)
('a_s_87f059', 'a_s_47a592', 'G', None)
('a_s_87f059', 'a_s_c0b181', 'a_s_c71af9', None)
('a_s_87f059', 'A', 'a_s_c71af9', None)
('a_s_87f059', 'exp_fcc4f6', 'a_s_c71af9', None)
('@', 'exp_fcc4f6', 'H', None)
('B', 'exp_fcc4f6', 'i', None)
*/