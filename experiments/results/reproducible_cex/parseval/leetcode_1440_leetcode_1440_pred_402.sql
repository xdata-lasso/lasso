-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_c52216', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_2a84ae', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_2a7890', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('B', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('H', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c52216', 'a_s_4018f7', 'a_s_2a84ae');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c52216', '<', 'a_s_2a84ae');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_4018f7', 'a_s_2a84ae');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c52216', 'a_s_4018f7', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c52216', 'a_s_b8a570', 'a_s_2a84ae');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c52216', 'A', 'a_s_2a84ae');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c52216', 'exp_fcc4f6', 'a_s_2a84ae');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'H');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_c52216', 'a_s_4018f7', 'a_s_2a84ae', 'false')
('a_s_c52216', '<', 'a_s_2a84ae', 'false')
('A', 'a_s_4018f7', 'a_s_2a84ae', 'false')
('a_s_c52216', 'a_s_4018f7', 'A', 'false')
('a_s_c52216', 'a_s_b8a570', 'a_s_2a84ae', 'false')
('a_s_c52216', 'A', 'a_s_2a84ae', 'false')
('a_s_c52216', 'exp_fcc4f6', 'a_s_2a84ae', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('`', 'exp_fcc4f6', 'H', 'false')
*/

-- Prediction Query
WITH CTE AS (SELECT E.*, V1.VALUE AS LEFT_VALUE, V2.VALUE AS RIGHT_VALUE FROM EXPRESSIONS AS E INNER JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME INNER JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '=' THEN IIF(LEFT_VALUE = RIGHT_VALUE, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(LEFT_VALUE > RIGHT_VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(LEFT_VALUE < RIGHT_VALUE, 'true', 'false') END AS VALUE FROM CTE ORDER BY 1, 2, LEFT_OPERAND NULLS LAST, OPERATOR NULLS LAST, RIGHT_OPERAND NULLS LAST, VALUE NULLS LAST;

/*
Prediction Result:
('A', 'a_s_4018f7', 'a_s_2a84ae', None)
('B', 'exp_fcc4f6', '@', None)
('`', 'exp_fcc4f6', 'H', None)
('a_s_c52216', '<', 'a_s_2a84ae', 'false')
('a_s_c52216', 'A', 'a_s_2a84ae', None)
('a_s_c52216', 'a_s_4018f7', 'A', None)
('a_s_c52216', 'a_s_4018f7', 'a_s_2a84ae', None)
('a_s_c52216', 'a_s_b8a570', 'a_s_2a84ae', None)
('a_s_c52216', 'exp_fcc4f6', 'a_s_2a84ae', None)
*/