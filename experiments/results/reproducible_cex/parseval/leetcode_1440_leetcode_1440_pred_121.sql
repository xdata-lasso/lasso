-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_a089bd', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_3e81e2', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('I', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_527506', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('E', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('Q', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a089bd', 'a_s_46176d', 'a_s_3e81e2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a089bd', '<', 'a_s_3e81e2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_46176d', 'a_s_3e81e2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a089bd', 'a_s_46176d', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a089bd', 'a_s_e8432b', 'a_s_3e81e2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a089bd', 'A', 'a_s_3e81e2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a089bd', 'exp_fcc4f6', 'a_s_3e81e2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'E');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('Q', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_a089bd', 'a_s_46176d', 'a_s_3e81e2', 'false')
('a_s_a089bd', '<', 'a_s_3e81e2', 'false')
('A', 'a_s_46176d', 'a_s_3e81e2', 'false')
('a_s_a089bd', 'a_s_46176d', 'A', 'false')
('a_s_a089bd', 'a_s_e8432b', 'a_s_3e81e2', 'false')
('a_s_a089bd', 'A', 'a_s_3e81e2', 'false')
('a_s_a089bd', 'exp_fcc4f6', 'a_s_3e81e2', 'false')
('@', 'exp_fcc4f6', 'E', 'false')
('Q', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN E.OPERATOR = '<' THEN CASE WHEN L.VALUE < R.VALUE THEN 'true' ELSE 'false' END WHEN E.OPERATOR = '=' THEN CASE WHEN L.VALUE = R.VALUE THEN 'true' ELSE 'false' END WHEN E.OPERATOR = '>' THEN CASE WHEN L.VALUE > R.VALUE THEN 'true' ELSE 'false' END END AS VALUE FROM EXPRESSIONS AS E CROSS JOIN VARIABLES AS L CROSS JOIN VARIABLES AS R WHERE E.LEFT_OPERAND = L.NAME AND E.RIGHT_OPERAND = R.NAME;

/*
Prediction Result:
('a_s_a089bd', 'a_s_46176d', 'a_s_3e81e2', None)
('a_s_a089bd', '<', 'a_s_3e81e2', 'false')
('A', 'a_s_46176d', 'a_s_3e81e2', None)
('a_s_a089bd', 'a_s_46176d', 'A', None)
('a_s_a089bd', 'a_s_e8432b', 'a_s_3e81e2', None)
('a_s_a089bd', 'A', 'a_s_3e81e2', None)
('a_s_a089bd', 'exp_fcc4f6', 'a_s_3e81e2', None)
('@', 'exp_fcc4f6', 'E', None)
('Q', 'exp_fcc4f6', 'B', None)
*/