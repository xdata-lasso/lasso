-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_924295', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_307aaf', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_a41108', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('C', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('H', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_924295', 'a_s_410180', 'a_s_307aaf');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_924295', '<', 'a_s_307aaf');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_410180', 'a_s_307aaf');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_924295', 'a_s_410180', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_924295', 'a_s_c731d1', 'a_s_307aaf');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_924295', 'A', 'a_s_307aaf');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_924295', 'exp_fcc4f6', 'a_s_307aaf');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('H', 'exp_fcc4f6', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_924295', 'a_s_410180', 'a_s_307aaf', 'false')
('a_s_924295', '<', 'a_s_307aaf', 'false')
('A', 'a_s_410180', 'a_s_307aaf', 'false')
('a_s_924295', 'a_s_410180', 'A', 'false')
('a_s_924295', 'a_s_c731d1', 'a_s_307aaf', 'false')
('a_s_924295', 'A', 'a_s_307aaf', 'false')
('a_s_924295', 'exp_fcc4f6', 'a_s_307aaf', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('H', 'exp_fcc4f6', 'C', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN E.OPERATOR = '=' THEN IIF(V.VALUE = VR.VALUE, 'true', 'false') WHEN E.OPERATOR = '>' THEN IIF(V.VALUE > VR.VALUE, 'true', 'false') WHEN E.OPERATOR = '<' THEN IIF(V.VALUE < VR.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS V ON V.NAME = E.LEFT_OPERAND JOIN VARIABLES AS VR ON VR.NAME = E.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_924295', 'a_s_410180', 'a_s_307aaf', None)
('a_s_924295', '<', 'a_s_307aaf', 'false')
('A', 'a_s_410180', 'a_s_307aaf', None)
('a_s_924295', 'a_s_410180', 'A', None)
('a_s_924295', 'a_s_c731d1', 'a_s_307aaf', None)
('a_s_924295', 'A', 'a_s_307aaf', None)
('a_s_924295', 'exp_fcc4f6', 'a_s_307aaf', None)
('B', 'exp_fcc4f6', '@', None)
('H', 'exp_fcc4f6', 'C', None)
*/