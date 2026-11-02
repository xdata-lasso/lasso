-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_0bd4fa', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_0687db', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('Q', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_a7a88d', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('E', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('C', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('B', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_0bd4fa', 'a_s_fe6b5f', 'a_s_0687db');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_0bd4fa', '<', 'a_s_0687db');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_fe6b5f', 'a_s_0687db');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_0bd4fa', 'a_s_fe6b5f', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_0bd4fa', 'a_s_8f7767', 'a_s_0687db');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_0bd4fa', 'A', 'a_s_0687db');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_0bd4fa', 'exp_fcc4f6', 'a_s_0687db');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'E');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_0bd4fa', 'a_s_fe6b5f', 'a_s_0687db', 'false')
('a_s_0bd4fa', '<', 'a_s_0687db', 'false')
('A', 'a_s_fe6b5f', 'a_s_0687db', 'false')
('a_s_0bd4fa', 'a_s_fe6b5f', 'A', 'false')
('a_s_0bd4fa', 'a_s_8f7767', 'a_s_0687db', 'false')
('a_s_0bd4fa', 'A', 'a_s_0687db', 'false')
('a_s_0bd4fa', 'exp_fcc4f6', 'a_s_0687db', 'false')
('@', 'exp_fcc4f6', 'E', 'false')
('B', 'exp_fcc4f6', 'C', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF((SELECT VALUE FROM VARIABLES WHERE NAME = LEFT_OPERAND) > (SELECT VALUE FROM VARIABLES WHERE NAME = RIGHT_OPERAND), 'true', 'false') WHEN OPERATOR = '<' THEN IIF((SELECT VALUE FROM VARIABLES WHERE NAME = LEFT_OPERAND) < (SELECT VALUE FROM VARIABLES WHERE NAME = RIGHT_OPERAND), 'true', 'false') ELSE IIF((SELECT VALUE FROM VARIABLES WHERE NAME = LEFT_OPERAND) = (SELECT VALUE FROM VARIABLES WHERE NAME = RIGHT_OPERAND), 'true', 'false') END AS VALUE FROM EXPRESSIONS;

/*
Prediction Result:
('a_s_0bd4fa', 'a_s_fe6b5f', 'a_s_0687db', 'true')
('a_s_0bd4fa', '<', 'a_s_0687db', 'false')
('A', 'a_s_fe6b5f', 'a_s_0687db', 'false')
('a_s_0bd4fa', 'a_s_fe6b5f', 'A', 'false')
('a_s_0bd4fa', 'a_s_8f7767', 'a_s_0687db', 'true')
('a_s_0bd4fa', 'A', 'a_s_0687db', 'true')
('a_s_0bd4fa', 'exp_fcc4f6', 'a_s_0687db', 'true')
('@', 'exp_fcc4f6', 'E', 'false')
('B', 'exp_fcc4f6', 'C', 'false')
*/