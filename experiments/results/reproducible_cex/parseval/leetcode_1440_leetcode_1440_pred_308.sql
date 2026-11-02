-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_1327fc', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_ad3cef', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('C', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_2dbf20', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('P', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('B', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_1327fc', 'a_s_11a2b8', 'a_s_ad3cef');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'a_s_11a2b8', 'a_s_ad3cef');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_1327fc', 'a_s_11a2b8', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_1327fc', 'a_s_f04af0', 'a_s_ad3cef');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_1327fc', 'A', 'a_s_ad3cef');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_1327fc', 'exp_fcc4f6', 'a_s_ad3cef');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('P', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_1327fc', 'a_s_11a2b8', 'a_s_ad3cef', 'false')
('C', 'a_s_11a2b8', 'a_s_ad3cef', 'false')
('a_s_1327fc', 'a_s_11a2b8', 'A', 'false')
('a_s_1327fc', 'a_s_f04af0', 'a_s_ad3cef', 'false')
('a_s_1327fc', 'A', 'a_s_ad3cef', 'false')
('a_s_1327fc', 'exp_fcc4f6', 'a_s_ad3cef', 'false')
('P', 'exp_fcc4f6', '@', 'false')
('B', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN VALUE = 1 THEN 'true' ELSE 'false' END AS VALUE FROM (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '<' THEN V1.VALUE < V2.VALUE WHEN OPERATOR = '>' THEN V1.VALUE > V2.VALUE ELSE V1.VALUE = V2.VALUE END AS VALUE FROM VARIABLES AS V1 CROSS JOIN EXPRESSIONS AS E CROSS JOIN VARIABLES AS V2 WHERE V1.NAME = E.LEFT_OPERAND AND V2.NAME = E.RIGHT_OPERAND) AS T;

/*
Prediction Result:
('a_s_1327fc', 'A', 'a_s_ad3cef', 'true')
('a_s_1327fc', 'a_s_11a2b8', 'A', 'true')
('a_s_1327fc', 'a_s_11a2b8', 'a_s_ad3cef', 'true')
('a_s_1327fc', 'a_s_f04af0', 'a_s_ad3cef', 'true')
('a_s_1327fc', 'exp_fcc4f6', 'a_s_ad3cef', 'true')
('C', 'a_s_11a2b8', 'a_s_ad3cef', 'false')
('P', 'exp_fcc4f6', '@', 'false')
('B', 'exp_fcc4f6', '`', 'false')
*/