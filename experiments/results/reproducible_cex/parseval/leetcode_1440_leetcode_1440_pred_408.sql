-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_d3a2d5', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_293f35', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_f78e10', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('C', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d3a2d5', 'a_s_6ef7a9', 'a_s_293f35');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d3a2d5', '<', 'a_s_293f35');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_6ef7a9', 'a_s_293f35');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d3a2d5', 'a_s_6ef7a9', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d3a2d5', 'a_s_6ef7a9', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d3a2d5', 'a_s_40ce61', 'a_s_293f35');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d3a2d5', 'A', 'a_s_293f35');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d3a2d5', 'exp_fcc4f6', 'a_s_293f35');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_d3a2d5', 'a_s_6ef7a9', 'a_s_293f35', 'false')
('a_s_d3a2d5', '<', 'a_s_293f35', 'false')
('A', 'a_s_6ef7a9', 'a_s_293f35', 'false')
('a_s_d3a2d5', 'a_s_6ef7a9', 'G', 'false')
('a_s_d3a2d5', 'a_s_6ef7a9', 'O', 'false')
('a_s_d3a2d5', 'a_s_40ce61', 'a_s_293f35', 'false')
('a_s_d3a2d5', 'A', 'a_s_293f35', 'false')
('a_s_d3a2d5', 'exp_fcc4f6', 'a_s_293f35', 'false')
('`', 'exp_fcc4f6', '@', 'false')
('C', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
WITH CTE AS (SELECT *, (CASE WHEN OPERATOR = '>' THEN ((SELECT VALUE FROM VARIABLES WHERE NAME = A.LEFT_OPERAND) > (SELECT VALUE FROM VARIABLES WHERE NAME = A.RIGHT_OPERAND)) WHEN OPERATOR = '<' THEN ((SELECT VALUE FROM VARIABLES WHERE NAME = A.LEFT_OPERAND) < (SELECT VALUE FROM VARIABLES WHERE NAME = A.RIGHT_OPERAND)) WHEN OPERATOR = '=' THEN ((SELECT VALUE FROM VARIABLES WHERE NAME = A.LEFT_OPERAND) = (SELECT VALUE FROM VARIABLES WHERE NAME = A.RIGHT_OPERAND)) END) AS VALUE FROM EXPRESSIONS AS A) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, (CASE WHEN VALUE = 0 THEN 'false' ELSE 'true' END) AS VALUE FROM CTE;

/*
Prediction Result:
('a_s_d3a2d5', 'a_s_6ef7a9', 'a_s_293f35', 'true')
('a_s_d3a2d5', '<', 'a_s_293f35', 'false')
('A', 'a_s_6ef7a9', 'a_s_293f35', 'true')
('a_s_d3a2d5', 'a_s_6ef7a9', 'G', 'true')
('a_s_d3a2d5', 'a_s_6ef7a9', 'O', 'true')
('a_s_d3a2d5', 'a_s_40ce61', 'a_s_293f35', 'true')
('a_s_d3a2d5', 'A', 'a_s_293f35', 'true')
('a_s_d3a2d5', 'exp_fcc4f6', 'a_s_293f35', 'true')
('`', 'exp_fcc4f6', '@', 'true')
('C', 'exp_fcc4f6', 'B', 'true')
*/