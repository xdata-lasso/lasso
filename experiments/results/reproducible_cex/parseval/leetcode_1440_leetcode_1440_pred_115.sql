-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_f36fe7', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_a7ad9f', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('C', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_21dcc0', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('D', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f36fe7', 'a_s_2be231', 'a_s_a7ad9f');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f36fe7', '<', 'a_s_a7ad9f');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_2be231', 'a_s_a7ad9f');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f36fe7', 'a_s_2be231', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'a_s_2be231', 'a_s_a7ad9f');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f36fe7', 'a_s_06606e', 'a_s_a7ad9f');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f36fe7', 'A', 'a_s_a7ad9f');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f36fe7', 'exp_fcc4f6', 'a_s_a7ad9f');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_f36fe7', 'a_s_2be231', 'a_s_a7ad9f', 'false')
('a_s_f36fe7', '<', 'a_s_a7ad9f', 'false')
('G', 'a_s_2be231', 'a_s_a7ad9f', 'false')
('a_s_f36fe7', 'a_s_2be231', 'A', 'false')
('C', 'a_s_2be231', 'a_s_a7ad9f', 'false')
('a_s_f36fe7', 'a_s_06606e', 'a_s_a7ad9f', 'false')
('a_s_f36fe7', 'A', 'a_s_a7ad9f', 'false')
('a_s_f36fe7', 'exp_fcc4f6', 'a_s_a7ad9f', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('`', 'exp_fcc4f6', 'D', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(V1.VALUE > V2.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(V1.VALUE < V2.VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(V1.VALUE = V2.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME LEFT JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_f36fe7', 'a_s_2be231', 'a_s_a7ad9f', None)
('a_s_f36fe7', '<', 'a_s_a7ad9f', 'false')
('G', 'a_s_2be231', 'a_s_a7ad9f', None)
('a_s_f36fe7', 'a_s_2be231', 'A', None)
('C', 'a_s_2be231', 'a_s_a7ad9f', None)
('a_s_f36fe7', 'a_s_06606e', 'a_s_a7ad9f', None)
('a_s_f36fe7', 'A', 'a_s_a7ad9f', None)
('a_s_f36fe7', 'exp_fcc4f6', 'a_s_a7ad9f', None)
('B', 'exp_fcc4f6', '@', None)
('`', 'exp_fcc4f6', 'D', None)
*/