-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_9c7afd', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_9b3af5', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_332dd2', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('"', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('P', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9c7afd', 'a_s_206add', 'a_s_9b3af5');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9c7afd', '<', 'a_s_9b3af5');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_206add', 'a_s_9b3af5');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9c7afd', 'a_s_206add', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9c7afd', 'a_s_9da09d', 'a_s_9b3af5');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9c7afd', 'A', 'a_s_9b3af5');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9c7afd', 'exp_fcc4f6', 'a_s_9b3af5');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('P', 'exp_fcc4f6', '"');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_9c7afd', 'a_s_206add', 'a_s_9b3af5', 'false')
('a_s_9c7afd', '<', 'a_s_9b3af5', 'false')
('A', 'a_s_206add', 'a_s_9b3af5', 'false')
('a_s_9c7afd', 'a_s_206add', 'G', 'false')
('a_s_9c7afd', 'a_s_9da09d', 'a_s_9b3af5', 'false')
('a_s_9c7afd', 'A', 'a_s_9b3af5', 'false')
('a_s_9c7afd', 'exp_fcc4f6', 'a_s_9b3af5', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('P', 'exp_fcc4f6', '"', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, (CASE OPERATOR WHEN '=' THEN IIF(V1.VALUE = V2.VALUE, 'true', 'false') WHEN '<' THEN IIF(V1.VALUE < V2.VALUE, 'true', 'false') ELSE IIF(V1.VALUE < V2.VALUE, 'true', 'false') END) AS VALUE FROM EXPRESSIONS AS E INNER JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME INNER JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_9c7afd', 'a_s_206add', 'a_s_9b3af5', 'false')
('a_s_9c7afd', '<', 'a_s_9b3af5', 'false')
('A', 'a_s_206add', 'a_s_9b3af5', 'true')
('a_s_9c7afd', 'a_s_206add', 'G', 'false')
('a_s_9c7afd', 'a_s_9da09d', 'a_s_9b3af5', 'false')
('a_s_9c7afd', 'A', 'a_s_9b3af5', 'false')
('a_s_9c7afd', 'exp_fcc4f6', 'a_s_9b3af5', 'false')
('B', 'exp_fcc4f6', '@', 'true')
('P', 'exp_fcc4f6', '"', 'false')
*/