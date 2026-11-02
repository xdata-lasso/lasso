-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_9acf52', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_d3e700', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_4b2818', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('B', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('C', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('S', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9acf52', 'a_s_0944da', 'a_s_d3e700');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_0944da', 'a_s_d3e700');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9acf52', 'a_s_0944da', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_0944da', 'a_s_d3e700');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9acf52', 'a_s_bf9d27', 'a_s_d3e700');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9acf52', 'A', 'a_s_d3e700');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9acf52', 'exp_fcc4f6', 'a_s_d3e700');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'B');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('S', 'exp_fcc4f6', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_9acf52', 'a_s_0944da', 'a_s_d3e700', 'false')
('G', 'a_s_0944da', 'a_s_d3e700', 'false')
('a_s_9acf52', 'a_s_0944da', 'A', 'false')
('O', 'a_s_0944da', 'a_s_d3e700', 'false')
('a_s_9acf52', 'a_s_bf9d27', 'a_s_d3e700', 'false')
('a_s_9acf52', 'A', 'a_s_d3e700', 'false')
('a_s_9acf52', 'exp_fcc4f6', 'a_s_d3e700', 'false')
('@', 'exp_fcc4f6', 'B', 'false')
('S', 'exp_fcc4f6', 'C', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN E.OPERATOR = '>' THEN IIF(V1.VALUE > V2.VALUE, 'true', 'false') WHEN E.OPERATOR = '=' THEN IIF(V1.VALUE = V2.VALUE, 'true', 'false') WHEN E.OPERATOR = '<' THEN IIF(V1.VALUE < V2.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_9acf52', 'a_s_0944da', 'a_s_d3e700', None)
('G', 'a_s_0944da', 'a_s_d3e700', None)
('a_s_9acf52', 'a_s_0944da', 'A', None)
('O', 'a_s_0944da', 'a_s_d3e700', None)
('a_s_9acf52', 'a_s_bf9d27', 'a_s_d3e700', None)
('a_s_9acf52', 'A', 'a_s_d3e700', None)
('a_s_9acf52', 'exp_fcc4f6', 'a_s_d3e700', None)
('@', 'exp_fcc4f6', 'B', None)
('S', 'exp_fcc4f6', 'C', None)
*/