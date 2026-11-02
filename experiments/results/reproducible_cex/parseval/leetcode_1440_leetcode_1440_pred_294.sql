-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_6da52f', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_cd3f4c', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('I', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_009b79', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('E', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('Y', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6da52f', 'a_s_6d5ad0', 'a_s_cd3f4c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6da52f', '<', 'a_s_cd3f4c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_6d5ad0', 'a_s_cd3f4c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6da52f', 'a_s_6d5ad0', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6da52f', 'a_s_b2877e', 'a_s_cd3f4c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6da52f', 'A', 'a_s_cd3f4c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6da52f', 'exp_fcc4f6', 'a_s_cd3f4c');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'E');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('Y', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_6da52f', 'a_s_6d5ad0', 'a_s_cd3f4c', 'false')
('a_s_6da52f', '<', 'a_s_cd3f4c', 'false')
('A', 'a_s_6d5ad0', 'a_s_cd3f4c', 'false')
('a_s_6da52f', 'a_s_6d5ad0', 'A', 'false')
('a_s_6da52f', 'a_s_b2877e', 'a_s_cd3f4c', 'false')
('a_s_6da52f', 'A', 'a_s_cd3f4c', 'false')
('a_s_6da52f', 'exp_fcc4f6', 'a_s_cd3f4c', 'false')
('@', 'exp_fcc4f6', 'E', 'false')
('Y', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN CASE WHEN V_LEFT.VALUE > V_RIGHT.VALUE THEN 'true' ELSE 'false' END WHEN OPERATOR = '<' THEN CASE WHEN V_LEFT.VALUE < V_RIGHT.VALUE THEN 'true' ELSE 'false' END ELSE CASE WHEN V_LEFT.VALUE = V_RIGHT.VALUE THEN 'true' ELSE 'false' END END AS VALUE FROM EXPRESSIONS AS E INNER JOIN VARIABLES AS V_LEFT ON TRUE INNER JOIN VARIABLES AS V_RIGHT ON E.LEFT_OPERAND = V_LEFT.NAME AND E.RIGHT_OPERAND = V_RIGHT.NAME;

/*
Prediction Result:
('a_s_6da52f', 'a_s_6d5ad0', 'a_s_cd3f4c', 'true')
('a_s_6da52f', '<', 'a_s_cd3f4c', 'false')
('A', 'a_s_6d5ad0', 'a_s_cd3f4c', 'false')
('a_s_6da52f', 'a_s_6d5ad0', 'A', 'false')
('a_s_6da52f', 'a_s_b2877e', 'a_s_cd3f4c', 'true')
('a_s_6da52f', 'A', 'a_s_cd3f4c', 'true')
('a_s_6da52f', 'exp_fcc4f6', 'a_s_cd3f4c', 'true')
('@', 'exp_fcc4f6', 'E', 'false')
('Y', 'exp_fcc4f6', '`', 'false')
*/