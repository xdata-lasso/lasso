-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_c70681', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_b9d3f9', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_8ead91', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('B', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('C', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c70681', 'a_s_35e7c7', 'a_s_b9d3f9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c70681', '<', 'a_s_b9d3f9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_35e7c7', 'a_s_b9d3f9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c70681', 'a_s_35e7c7', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_35e7c7', 'a_s_b9d3f9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c70681', 'a_s_9cc767', 'a_s_b9d3f9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c70681', 'A', 'a_s_b9d3f9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c70681', 'exp_fcc4f6', 'a_s_b9d3f9');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'B');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_c70681', 'a_s_35e7c7', 'a_s_b9d3f9', 'false')
('a_s_c70681', '<', 'a_s_b9d3f9', 'false')
('G', 'a_s_35e7c7', 'a_s_b9d3f9', 'false')
('a_s_c70681', 'a_s_35e7c7', 'A', 'false')
('O', 'a_s_35e7c7', 'a_s_b9d3f9', 'false')
('a_s_c70681', 'a_s_9cc767', 'a_s_b9d3f9', 'false')
('a_s_c70681', 'A', 'a_s_b9d3f9', 'false')
('a_s_c70681', 'exp_fcc4f6', 'a_s_b9d3f9', 'false')
('@', 'exp_fcc4f6', 'B', 'false')
('C', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
SELECT E.*, CASE WHEN OPERATOR = '>' THEN CASE WHEN V1.VALUE > V2.VALUE THEN 'true' ELSE 'false' END WHEN OPERATOR = '=' THEN CASE WHEN V1.VALUE = V2.VALUE THEN 'true' ELSE 'false' END WHEN OPERATOR = '<' THEN CASE WHEN V1.VALUE < V2.VALUE THEN 'true' ELSE 'false' END END AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME LEFT JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_c70681', 'a_s_35e7c7', 'a_s_b9d3f9', None)
('a_s_c70681', '<', 'a_s_b9d3f9', 'false')
('G', 'a_s_35e7c7', 'a_s_b9d3f9', None)
('a_s_c70681', 'a_s_35e7c7', 'A', None)
('O', 'a_s_35e7c7', 'a_s_b9d3f9', None)
('a_s_c70681', 'a_s_9cc767', 'a_s_b9d3f9', None)
('a_s_c70681', 'A', 'a_s_b9d3f9', None)
('a_s_c70681', 'exp_fcc4f6', 'a_s_b9d3f9', None)
('@', 'exp_fcc4f6', 'B', None)
('C', 'exp_fcc4f6', '`', None)
*/