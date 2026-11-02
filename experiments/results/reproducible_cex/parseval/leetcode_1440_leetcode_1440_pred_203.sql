-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_b2b202', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_8f495b', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('I', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_ac3e7d', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('E', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('H', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b2b202', 'a_s_c35992', 'a_s_8f495b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_c35992', 'a_s_8f495b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b2b202', 'a_s_c35992', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b2b202', 'a_s_2dc012', 'a_s_8f495b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b2b202', 'A', 'a_s_8f495b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b2b202', 'exp_fcc4f6', 'a_s_8f495b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('E', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', 'H');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_b2b202', 'a_s_c35992', 'a_s_8f495b', 'false')
('O', 'a_s_c35992', 'a_s_8f495b', 'false')
('a_s_b2b202', 'a_s_c35992', 'A', 'false')
('a_s_b2b202', 'a_s_2dc012', 'a_s_8f495b', 'false')
('a_s_b2b202', 'A', 'a_s_8f495b', 'false')
('a_s_b2b202', 'exp_fcc4f6', 'a_s_8f495b', 'false')
('E', 'exp_fcc4f6', '@', 'false')
('B', 'exp_fcc4f6', 'H', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, (CASE WHEN OPERATOR = '=' THEN IIF(V1.VALUE = V2.VALUE, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(V1.VALUE > V2.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(V1.VALUE < V2.VALUE, 'true', 'false') END) AS VALUE FROM EXPRESSIONS LEFT JOIN VARIABLES AS V1 ON V1.NAME = LEFT_OPERAND LEFT JOIN VARIABLES AS V2 ON V2.NAME = RIGHT_OPERAND;

/*
Prediction Result:
('a_s_b2b202', 'a_s_c35992', 'a_s_8f495b', None)
('O', 'a_s_c35992', 'a_s_8f495b', None)
('a_s_b2b202', 'a_s_c35992', 'A', None)
('a_s_b2b202', 'a_s_2dc012', 'a_s_8f495b', None)
('a_s_b2b202', 'A', 'a_s_8f495b', None)
('a_s_b2b202', 'exp_fcc4f6', 'a_s_8f495b', None)
('E', 'exp_fcc4f6', '@', None)
('B', 'exp_fcc4f6', 'H', None)
*/