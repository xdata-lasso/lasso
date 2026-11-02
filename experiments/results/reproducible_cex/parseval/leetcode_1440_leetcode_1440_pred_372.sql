-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_9719ec', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_49c52b', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_8cb215', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('U', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9719ec', 'a_s_6fcb8a', 'a_s_49c52b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_6fcb8a', 'a_s_49c52b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9719ec', 'a_s_6fcb8a', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9719ec', 'a_s_a964d3', 'a_s_49c52b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9719ec', 'A', 'a_s_49c52b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9719ec', 'exp_fcc4f6', 'a_s_49c52b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'E');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'U');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_9719ec', 'a_s_6fcb8a', 'a_s_49c52b', 'false')
('A', 'a_s_6fcb8a', 'a_s_49c52b', 'false')
('a_s_9719ec', 'a_s_6fcb8a', 'G', 'false')
('a_s_9719ec', 'a_s_a964d3', 'a_s_49c52b', 'false')
('a_s_9719ec', 'A', 'a_s_49c52b', 'false')
('a_s_9719ec', 'exp_fcc4f6', 'a_s_49c52b', 'false')
('@', 'exp_fcc4f6', 'E', 'false')
('`', 'exp_fcc4f6', 'U', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, (CASE WHEN OPERATOR = '>' THEN IIF(V1.VALUE > V2.VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(V1.VALUE = V2.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(V1.VALUE < V2.VALUE, 'true', 'false') END) AS VALUE FROM EXPRESSIONS LEFT JOIN VARIABLES AS V1 ON EXPRESSIONS.LEFT_OPERAND = V1.NAME LEFT JOIN VARIABLES AS V2 ON EXPRESSIONS.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_9719ec', 'a_s_6fcb8a', 'a_s_49c52b', None)
('A', 'a_s_6fcb8a', 'a_s_49c52b', None)
('a_s_9719ec', 'a_s_6fcb8a', 'G', None)
('a_s_9719ec', 'a_s_a964d3', 'a_s_49c52b', None)
('a_s_9719ec', 'A', 'a_s_49c52b', None)
('a_s_9719ec', 'exp_fcc4f6', 'a_s_49c52b', None)
('@', 'exp_fcc4f6', 'E', None)
('`', 'exp_fcc4f6', 'U', None)
*/