-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_da8cff', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_5677c8', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('_', 1);

INSERT INTO "variables" ("name", "value") VALUES ('E', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_14b74e', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('M', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('e', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_da8cff', 'a_s_467ff0', 'a_s_5677c8');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_467ff0', 'a_s_5677c8');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_da8cff', 'a_s_467ff0', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_da8cff', 'a_s_460275', 'a_s_5677c8');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_da8cff', 'A', 'a_s_5677c8');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_da8cff', 'exp_fcc4f6', 'a_s_5677c8');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('M', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('e', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_da8cff', 'a_s_467ff0', 'a_s_5677c8', 'false')
('G', 'a_s_467ff0', 'a_s_5677c8', 'false')
('a_s_da8cff', 'a_s_467ff0', 'A', 'false')
('a_s_da8cff', 'a_s_460275', 'a_s_5677c8', 'false')
('a_s_da8cff', 'A', 'a_s_5677c8', 'false')
('a_s_da8cff', 'exp_fcc4f6', 'a_s_5677c8', 'false')
('M', 'exp_fcc4f6', '@', 'false')
('e', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '=' THEN (CASE WHEN (V1.VALUE = V2.VALUE) = 1 THEN 'true' ELSE 'false' END) WHEN OPERATOR = '>' THEN (CASE WHEN (V1.VALUE > V2.VALUE) = 1 THEN 'true' ELSE 'false' END) WHEN OPERATOR = '<' THEN (CASE WHEN (V1.VALUE < V2.VALUE) = 1 THEN 'true' ELSE 'false' END) END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS V1 ON V1.NAME = E.LEFT_OPERAND JOIN VARIABLES AS V2 ON V2.NAME = E.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_da8cff', 'a_s_467ff0', 'a_s_5677c8', None)
('G', 'a_s_467ff0', 'a_s_5677c8', None)
('a_s_da8cff', 'a_s_467ff0', 'A', None)
('a_s_da8cff', 'a_s_460275', 'a_s_5677c8', None)
('a_s_da8cff', 'A', 'a_s_5677c8', None)
('a_s_da8cff', 'exp_fcc4f6', 'a_s_5677c8', None)
('M', 'exp_fcc4f6', '@', None)
('e', 'exp_fcc4f6', 'B', None)
*/