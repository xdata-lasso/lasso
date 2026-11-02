-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_e0fa13', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_acee97', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('I', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_b3744b', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('`', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('a', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('C', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e0fa13', 'a_s_349da9', 'a_s_acee97');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e0fa13', '<', 'a_s_acee97');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_349da9', 'a_s_acee97');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e0fa13', 'a_s_349da9', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e0fa13', 'a_s_147131', 'a_s_acee97');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e0fa13', 'A', 'a_s_acee97');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e0fa13', 'exp_fcc4f6', 'a_s_acee97');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a', 'exp_fcc4f6', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_e0fa13', 'a_s_349da9', 'a_s_acee97', 'false')
('a_s_e0fa13', '<', 'a_s_acee97', 'false')
('G', 'a_s_349da9', 'a_s_acee97', 'false')
('a_s_e0fa13', 'a_s_349da9', 'A', 'false')
('a_s_e0fa13', 'a_s_147131', 'a_s_acee97', 'false')
('a_s_e0fa13', 'A', 'a_s_acee97', 'false')
('a_s_e0fa13', 'exp_fcc4f6', 'a_s_acee97', 'false')
('`', 'exp_fcc4f6', '@', 'false')
('a', 'exp_fcc4f6', 'C', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(V.VALUE > V2.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(V.VALUE < V2.VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(V.VALUE = V2.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS V ON E.LEFT_OPERAND = V.NAME JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_e0fa13', 'a_s_349da9', 'a_s_acee97', None)
('a_s_e0fa13', '<', 'a_s_acee97', 'false')
('G', 'a_s_349da9', 'a_s_acee97', None)
('a_s_e0fa13', 'a_s_349da9', 'A', None)
('a_s_e0fa13', 'a_s_147131', 'a_s_acee97', None)
('a_s_e0fa13', 'A', 'a_s_acee97', None)
('a_s_e0fa13', 'exp_fcc4f6', 'a_s_acee97', None)
('`', 'exp_fcc4f6', '@', None)
('a', 'exp_fcc4f6', 'C', None)
*/