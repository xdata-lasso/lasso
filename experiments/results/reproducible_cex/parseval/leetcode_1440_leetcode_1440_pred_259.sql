-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_377b32', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_d06ce2', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_18df52', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('D', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_377b32', 'a_s_5c62f9', 'a_s_d06ce2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_377b32', '<', 'a_s_d06ce2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_5c62f9', 'a_s_d06ce2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_377b32', 'a_s_5c62f9', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_377b32', 'a_s_5c62f9', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_377b32', 'a_s_485e4a', 'a_s_d06ce2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_377b32', 'A', 'a_s_d06ce2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_377b32', 'exp_fcc4f6', 'a_s_d06ce2');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'D');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('E', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_377b32', 'a_s_5c62f9', 'a_s_d06ce2', 'false')
('a_s_377b32', '<', 'a_s_d06ce2', 'false')
('A', 'a_s_5c62f9', 'a_s_d06ce2', 'false')
('a_s_377b32', 'a_s_5c62f9', 'O', 'false')
('a_s_377b32', 'a_s_5c62f9', 'G', 'false')
('a_s_377b32', 'a_s_485e4a', 'a_s_d06ce2', 'false')
('a_s_377b32', 'A', 'a_s_d06ce2', 'false')
('a_s_377b32', 'exp_fcc4f6', 'a_s_d06ce2', 'false')
('@', 'exp_fcc4f6', 'D', 'false')
('E', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, IIF(CASE OPERATOR WHEN '<' THEN V1.VALUE < V2.VALUE WHEN '>' THEN V1.VALUE > V2.VALUE ELSE V1.VALUE = V2.VALUE END, 'true', 'false') AS VALUE FROM EXPRESSIONS AS E CROSS JOIN VARIABLES AS V1 CROSS JOIN VARIABLES AS V2 WHERE E.LEFT_OPERAND = V1.NAME AND E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_377b32', 'a_s_5c62f9', 'a_s_d06ce2', 'true')
('a_s_377b32', '<', 'a_s_d06ce2', 'false')
('A', 'a_s_5c62f9', 'a_s_d06ce2', 'false')
('a_s_377b32', 'a_s_5c62f9', 'O', 'false')
('a_s_377b32', 'a_s_5c62f9', 'G', 'true')
('a_s_377b32', 'a_s_485e4a', 'a_s_d06ce2', 'true')
('a_s_377b32', 'A', 'a_s_d06ce2', 'true')
('a_s_377b32', 'exp_fcc4f6', 'a_s_d06ce2', 'true')
('@', 'exp_fcc4f6', 'D', 'false')
('E', 'exp_fcc4f6', '`', 'false')
*/