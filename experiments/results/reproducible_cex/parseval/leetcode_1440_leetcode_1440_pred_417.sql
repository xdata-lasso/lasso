-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_e6feaa', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_8d8fdf', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_1e0cf8', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('!', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('a', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e6feaa', 'a_s_25fc93', 'a_s_8d8fdf');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_25fc93', 'a_s_8d8fdf');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e6feaa', 'a_s_25fc93', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e6feaa', 'a_s_55c415', 'a_s_8d8fdf');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e6feaa', 'A', 'a_s_8d8fdf');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e6feaa', 'exp_fcc4f6', 'a_s_8d8fdf');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', '!');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', 'a');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_e6feaa', 'a_s_25fc93', 'a_s_8d8fdf', 'false')
('A', 'a_s_25fc93', 'a_s_8d8fdf', 'false')
('a_s_e6feaa', 'a_s_25fc93', 'A', 'false')
('a_s_e6feaa', 'a_s_55c415', 'a_s_8d8fdf', 'false')
('a_s_e6feaa', 'A', 'a_s_8d8fdf', 'false')
('a_s_e6feaa', 'exp_fcc4f6', 'a_s_8d8fdf', 'false')
('@', 'exp_fcc4f6', '!', 'false')
('B', 'exp_fcc4f6', 'a', 'false')
*/

-- Prediction Query
WITH CTE AS (SELECT *, (SELECT V.VALUE FROM VARIABLES AS V WHERE V.NAME = E.LEFT_OPERAND) AS LEFT_VALUE, (SELECT V.VALUE FROM VARIABLES AS V WHERE V.NAME = E.RIGHT_OPERAND) AS RIGHT_VALUE FROM EXPRESSIONS AS E) SELECT CTE.LEFT_OPERAND, CTE.OPERATOR, CTE.RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN CASE WHEN LEFT_VALUE > RIGHT_VALUE THEN 'true' ELSE 'false' END WHEN OPERATOR = '<' THEN CASE WHEN LEFT_VALUE < RIGHT_VALUE THEN 'true' ELSE 'false' END WHEN OPERATOR = '=' THEN CASE WHEN LEFT_VALUE = RIGHT_VALUE THEN 'true' ELSE 'false' END END AS VALUE FROM CTE;

/*
Prediction Result:
('a_s_e6feaa', 'a_s_25fc93', 'a_s_8d8fdf', None)
('A', 'a_s_25fc93', 'a_s_8d8fdf', None)
('a_s_e6feaa', 'a_s_25fc93', 'A', None)
('a_s_e6feaa', 'a_s_55c415', 'a_s_8d8fdf', None)
('a_s_e6feaa', 'A', 'a_s_8d8fdf', None)
('a_s_e6feaa', 'exp_fcc4f6', 'a_s_8d8fdf', None)
('@', 'exp_fcc4f6', '!', None)
('B', 'exp_fcc4f6', 'a', None)
*/