-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_25afab', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_98bd18', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_3f8bbc', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('F', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('D', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('@', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_25afab', 'a_s_6e2fc0', 'a_s_98bd18');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_6e2fc0', 'a_s_98bd18');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_25afab', 'a_s_6e2fc0', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_6e2fc0', 'a_s_98bd18');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_25afab', 'a_s_4dc712', 'a_s_98bd18');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_25afab', 'A', 'a_s_98bd18');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_25afab', 'exp_fcc4f6', 'a_s_98bd18');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('F', 'exp_fcc4f6', 'B');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', '@');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_25afab', 'a_s_6e2fc0', 'a_s_98bd18', 'false')
('G', 'a_s_6e2fc0', 'a_s_98bd18', 'false')
('a_s_25afab', 'a_s_6e2fc0', 'A', 'false')
('O', 'a_s_6e2fc0', 'a_s_98bd18', 'false')
('a_s_25afab', 'a_s_4dc712', 'a_s_98bd18', 'false')
('a_s_25afab', 'A', 'a_s_98bd18', 'false')
('a_s_25afab', 'exp_fcc4f6', 'a_s_98bd18', 'false')
('F', 'exp_fcc4f6', 'B', 'false')
('D', 'exp_fcc4f6', '@', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN (CASE WHEN E.OPERATOR = '>' THEN L.VALUE > R.VALUE WHEN E.OPERATOR = '<' THEN L.VALUE < R.VALUE ELSE L.VALUE = R.VALUE END) = 1 THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS E LEFT OUTER JOIN VARIABLES AS L ON E.LEFT_OPERAND = L.NAME LEFT OUTER JOIN VARIABLES AS R ON E.RIGHT_OPERAND = R.NAME;

/*
Prediction Result:
('a_s_25afab', 'a_s_6e2fc0', 'a_s_98bd18', 'true')
('G', 'a_s_6e2fc0', 'a_s_98bd18', 'false')
('a_s_25afab', 'a_s_6e2fc0', 'A', 'true')
('O', 'a_s_6e2fc0', 'a_s_98bd18', 'true')
('a_s_25afab', 'a_s_4dc712', 'a_s_98bd18', 'true')
('a_s_25afab', 'A', 'a_s_98bd18', 'true')
('a_s_25afab', 'exp_fcc4f6', 'a_s_98bd18', 'true')
('F', 'exp_fcc4f6', 'B', 'false')
('D', 'exp_fcc4f6', '@', 'false')
*/