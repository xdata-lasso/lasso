-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_9ab341', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_766f23', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_8c7f1e', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('C', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('B', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9ab341', 'a_s_07dbbf', 'a_s_766f23');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9ab341', '<', 'a_s_766f23');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_07dbbf', 'a_s_766f23');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9ab341', 'a_s_07dbbf', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9ab341', 'a_s_d10b35', 'a_s_766f23');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9ab341', 'A', 'a_s_766f23');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9ab341', 'exp_fcc4f6', 'a_s_766f23');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'C');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', 'E');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_9ab341', 'a_s_07dbbf', 'a_s_766f23', 'false')
('a_s_9ab341', '<', 'a_s_766f23', 'false')
('A', 'a_s_07dbbf', 'a_s_766f23', 'false')
('a_s_9ab341', 'a_s_07dbbf', 'G', 'false')
('a_s_9ab341', 'a_s_d10b35', 'a_s_766f23', 'false')
('a_s_9ab341', 'A', 'a_s_766f23', 'false')
('a_s_9ab341', 'exp_fcc4f6', 'a_s_766f23', 'false')
('@', 'exp_fcc4f6', 'C', 'false')
('B', 'exp_fcc4f6', 'E', 'false')
*/

-- Prediction Query
WITH CTE1 AS (SELECT LEFT_OPERAND, V.VALUE AS VALUE1, OPERATOR, RIGHT_OPERAND FROM EXPRESSIONS LEFT JOIN VARIABLES AS V ON EXPRESSIONS.LEFT_OPERAND = V.NAME), CTE2 AS (SELECT LEFT_OPERAND, VALUE1, OPERATOR, RIGHT_OPERAND, V.VALUE AS VALUE2 FROM CTE1 LEFT JOIN VARIABLES AS V ON CTE1.RIGHT_OPERAND = V.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(VALUE1 > VALUE2, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(VALUE1 < VALUE2, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(VALUE1 = VALUE2, 'true', 'false') END AS VALUE FROM CTE2;

/*
Prediction Result:
('a_s_9ab341', 'a_s_07dbbf', 'a_s_766f23', None)
('a_s_9ab341', '<', 'a_s_766f23', 'false')
('A', 'a_s_07dbbf', 'a_s_766f23', None)
('a_s_9ab341', 'a_s_07dbbf', 'G', None)
('a_s_9ab341', 'a_s_d10b35', 'a_s_766f23', None)
('a_s_9ab341', 'A', 'a_s_766f23', None)
('a_s_9ab341', 'exp_fcc4f6', 'a_s_766f23', None)
('@', 'exp_fcc4f6', 'C', None)
('B', 'exp_fcc4f6', 'E', None)
*/