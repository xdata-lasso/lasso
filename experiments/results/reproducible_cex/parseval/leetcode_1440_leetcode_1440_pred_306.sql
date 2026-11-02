-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_e1df6d', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_bb4ef4', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_f3aeff', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('Q', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('B', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('P', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e1df6d', 'a_s_1e38b2', 'a_s_bb4ef4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_1e38b2', 'a_s_bb4ef4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e1df6d', 'a_s_1e38b2', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e1df6d', 'a_s_1e38b2', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e1df6d', 'a_s_51c897', 'a_s_bb4ef4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e1df6d', 'A', 'a_s_bb4ef4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_e1df6d', 'exp_fcc4f6', 'a_s_bb4ef4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'Q');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', 'P');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_e1df6d', 'a_s_1e38b2', 'a_s_bb4ef4', 'false')
('A', 'a_s_1e38b2', 'a_s_bb4ef4', 'false')
('a_s_e1df6d', 'a_s_1e38b2', 'O', 'false')
('a_s_e1df6d', 'a_s_1e38b2', 'G', 'false')
('a_s_e1df6d', 'a_s_51c897', 'a_s_bb4ef4', 'false')
('a_s_e1df6d', 'A', 'a_s_bb4ef4', 'false')
('a_s_e1df6d', 'exp_fcc4f6', 'a_s_bb4ef4', 'false')
('@', 'exp_fcc4f6', 'Q', 'false')
('B', 'exp_fcc4f6', 'P', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '<' THEN IIF(V1.VALUE < V2.VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(V1.VALUE = V2.VALUE, 'true', 'false') ELSE IIF(V1.VALUE > V2.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME LEFT JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_e1df6d', 'a_s_1e38b2', 'a_s_bb4ef4', 'false')
('A', 'a_s_1e38b2', 'a_s_bb4ef4', 'false')
('a_s_e1df6d', 'a_s_1e38b2', 'O', 'true')
('a_s_e1df6d', 'a_s_1e38b2', 'G', 'false')
('a_s_e1df6d', 'a_s_51c897', 'a_s_bb4ef4', 'false')
('a_s_e1df6d', 'A', 'a_s_bb4ef4', 'false')
('a_s_e1df6d', 'exp_fcc4f6', 'a_s_bb4ef4', 'false')
('@', 'exp_fcc4f6', 'Q', 'true')
('B', 'exp_fcc4f6', 'P', 'true')
*/