-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_661797', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_3b2a66', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('_', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_64ae44', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('Q', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1980249628);

INSERT INTO "variables" ("name", "value") VALUES ('P', -734455130);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_661797', 'a_s_319ea8', 'a_s_3b2a66');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_319ea8', 'a_s_3b2a66');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_661797', 'a_s_319ea8', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('_', 'a_s_319ea8', 'a_s_3b2a66');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_661797', 'a_s_9b81ab', 'a_s_3b2a66');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_661797', 'A', 'a_s_3b2a66');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_661797', 'exp_fcc4f6', 'a_s_3b2a66');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'Q');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', 'P');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_661797', 'a_s_319ea8', 'a_s_3b2a66', 'false')
('G', 'a_s_319ea8', 'a_s_3b2a66', 'false')
('a_s_661797', 'a_s_319ea8', 'O', 'false')
('_', 'a_s_319ea8', 'a_s_3b2a66', 'false')
('a_s_661797', 'a_s_9b81ab', 'a_s_3b2a66', 'false')
('a_s_661797', 'A', 'a_s_3b2a66', 'false')
('a_s_661797', 'exp_fcc4f6', 'a_s_3b2a66', 'false')
('@', 'exp_fcc4f6', 'Q', 'false')
('B', 'exp_fcc4f6', 'P', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN E.OPERATOR = '<' THEN IIF(VL.VALUE < VR.VALUE, 'true', 'false') WHEN E.OPERATOR = '>' THEN IIF(VL.VALUE > VR.VALUE, 'true', 'false') ELSE IIF(VL.VALUE = VR.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS VL ON E.LEFT_OPERAND = VL.NAME JOIN VARIABLES AS VR ON E.RIGHT_OPERAND = VR.NAME;

/*
Prediction Result:
('a_s_661797', 'a_s_319ea8', 'a_s_3b2a66', 'true')
('G', 'a_s_319ea8', 'a_s_3b2a66', 'false')
('a_s_661797', 'a_s_319ea8', 'O', 'false')
('_', 'a_s_319ea8', 'a_s_3b2a66', 'false')
('a_s_661797', 'a_s_9b81ab', 'a_s_3b2a66', 'true')
('a_s_661797', 'A', 'a_s_3b2a66', 'true')
('a_s_661797', 'exp_fcc4f6', 'a_s_3b2a66', 'true')
('@', 'exp_fcc4f6', 'Q', 'false')
('B', 'exp_fcc4f6', 'P', 'false')
*/