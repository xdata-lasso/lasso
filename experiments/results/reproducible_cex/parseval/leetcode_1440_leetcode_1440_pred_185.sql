-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_1bc523', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_83a3fd', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('I', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_7b27ba', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('C', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('D', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_1bc523', 'a_s_ba346b', 'a_s_83a3fd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_ba346b', 'a_s_83a3fd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_1bc523', 'a_s_ba346b', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('I', 'a_s_ba346b', 'a_s_83a3fd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_1bc523', 'a_s_763c08', 'a_s_83a3fd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_1bc523', 'A', 'a_s_83a3fd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_1bc523', 'exp_fcc4f6', 'a_s_83a3fd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_1bc523', 'a_s_ba346b', 'a_s_83a3fd', 'false')
('G', 'a_s_ba346b', 'a_s_83a3fd', 'false')
('a_s_1bc523', 'a_s_ba346b', 'A', 'false')
('I', 'a_s_ba346b', 'a_s_83a3fd', 'false')
('a_s_1bc523', 'a_s_763c08', 'a_s_83a3fd', 'false')
('a_s_1bc523', 'A', 'a_s_83a3fd', 'false')
('a_s_1bc523', 'exp_fcc4f6', 'a_s_83a3fd', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('D', 'exp_fcc4f6', 'C', 'false')
*/

-- Prediction Query
WITH TEMP AS (SELECT LEFT_OPERAND, E.OPERATOR, RIGHT_OPERAND, CASE E.OPERATOR WHEN '<' THEN IIF((VL.VALUE < VR.VALUE), 'true', 'false') WHEN '=' THEN IIF((VL.VALUE = VR.VALUE), 'true', 'false') WHEN '>' THEN IIF((VL.VALUE > VR.VALUE), 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS VL ON E.LEFT_OPERAND = VL.NAME LEFT JOIN VARIABLES AS VR ON E.RIGHT_OPERAND = VR.NAME) SELECT * FROM TEMP;

/*
Prediction Result:
('a_s_1bc523', 'a_s_ba346b', 'a_s_83a3fd', None)
('G', 'a_s_ba346b', 'a_s_83a3fd', None)
('a_s_1bc523', 'a_s_ba346b', 'A', None)
('I', 'a_s_ba346b', 'a_s_83a3fd', None)
('a_s_1bc523', 'a_s_763c08', 'a_s_83a3fd', None)
('a_s_1bc523', 'A', 'a_s_83a3fd', None)
('a_s_1bc523', 'exp_fcc4f6', 'a_s_83a3fd', None)
('B', 'exp_fcc4f6', '@', None)
('D', 'exp_fcc4f6', 'C', None)
*/