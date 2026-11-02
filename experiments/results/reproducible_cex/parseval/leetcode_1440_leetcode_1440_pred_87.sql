-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_edc9da', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_5bdec3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('I', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('C', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('O', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_500f0e', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('@', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('Q', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_edc9da', 'a_s_327d7d', 'a_s_5bdec3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_327d7d', 'a_s_5bdec3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_edc9da', 'a_s_327d7d', 'I');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'a_s_327d7d', 'a_s_5bdec3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_edc9da', 'a_s_327d7d', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_edc9da', 'a_s_48cea3', 'a_s_5bdec3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_edc9da', 'A', 'a_s_5bdec3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_edc9da', 'exp_fcc4f6', 'a_s_5bdec3');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('Q', 'exp_fcc4f6', '@');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_edc9da', 'a_s_327d7d', 'a_s_5bdec3', 'false')
('G', 'a_s_327d7d', 'a_s_5bdec3', 'false')
('a_s_edc9da', 'a_s_327d7d', 'I', 'false')
('C', 'a_s_327d7d', 'a_s_5bdec3', 'false')
('a_s_edc9da', 'a_s_327d7d', 'O', 'false')
('a_s_edc9da', 'a_s_48cea3', 'a_s_5bdec3', 'false')
('a_s_edc9da', 'A', 'a_s_5bdec3', 'false')
('a_s_edc9da', 'exp_fcc4f6', 'a_s_5bdec3', 'false')
('Q', 'exp_fcc4f6', '@', 'false')
*/

-- Prediction Query
SELECT A.*, CASE WHEN A.OPERATOR = '>' THEN CASE WHEN L.VALUE > R.VALUE THEN 'true' ELSE 'false' END WHEN A.OPERATOR = '<' THEN CASE WHEN L.VALUE > R.VALUE THEN 'true' ELSE 'false' END WHEN A.OPERATOR = '=' THEN CASE WHEN L.VALUE = R.VALUE THEN 'true' ELSE 'false' END ELSE NULL END AS VALUE FROM EXPRESSIONS AS A INNER JOIN VARIABLES AS L ON A.LEFT_OPERAND = L.NAME INNER JOIN VARIABLES AS R ON A.RIGHT_OPERAND = R.NAME;

/*
Prediction Result:
('a_s_edc9da', 'a_s_327d7d', 'a_s_5bdec3', None)
('G', 'a_s_327d7d', 'a_s_5bdec3', None)
('a_s_edc9da', 'a_s_327d7d', 'I', None)
('C', 'a_s_327d7d', 'a_s_5bdec3', None)
('a_s_edc9da', 'a_s_327d7d', 'O', None)
('a_s_edc9da', 'a_s_48cea3', 'a_s_5bdec3', None)
('a_s_edc9da', 'A', 'a_s_5bdec3', None)
('a_s_edc9da', 'exp_fcc4f6', 'a_s_5bdec3', None)
('Q', 'exp_fcc4f6', '@', None)
*/