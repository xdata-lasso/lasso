-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_6669dd', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_d1e38b', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('C', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_e815a3', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('H', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('h', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6669dd', 'a_s_c8a57c', 'a_s_d1e38b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_c8a57c', 'a_s_d1e38b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6669dd', 'a_s_c8a57c', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6669dd', 'a_s_8ddad1', 'a_s_d1e38b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6669dd', 'A', 'a_s_d1e38b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6669dd', 'exp_fcc4f6', 'a_s_d1e38b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'H');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('h', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_6669dd', 'a_s_c8a57c', 'a_s_d1e38b', 'false')
('O', 'a_s_c8a57c', 'a_s_d1e38b', 'false')
('a_s_6669dd', 'a_s_c8a57c', 'A', 'false')
('a_s_6669dd', 'a_s_8ddad1', 'a_s_d1e38b', 'false')
('a_s_6669dd', 'A', 'a_s_d1e38b', 'false')
('a_s_6669dd', 'exp_fcc4f6', 'a_s_d1e38b', 'false')
('@', 'exp_fcc4f6', 'H', 'false')
('h', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN E.OPERATOR = '>' AND VL.VALUE > VR.VALUE THEN 'true' WHEN E.OPERATOR = '>' AND VL.VALUE <= VR.VALUE THEN 'false' WHEN E.OPERATOR = '<' AND VL.VALUE < VR.VALUE THEN 'true' WHEN E.OPERATOR = '<' AND VL.VALUE >= VR.VALUE THEN 'false' WHEN VL.VALUE = VR.VALUE THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS VL ON E.LEFT_OPERAND = VL.NAME LEFT JOIN VARIABLES AS VR ON E.RIGHT_OPERAND = VR.NAME;

/*
Prediction Result:
('a_s_6669dd', 'a_s_c8a57c', 'a_s_d1e38b', 'true')
('O', 'a_s_c8a57c', 'a_s_d1e38b', 'false')
('a_s_6669dd', 'a_s_c8a57c', 'A', 'true')
('a_s_6669dd', 'a_s_8ddad1', 'a_s_d1e38b', 'true')
('a_s_6669dd', 'A', 'a_s_d1e38b', 'true')
('a_s_6669dd', 'exp_fcc4f6', 'a_s_d1e38b', 'true')
('@', 'exp_fcc4f6', 'H', 'false')
('h', 'exp_fcc4f6', 'B', 'false')
*/