-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_7fe7f4', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_99291e', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('I', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_2bdaa9', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('E', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('Q', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_7fe7f4', 'a_s_0bdddc', 'a_s_99291e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_7fe7f4', '<', 'a_s_99291e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_0bdddc', 'a_s_99291e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_7fe7f4', 'a_s_0bdddc', 'I');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_7fe7f4', 'a_s_0bdddc', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_7fe7f4', 'a_s_50582e', 'a_s_99291e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_7fe7f4', 'A', 'a_s_99291e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_7fe7f4', 'exp_fcc4f6', 'a_s_99291e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'E');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'Q');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_7fe7f4', 'a_s_0bdddc', 'a_s_99291e', 'false')
('a_s_7fe7f4', '<', 'a_s_99291e', 'false')
('A', 'a_s_0bdddc', 'a_s_99291e', 'false')
('a_s_7fe7f4', 'a_s_0bdddc', 'I', 'false')
('a_s_7fe7f4', 'a_s_0bdddc', 'O', 'false')
('a_s_7fe7f4', 'a_s_50582e', 'a_s_99291e', 'false')
('a_s_7fe7f4', 'A', 'a_s_99291e', 'false')
('a_s_7fe7f4', 'exp_fcc4f6', 'a_s_99291e', 'false')
('@', 'exp_fcc4f6', 'E', 'false')
('`', 'exp_fcc4f6', 'Q', 'false')
*/

-- Prediction Query
WITH CTE1 AS (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, V1.VALUE AS LEFT_VALUE, V2.VALUE AS RIGHT_VALUE FROM EXPRESSIONS LEFT JOIN VARIABLES AS V1 ON EXPRESSIONS.LEFT_OPERAND = V1.NAME LEFT JOIN VARIABLES AS V2 ON EXPRESSIONS.RIGHT_OPERAND = V2.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE OPERATOR WHEN '>' THEN IIF(LEFT_VALUE > RIGHT_VALUE, 'true', 'false') WHEN '<' THEN IIF(LEFT_VALUE < RIGHT_VALUE, 'true', 'false') WHEN '=' THEN IIF(LEFT_VALUE = RIGHT_VALUE, 'true', 'false') END AS VALUE FROM CTE1;

/*
Prediction Result:
('a_s_7fe7f4', 'a_s_0bdddc', 'a_s_99291e', None)
('a_s_7fe7f4', '<', 'a_s_99291e', 'false')
('A', 'a_s_0bdddc', 'a_s_99291e', None)
('a_s_7fe7f4', 'a_s_0bdddc', 'I', None)
('a_s_7fe7f4', 'a_s_0bdddc', 'O', None)
('a_s_7fe7f4', 'a_s_50582e', 'a_s_99291e', None)
('a_s_7fe7f4', 'A', 'a_s_99291e', None)
('a_s_7fe7f4', 'exp_fcc4f6', 'a_s_99291e', None)
('@', 'exp_fcc4f6', 'E', None)
('`', 'exp_fcc4f6', 'Q', None)
*/