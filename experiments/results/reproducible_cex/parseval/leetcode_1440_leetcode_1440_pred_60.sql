-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_228956', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_8644b8', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_c16f2a', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('E', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('C', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('H', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_228956', 'a_s_780c08', 'a_s_8644b8');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_780c08', 'a_s_8644b8');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_228956', 'a_s_780c08', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_228956', 'a_s_7b1985', 'a_s_8644b8');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_228956', 'A', 'a_s_8644b8');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_228956', 'exp_fcc4f6', 'a_s_8644b8');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'E');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('H', 'exp_fcc4f6', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_228956', 'a_s_780c08', 'a_s_8644b8', 'false')
('G', 'a_s_780c08', 'a_s_8644b8', 'false')
('a_s_228956', 'a_s_780c08', 'A', 'false')
('a_s_228956', 'a_s_7b1985', 'a_s_8644b8', 'false')
('a_s_228956', 'A', 'a_s_8644b8', 'false')
('a_s_228956', 'exp_fcc4f6', 'a_s_8644b8', 'false')
('@', 'exp_fcc4f6', 'E', 'false')
('H', 'exp_fcc4f6', 'C', 'false')
*/

-- Prediction Query
SELECT R.LEFT_OPERAND, R.OPERATOR, R.RIGHT_OPERAND, (CASE WHEN R.OPERATOR = '=' AND R.LEFT_OPERAND_VAL = R.RIGHT_OPERAND_VAL THEN 'true' WHEN R.OPERATOR = '=' AND R.LEFT_OPERAND_VAL <> R.RIGHT_OPERAND_VAL THEN 'false' WHEN R.OPERATOR = '<' AND R.LEFT_OPERAND_VAL < R.RIGHT_OPERAND_VAL THEN 'true' WHEN R.OPERATOR = '<' AND R.LEFT_OPERAND_VAL >= R.RIGHT_OPERAND_VAL THEN 'false' WHEN R.OPERATOR = '>' AND R.LEFT_OPERAND_VAL > R.RIGHT_OPERAND_VAL THEN 'true' WHEN R.OPERATOR = '>' AND R.LEFT_OPERAND_VAL <= R.RIGHT_OPERAND_VAL THEN 'false' END) AS VALUE FROM (SELECT L.LEFT_OPERAND_VAL, L.OPERATOR, V.VALUE AS RIGHT_OPERAND_VAL, L.LEFT_OPERAND, L.RIGHT_OPERAND FROM (SELECT V.VALUE AS LEFT_OPERAND_VAL, E.OPERATOR, E.RIGHT_OPERAND, E.LEFT_OPERAND FROM EXPRESSIONS AS E JOIN VARIABLES AS V ON E.LEFT_OPERAND = V.NAME) AS L JOIN VARIABLES AS V ON L.RIGHT_OPERAND = V.NAME) AS R;

/*
Prediction Result:
('a_s_228956', 'a_s_780c08', 'a_s_8644b8', None)
('G', 'a_s_780c08', 'a_s_8644b8', None)
('a_s_228956', 'a_s_780c08', 'A', None)
('a_s_228956', 'a_s_7b1985', 'a_s_8644b8', None)
('a_s_228956', 'A', 'a_s_8644b8', None)
('a_s_228956', 'exp_fcc4f6', 'a_s_8644b8', None)
('@', 'exp_fcc4f6', 'E', None)
('H', 'exp_fcc4f6', 'C', None)
*/