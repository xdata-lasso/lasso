-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_970d40', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_9f2cf9', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('_', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('O', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_1486bb', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('D', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('@', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1980249628);

INSERT INTO "variables" ("name", "value") VALUES ('F', -734455130);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_970d40', 'a_s_5bdc0a', 'a_s_9f2cf9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_5bdc0a', 'a_s_9f2cf9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_970d40', 'a_s_5bdc0a', '_');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_970d40', 'a_s_5bdc0a', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_970d40', 'a_s_b427cf', 'a_s_9f2cf9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_970d40', 'A', 'a_s_9f2cf9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_970d40', 'exp_fcc4f6', 'a_s_9f2cf9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'D');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('F', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_970d40', 'a_s_5bdc0a', 'a_s_9f2cf9', 'false')
('G', 'a_s_5bdc0a', 'a_s_9f2cf9', 'false')
('a_s_970d40', 'a_s_5bdc0a', '_', 'false')
('a_s_970d40', 'a_s_5bdc0a', 'O', 'false')
('a_s_970d40', 'a_s_b427cf', 'a_s_9f2cf9', 'false')
('a_s_970d40', 'A', 'a_s_9f2cf9', 'false')
('a_s_970d40', 'exp_fcc4f6', 'a_s_9f2cf9', 'false')
('@', 'exp_fcc4f6', 'D', 'false')
('F', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, RIGHT_OPERAND, OPERATOR, CASE WHEN LEFT_VALUE > RIGHT_VALUE AND OPERATOR = '>' THEN 'true' WHEN LEFT_VALUE = RIGHT_VALUE AND OPERATOR = '=' THEN 'true' WHEN LEFT_VALUE < RIGHT_VALUE AND OPERATOR = '<' THEN 'true' ELSE 'false' END AS VALUE FROM (SELECT LEFT_OPERAND, RIGHT_OPERAND, L.VALUE AS LEFT_VALUE, OPERATOR, R.VALUE AS RIGHT_VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS L ON E.LEFT_OPERAND = L.NAME LEFT JOIN VARIABLES AS R ON E.RIGHT_OPERAND = R.NAME) AS A;

/*
Prediction Result:
('a_s_970d40', 'a_s_9f2cf9', 'a_s_5bdc0a', 'false')
('G', 'a_s_9f2cf9', 'a_s_5bdc0a', 'false')
('a_s_970d40', '_', 'a_s_5bdc0a', 'false')
('a_s_970d40', 'O', 'a_s_5bdc0a', 'false')
('a_s_970d40', 'a_s_9f2cf9', 'a_s_b427cf', 'false')
('a_s_970d40', 'a_s_9f2cf9', 'A', 'false')
('a_s_970d40', 'a_s_9f2cf9', 'exp_fcc4f6', 'false')
('@', 'D', 'exp_fcc4f6', 'false')
('F', '`', 'exp_fcc4f6', 'false')
*/