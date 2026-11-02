-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_d15dbd', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_4a7b03', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('?', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('Q', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_6d9876', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('D', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d15dbd', 'a_s_0c4687', 'a_s_4a7b03');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d15dbd', '<', 'a_s_4a7b03');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_0c4687', 'a_s_4a7b03');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d15dbd', 'a_s_0c4687', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('?', 'a_s_0c4687', 'a_s_4a7b03');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d15dbd', 'a_s_c0b0e5', 'a_s_4a7b03');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d15dbd', 'A', 'a_s_4a7b03');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d15dbd', 'exp_fcc4f6', 'a_s_4a7b03');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', '@');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_d15dbd', 'a_s_0c4687', 'a_s_4a7b03', 'false')
('a_s_d15dbd', '<', 'a_s_4a7b03', 'false')
('O', 'a_s_0c4687', 'a_s_4a7b03', 'false')
('a_s_d15dbd', 'a_s_0c4687', 'A', 'false')
('?', 'a_s_0c4687', 'a_s_4a7b03', 'false')
('a_s_d15dbd', 'a_s_c0b0e5', 'a_s_4a7b03', 'false')
('a_s_d15dbd', 'A', 'a_s_4a7b03', 'false')
('a_s_d15dbd', 'exp_fcc4f6', 'a_s_4a7b03', 'false')
('D', 'exp_fcc4f6', '@', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN V1.VALUE > V2.VALUE AND OPERATOR = '>' THEN 'true' WHEN V1.VALUE <= V2.VALUE AND OPERATOR = '>' THEN 'false' WHEN V1.VALUE < V2.VALUE AND OPERATOR = '<' THEN 'true' WHEN V1.VALUE >= V2.VALUE AND OPERATOR = '<' THEN 'false' WHEN V1.VALUE = V2.VALUE AND OPERATOR = '=' THEN 'true' WHEN V1.VALUE <> V2.VALUE AND OPERATOR = '=' THEN 'false' END AS VALUE FROM EXPRESSIONS JOIN VARIABLES AS V1 ON LEFT_OPERAND = V1.NAME JOIN VARIABLES AS V2 ON RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_d15dbd', 'a_s_0c4687', 'a_s_4a7b03', None)
('a_s_d15dbd', '<', 'a_s_4a7b03', 'false')
('O', 'a_s_0c4687', 'a_s_4a7b03', None)
('a_s_d15dbd', 'a_s_0c4687', 'A', None)
('?', 'a_s_0c4687', 'a_s_4a7b03', None)
('a_s_d15dbd', 'a_s_c0b0e5', 'a_s_4a7b03', None)
('a_s_d15dbd', 'A', 'a_s_4a7b03', None)
('a_s_d15dbd', 'exp_fcc4f6', 'a_s_4a7b03', None)
('D', 'exp_fcc4f6', '@', None)
*/