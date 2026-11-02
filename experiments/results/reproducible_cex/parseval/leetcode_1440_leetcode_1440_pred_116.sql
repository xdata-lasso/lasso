-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_3b2176', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_0c9d48', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('I', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_422b0a', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('C', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('a', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_3b2176', 'a_s_8ad611', 'a_s_0c9d48');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('I', 'a_s_8ad611', 'a_s_0c9d48');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_3b2176', 'a_s_8ad611', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_8ad611', 'a_s_0c9d48');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_3b2176', 'a_s_0b985a', 'a_s_0c9d48');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_3b2176', 'A', 'a_s_0c9d48');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_3b2176', 'exp_fcc4f6', 'a_s_0c9d48');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a', 'exp_fcc4f6', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_3b2176', 'a_s_8ad611', 'a_s_0c9d48', 'false')
('I', 'a_s_8ad611', 'a_s_0c9d48', 'false')
('a_s_3b2176', 'a_s_8ad611', 'A', 'false')
('O', 'a_s_8ad611', 'a_s_0c9d48', 'false')
('a_s_3b2176', 'a_s_0b985a', 'a_s_0c9d48', 'false')
('a_s_3b2176', 'A', 'a_s_0c9d48', 'false')
('a_s_3b2176', 'exp_fcc4f6', 'a_s_0c9d48', 'false')
('`', 'exp_fcc4f6', '@', 'false')
('a', 'exp_fcc4f6', 'C', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, IIF(E.OPERATOR = '>', IIF(V.VALUE > V2.VALUE, 'true', 'false'), IIF(E.OPERATOR = '<', IIF(V.VALUE < V2.VALUE, 'true', 'false'), IIF(V.VALUE = V2.VALUE, 'true', 'false'))) AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V ON E.LEFT_OPERAND = V.NAME LEFT JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_3b2176', 'a_s_8ad611', 'a_s_0c9d48', 'true')
('I', 'a_s_8ad611', 'a_s_0c9d48', 'false')
('a_s_3b2176', 'a_s_8ad611', 'A', 'true')
('O', 'a_s_8ad611', 'a_s_0c9d48', 'false')
('a_s_3b2176', 'a_s_0b985a', 'a_s_0c9d48', 'true')
('a_s_3b2176', 'A', 'a_s_0c9d48', 'true')
('a_s_3b2176', 'exp_fcc4f6', 'a_s_0c9d48', 'true')
('`', 'exp_fcc4f6', '@', 'false')
('a', 'exp_fcc4f6', 'C', 'false')
*/