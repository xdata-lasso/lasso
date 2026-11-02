-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_761c22', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_9eb1a2', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('Q', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_981dc9', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('!', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_761c22', 'a_s_1b77d7', 'a_s_9eb1a2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_761c22', '<', 'a_s_9eb1a2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_1b77d7', 'a_s_9eb1a2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_761c22', 'a_s_1b77d7', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('Q', 'a_s_1b77d7', 'a_s_9eb1a2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_761c22', 'a_s_ceb40d', 'a_s_9eb1a2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_761c22', 'A', 'a_s_9eb1a2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_761c22', 'exp_fcc4f6', 'a_s_9eb1a2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'E');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '!');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_761c22', 'a_s_1b77d7', 'a_s_9eb1a2', 'false')
('a_s_761c22', '<', 'a_s_9eb1a2', 'false')
('O', 'a_s_1b77d7', 'a_s_9eb1a2', 'false')
('a_s_761c22', 'a_s_1b77d7', 'O', 'false')
('Q', 'a_s_1b77d7', 'a_s_9eb1a2', 'false')
('a_s_761c22', 'a_s_ceb40d', 'a_s_9eb1a2', 'false')
('a_s_761c22', 'A', 'a_s_9eb1a2', 'false')
('a_s_761c22', 'exp_fcc4f6', 'a_s_9eb1a2', 'false')
('@', 'exp_fcc4f6', 'E', 'false')
('B', 'exp_fcc4f6', '!', 'false')
*/

-- Prediction Query
WITH CTE AS (SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, (SELECT VALUE FROM VARIABLES WHERE NAME = E.LEFT_OPERAND) AS LEFT_VALUE, (SELECT VALUE FROM VARIABLES WHERE NAME = E.RIGHT_OPERAND) AS RIGHT_VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V ON V.NAME = E.LEFT_OPERAND OR V.NAME = E.RIGHT_OPERAND) SELECT DISTINCT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, IIF((CASE WHEN OPERATOR = '<' THEN LEFT_VALUE < RIGHT_VALUE WHEN OPERATOR = '=' THEN LEFT_VALUE = RIGHT_VALUE ELSE LEFT_VALUE > RIGHT_VALUE END), 'true', 'false') AS VALUE FROM CTE;

/*
Prediction Result:
('@', 'exp_fcc4f6', 'E', 'false')
('B', 'exp_fcc4f6', '!', 'false')
('O', 'a_s_1b77d7', 'a_s_9eb1a2', 'false')
('Q', 'a_s_1b77d7', 'a_s_9eb1a2', 'false')
('a_s_761c22', '<', 'a_s_9eb1a2', 'false')
('a_s_761c22', 'A', 'a_s_9eb1a2', 'false')
('a_s_761c22', 'a_s_1b77d7', 'O', 'true')
('a_s_761c22', 'a_s_1b77d7', 'a_s_9eb1a2', 'false')
('a_s_761c22', 'a_s_ceb40d', 'a_s_9eb1a2', 'false')
('a_s_761c22', 'exp_fcc4f6', 'a_s_9eb1a2', 'false')
*/