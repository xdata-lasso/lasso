-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_51580f', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_06b488', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('_', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_d337c9', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('Q', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('D', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_51580f', 'a_s_996fe1', 'a_s_06b488');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_996fe1', 'a_s_06b488');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_51580f', 'a_s_996fe1', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_51580f', 'a_s_62f889', 'a_s_06b488');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_51580f', 'A', 'a_s_06b488');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_51580f', 'exp_fcc4f6', 'a_s_06b488');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'Q');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_51580f', 'a_s_996fe1', 'a_s_06b488', 'false')
('A', 'a_s_996fe1', 'a_s_06b488', 'false')
('a_s_51580f', 'a_s_996fe1', 'A', 'false')
('a_s_51580f', 'a_s_62f889', 'a_s_06b488', 'false')
('a_s_51580f', 'A', 'a_s_06b488', 'false')
('a_s_51580f', 'exp_fcc4f6', 'a_s_06b488', 'false')
('@', 'exp_fcc4f6', 'Q', 'false')
('D', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, OPERATOR, E.RIGHT_OPERAND, CASE WHEN OPERATOR = '=' THEN IIF(V.VALUE = S.VALUE, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(V.VALUE > S.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(V.VALUE < S.VALUE, 'true', 'false') ELSE NULL END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS V ON E.LEFT_OPERAND = V.NAME JOIN VARIABLES AS S ON E.RIGHT_OPERAND = S.NAME;

/*
Prediction Result:
('a_s_51580f', 'a_s_996fe1', 'a_s_06b488', None)
('A', 'a_s_996fe1', 'a_s_06b488', None)
('a_s_51580f', 'a_s_996fe1', 'A', None)
('a_s_51580f', 'a_s_62f889', 'a_s_06b488', None)
('a_s_51580f', 'A', 'a_s_06b488', None)
('a_s_51580f', 'exp_fcc4f6', 'a_s_06b488', None)
('@', 'exp_fcc4f6', 'Q', None)
('D', 'exp_fcc4f6', 'B', None)
*/