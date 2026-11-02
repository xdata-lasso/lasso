-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_33e573', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_165734', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_b008e7', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('C', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('D', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_33e573', 'a_s_0cd0f3', 'a_s_165734');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_33e573', '<', 'a_s_165734');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_0cd0f3', 'a_s_165734');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_33e573', 'a_s_0cd0f3', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_33e573', 'a_s_15dddb', 'a_s_165734');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_33e573', 'A', 'a_s_165734');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_33e573', 'exp_fcc4f6', 'a_s_165734');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_33e573', 'a_s_0cd0f3', 'a_s_165734', 'false')
('a_s_33e573', '<', 'a_s_165734', 'false')
('A', 'a_s_0cd0f3', 'a_s_165734', 'false')
('a_s_33e573', 'a_s_0cd0f3', 'A', 'false')
('a_s_33e573', 'a_s_15dddb', 'a_s_165734', 'false')
('a_s_33e573', 'A', 'a_s_165734', 'false')
('a_s_33e573', 'exp_fcc4f6', 'a_s_165734', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('D', 'exp_fcc4f6', 'C', 'false')
*/

-- Prediction Query
SELECT A.*, CASE WHEN A.OPERATOR = '>' THEN IIF(B.VALUE > C.VALUE, 'true', 'false') WHEN A.OPERATOR = '<' THEN IIF(B.VALUE < C.VALUE, 'true', 'false') ELSE IIF(B.VALUE = C.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS A CROSS JOIN VARIABLES AS B CROSS JOIN VARIABLES AS C WHERE A.LEFT_OPERAND = B.NAME AND A.RIGHT_OPERAND = C.NAME;

/*
Prediction Result:
('a_s_33e573', 'a_s_0cd0f3', 'a_s_165734', 'true')
('a_s_33e573', '<', 'a_s_165734', 'false')
('A', 'a_s_0cd0f3', 'a_s_165734', 'false')
('a_s_33e573', 'a_s_0cd0f3', 'A', 'false')
('a_s_33e573', 'a_s_15dddb', 'a_s_165734', 'true')
('a_s_33e573', 'A', 'a_s_165734', 'true')
('a_s_33e573', 'exp_fcc4f6', 'a_s_165734', 'true')
('B', 'exp_fcc4f6', '@', 'false')
('D', 'exp_fcc4f6', 'C', 'false')
*/