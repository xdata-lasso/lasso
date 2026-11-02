-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_be48e5', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_f35283', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_851dcf', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('E', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('I', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_be48e5', 'a_s_5b1ea2', 'a_s_f35283');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_be48e5', '<', 'a_s_f35283');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_5b1ea2', 'a_s_f35283');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_be48e5', 'a_s_5b1ea2', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_be48e5', 'a_s_b20197', 'a_s_f35283');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_be48e5', 'A', 'a_s_f35283');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_be48e5', 'exp_fcc4f6', 'a_s_f35283');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'E');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('I', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_be48e5', 'a_s_5b1ea2', 'a_s_f35283', 'false')
('a_s_be48e5', '<', 'a_s_f35283', 'false')
('G', 'a_s_5b1ea2', 'a_s_f35283', 'false')
('a_s_be48e5', 'a_s_5b1ea2', 'A', 'false')
('a_s_be48e5', 'a_s_b20197', 'a_s_f35283', 'false')
('a_s_be48e5', 'A', 'a_s_f35283', 'false')
('a_s_be48e5', 'exp_fcc4f6', 'a_s_f35283', 'false')
('@', 'exp_fcc4f6', 'E', 'false')
('I', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
WITH CTE AS (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, V.VALUE AS LEFT_OPERAND_V, E.OPERATOR AS OPERATOR_V, V1.VALUE AS RIGHT_OPERAND_V FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V ON E.LEFT_OPERAND = V.NAME LEFT JOIN VARIABLES AS V1 ON E.RIGHT_OPERAND = V1.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR_V = '>' THEN (CASE WHEN LEFT_OPERAND_V > RIGHT_OPERAND_V THEN 'true' ELSE 'false' END) WHEN OPERATOR_V = '<' THEN (CASE WHEN LEFT_OPERAND_V < RIGHT_OPERAND_V THEN 'true' ELSE 'false' END) WHEN OPERATOR_V = '=' THEN (CASE WHEN LEFT_OPERAND_V = RIGHT_OPERAND_V THEN 'true' ELSE 'false' END) ELSE NULL END AS VALUE FROM CTE;

/*
Prediction Result:
('a_s_be48e5', 'a_s_5b1ea2', 'a_s_f35283', None)
('a_s_be48e5', '<', 'a_s_f35283', 'false')
('G', 'a_s_5b1ea2', 'a_s_f35283', None)
('a_s_be48e5', 'a_s_5b1ea2', 'A', None)
('a_s_be48e5', 'a_s_b20197', 'a_s_f35283', None)
('a_s_be48e5', 'A', 'a_s_f35283', None)
('a_s_be48e5', 'exp_fcc4f6', 'a_s_f35283', None)
('@', 'exp_fcc4f6', 'E', None)
('I', 'exp_fcc4f6', '`', None)
*/