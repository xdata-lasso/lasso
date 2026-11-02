-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_d5bdfd', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_4568f8', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('_', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_f92d1e', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('Q', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d5bdfd', 'a_s_3c61b6', 'a_s_4568f8');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d5bdfd', '<', 'a_s_4568f8');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_3c61b6', 'a_s_4568f8');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d5bdfd', 'a_s_3c61b6', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d5bdfd', 'a_s_f288d6', 'a_s_4568f8');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d5bdfd', 'A', 'a_s_4568f8');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d5bdfd', 'exp_fcc4f6', 'a_s_4568f8');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('Q', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_d5bdfd', 'a_s_3c61b6', 'a_s_4568f8', 'false')
('a_s_d5bdfd', '<', 'a_s_4568f8', 'false')
('A', 'a_s_3c61b6', 'a_s_4568f8', 'false')
('a_s_d5bdfd', 'a_s_3c61b6', 'A', 'false')
('a_s_d5bdfd', 'a_s_f288d6', 'a_s_4568f8', 'false')
('a_s_d5bdfd', 'A', 'a_s_4568f8', 'false')
('a_s_d5bdfd', 'exp_fcc4f6', 'a_s_4568f8', 'false')
('`', 'exp_fcc4f6', '@', 'false')
('Q', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, (CASE WHEN E.OPERATOR = '>' THEN IIF(V1.VALUE > V2.VALUE, 'true', 'false') WHEN E.OPERATOR = '=' THEN IIF(V1.VALUE = V2.VALUE, 'true', 'false') WHEN E.OPERATOR = '<' THEN IIF(V1.VALUE > V2.VALUE, 'true', 'false') END) AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS V1 ON V1.NAME = E.LEFT_OPERAND JOIN VARIABLES AS V2 ON V2.NAME = E.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_d5bdfd', 'a_s_3c61b6', 'a_s_4568f8', None)
('a_s_d5bdfd', '<', 'a_s_4568f8', 'false')
('A', 'a_s_3c61b6', 'a_s_4568f8', None)
('a_s_d5bdfd', 'a_s_3c61b6', 'A', None)
('a_s_d5bdfd', 'a_s_f288d6', 'a_s_4568f8', None)
('a_s_d5bdfd', 'A', 'a_s_4568f8', None)
('a_s_d5bdfd', 'exp_fcc4f6', 'a_s_4568f8', None)
('`', 'exp_fcc4f6', '@', None)
('Q', 'exp_fcc4f6', 'B', None)
*/