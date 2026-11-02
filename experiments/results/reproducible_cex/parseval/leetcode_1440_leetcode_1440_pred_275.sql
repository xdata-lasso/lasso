-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_9e414f', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_fbf6bf', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('C', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('_', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_dfe7b7', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('D', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9e414f', 'a_s_a89653', 'a_s_fbf6bf');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_a89653', 'a_s_fbf6bf');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9e414f', 'a_s_a89653', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9e414f', 'a_s_75cb2d', 'a_s_fbf6bf');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9e414f', 'A', 'a_s_fbf6bf');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9e414f', 'exp_fcc4f6', 'a_s_fbf6bf');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('E', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_9e414f', 'a_s_a89653', 'a_s_fbf6bf', 'false')
('A', 'a_s_a89653', 'a_s_fbf6bf', 'false')
('a_s_9e414f', 'a_s_a89653', 'A', 'false')
('a_s_9e414f', 'a_s_75cb2d', 'a_s_fbf6bf', 'false')
('a_s_9e414f', 'A', 'a_s_fbf6bf', 'false')
('a_s_9e414f', 'exp_fcc4f6', 'a_s_fbf6bf', 'false')
('E', 'exp_fcc4f6', '@', 'false')
('D', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN E.OPERATOR = '=' THEN IIF(V1.VALUE = V2.VALUE, 'true', 'false') WHEN E.OPERATOR = '<' THEN IIF(V1.VALUE < V2.VALUE, 'true', 'false') ELSE IIF(V1.VALUE > V2.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME LEFT JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_9e414f', 'a_s_a89653', 'a_s_fbf6bf', 'false')
('A', 'a_s_a89653', 'a_s_fbf6bf', 'false')
('a_s_9e414f', 'a_s_a89653', 'A', 'true')
('a_s_9e414f', 'a_s_75cb2d', 'a_s_fbf6bf', 'false')
('a_s_9e414f', 'A', 'a_s_fbf6bf', 'false')
('a_s_9e414f', 'exp_fcc4f6', 'a_s_fbf6bf', 'false')
('E', 'exp_fcc4f6', '@', 'false')
('D', 'exp_fcc4f6', 'B', 'true')
*/