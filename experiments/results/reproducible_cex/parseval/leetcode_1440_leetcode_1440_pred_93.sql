-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_fa394e', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_c026bd', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('_', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('O', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_7c3d30', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('E', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1980249628);

INSERT INTO "variables" ("name", "value") VALUES ('Q', -734455130);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fa394e', 'a_s_9d8e4c', 'a_s_c026bd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_9d8e4c', 'a_s_c026bd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fa394e', 'a_s_9d8e4c', '_');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_9d8e4c', 'a_s_c026bd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fa394e', 'a_s_9d8e4c', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fa394e', 'a_s_44d5f4', 'a_s_c026bd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fa394e', 'A', 'a_s_c026bd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fa394e', 'exp_fcc4f6', 'a_s_c026bd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'E');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'Q');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_fa394e', 'a_s_9d8e4c', 'a_s_c026bd', 'false')
('G', 'a_s_9d8e4c', 'a_s_c026bd', 'false')
('a_s_fa394e', 'a_s_9d8e4c', '_', 'false')
('O', 'a_s_9d8e4c', 'a_s_c026bd', 'false')
('a_s_fa394e', 'a_s_9d8e4c', 'O', 'false')
('a_s_fa394e', 'a_s_44d5f4', 'a_s_c026bd', 'false')
('a_s_fa394e', 'A', 'a_s_c026bd', 'false')
('a_s_fa394e', 'exp_fcc4f6', 'a_s_c026bd', 'false')
('@', 'exp_fcc4f6', 'E', 'false')
('`', 'exp_fcc4f6', 'Q', 'false')
*/

-- Prediction Query
SELECT A.LEFT_OPERAND, A.OPERATOR, A.RIGHT_OPERAND, IIF(IIF(A.OPERATOR = '=', B.VALUE = C.VALUE, IIF(A.OPERATOR = '>', B.VALUE > C.VALUE, B.VALUE < C.VALUE)) = 1, 'true', 'false') AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Prediction Result:
('a_s_fa394e', 'a_s_9d8e4c', 'a_s_c026bd', 'false')
('G', 'a_s_9d8e4c', 'a_s_c026bd', 'true')
('a_s_fa394e', 'a_s_9d8e4c', '_', 'false')
('O', 'a_s_9d8e4c', 'a_s_c026bd', 'true')
('a_s_fa394e', 'a_s_9d8e4c', 'O', 'false')
('a_s_fa394e', 'a_s_44d5f4', 'a_s_c026bd', 'false')
('a_s_fa394e', 'A', 'a_s_c026bd', 'false')
('a_s_fa394e', 'exp_fcc4f6', 'a_s_c026bd', 'false')
('@', 'exp_fcc4f6', 'E', 'true')
('`', 'exp_fcc4f6', 'Q', 'true')
*/