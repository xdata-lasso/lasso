-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_fb4999', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_05a90e', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_b1b6a7', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('!', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fb4999', 'a_s_2d0c19', 'a_s_05a90e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fb4999', '<', 'a_s_05a90e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_2d0c19', 'a_s_05a90e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fb4999', 'a_s_2d0c19', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fb4999', 'a_s_5604c0', 'a_s_05a90e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fb4999', 'A', 'a_s_05a90e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fb4999', 'exp_fcc4f6', 'a_s_05a90e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'E');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('!', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_fb4999', 'a_s_2d0c19', 'a_s_05a90e', 'false')
('a_s_fb4999', '<', 'a_s_05a90e', 'false')
('G', 'a_s_2d0c19', 'a_s_05a90e', 'false')
('a_s_fb4999', 'a_s_2d0c19', 'A', 'false')
('a_s_fb4999', 'a_s_5604c0', 'a_s_05a90e', 'false')
('a_s_fb4999', 'A', 'a_s_05a90e', 'false')
('a_s_fb4999', 'exp_fcc4f6', 'a_s_05a90e', 'false')
('@', 'exp_fcc4f6', 'E', 'false')
('!', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
WITH BASE AS (SELECT A.*, B.VALUE AS V1, C.VALUE AS V2 FROM EXPRESSIONS AS A LEFT JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME LEFT JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '=' THEN IIF(V1 = V2, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(V1 < V2, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(V1 > V2, 'true', 'false') END AS VALUE FROM BASE;

/*
Prediction Result:
('a_s_fb4999', 'a_s_2d0c19', 'a_s_05a90e', None)
('a_s_fb4999', '<', 'a_s_05a90e', 'false')
('G', 'a_s_2d0c19', 'a_s_05a90e', None)
('a_s_fb4999', 'a_s_2d0c19', 'A', None)
('a_s_fb4999', 'a_s_5604c0', 'a_s_05a90e', None)
('a_s_fb4999', 'A', 'a_s_05a90e', None)
('a_s_fb4999', 'exp_fcc4f6', 'a_s_05a90e', None)
('@', 'exp_fcc4f6', 'E', None)
('!', 'exp_fcc4f6', '`', None)
*/