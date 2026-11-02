-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_02f61b', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_c31baa', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('I', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_e73847', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('E', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('Q', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_02f61b', 'a_s_b1aea3', 'a_s_c31baa');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_02f61b', '<', 'a_s_c31baa');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_b1aea3', 'a_s_c31baa');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_02f61b', 'a_s_b1aea3', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_02f61b', 'a_s_2f7e8c', 'a_s_c31baa');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_02f61b', 'A', 'a_s_c31baa');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_02f61b', 'exp_fcc4f6', 'a_s_c31baa');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'E');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'Q');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_02f61b', 'a_s_b1aea3', 'a_s_c31baa', 'false')
('a_s_02f61b', '<', 'a_s_c31baa', 'false')
('A', 'a_s_b1aea3', 'a_s_c31baa', 'false')
('a_s_02f61b', 'a_s_b1aea3', 'A', 'false')
('a_s_02f61b', 'a_s_2f7e8c', 'a_s_c31baa', 'false')
('a_s_02f61b', 'A', 'a_s_c31baa', 'false')
('a_s_02f61b', 'exp_fcc4f6', 'a_s_c31baa', 'false')
('@', 'exp_fcc4f6', 'E', 'false')
('`', 'exp_fcc4f6', 'Q', 'false')
*/

-- Prediction Query
WITH TMP AS (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, V1.VALUE AS L, V2.VALUE AS R FROM EXPRESSIONS AS E INNER JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME INNER JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(L > R, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(L = R, 'true', 'false') ELSE IIF(L < R, 'true', 'false') END AS VALUE FROM TMP;

/*
Prediction Result:
('a_s_02f61b', 'a_s_b1aea3', 'a_s_c31baa', 'false')
('a_s_02f61b', '<', 'a_s_c31baa', 'false')
('A', 'a_s_b1aea3', 'a_s_c31baa', 'true')
('a_s_02f61b', 'a_s_b1aea3', 'A', 'false')
('a_s_02f61b', 'a_s_2f7e8c', 'a_s_c31baa', 'false')
('a_s_02f61b', 'A', 'a_s_c31baa', 'false')
('a_s_02f61b', 'exp_fcc4f6', 'a_s_c31baa', 'false')
('@', 'exp_fcc4f6', 'E', 'true')
('`', 'exp_fcc4f6', 'Q', 'false')
*/