-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_eb70d6', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_252f55', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_e3c889', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('D', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('C', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eb70d6', 'a_s_3e9cba', 'a_s_252f55');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_3e9cba', 'a_s_252f55');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eb70d6', 'a_s_3e9cba', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_3e9cba', 'a_s_252f55');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eb70d6', 'a_s_aea354', 'a_s_252f55');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eb70d6', 'A', 'a_s_252f55');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eb70d6', 'exp_fcc4f6', 'a_s_252f55');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'B');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_eb70d6', 'a_s_3e9cba', 'a_s_252f55', 'false')
('G', 'a_s_3e9cba', 'a_s_252f55', 'false')
('a_s_eb70d6', 'a_s_3e9cba', 'O', 'false')
('O', 'a_s_3e9cba', 'a_s_252f55', 'false')
('a_s_eb70d6', 'a_s_aea354', 'a_s_252f55', 'false')
('a_s_eb70d6', 'A', 'a_s_252f55', 'false')
('a_s_eb70d6', 'exp_fcc4f6', 'a_s_252f55', 'false')
('@', 'exp_fcc4f6', 'B', 'false')
('D', 'exp_fcc4f6', 'C', 'false')
*/

-- Prediction Query
SELECT A.*, CASE WHEN A.OPERATOR = '=' THEN IIF(B.VALUE = C.VALUE, 'true', 'false') WHEN A.OPERATOR = '>' THEN IIF(B.VALUE > C.VALUE, 'true', 'false') ELSE IIF(B.VALUE < C.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS A LEFT JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME LEFT JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Prediction Result:
('a_s_eb70d6', 'a_s_3e9cba', 'a_s_252f55', 'false')
('G', 'a_s_3e9cba', 'a_s_252f55', 'true')
('a_s_eb70d6', 'a_s_3e9cba', 'O', 'false')
('O', 'a_s_3e9cba', 'a_s_252f55', 'true')
('a_s_eb70d6', 'a_s_aea354', 'a_s_252f55', 'false')
('a_s_eb70d6', 'A', 'a_s_252f55', 'false')
('a_s_eb70d6', 'exp_fcc4f6', 'a_s_252f55', 'false')
('@', 'exp_fcc4f6', 'B', 'false')
('D', 'exp_fcc4f6', 'C', 'false')
*/