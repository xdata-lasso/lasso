-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_88296f', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_4a8075', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('C', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_4e83d5', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('!', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('D', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_88296f', 'a_s_3b74ac', 'a_s_4a8075');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_3b74ac', 'a_s_4a8075');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_88296f', 'a_s_3b74ac', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'a_s_3b74ac', 'a_s_4a8075');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_88296f', 'a_s_7b5b5f', 'a_s_4a8075');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_88296f', 'A', 'a_s_4a8075');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_88296f', 'exp_fcc4f6', 'a_s_4a8075');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'E');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', '!');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_88296f', 'a_s_3b74ac', 'a_s_4a8075', 'false')
('G', 'a_s_3b74ac', 'a_s_4a8075', 'false')
('a_s_88296f', 'a_s_3b74ac', 'A', 'false')
('C', 'a_s_3b74ac', 'a_s_4a8075', 'false')
('a_s_88296f', 'a_s_7b5b5f', 'a_s_4a8075', 'false')
('a_s_88296f', 'A', 'a_s_4a8075', 'false')
('a_s_88296f', 'exp_fcc4f6', 'a_s_4a8075', 'false')
('@', 'exp_fcc4f6', 'E', 'false')
('D', 'exp_fcc4f6', '!', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN E.OPERATOR = '>' THEN (CASE WHEN L.VALUE > R.VALUE THEN 'true' ELSE 'false' END) WHEN E.OPERATOR = '<' THEN (CASE WHEN L.VALUE < R.VALUE THEN 'true' ELSE 'false' END) WHEN E.OPERATOR = '=' THEN (CASE WHEN L.VALUE = R.VALUE THEN 'true' ELSE 'false' END) ELSE NULL END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS L ON E.LEFT_OPERAND = L.NAME JOIN VARIABLES AS R ON E.RIGHT_OPERAND = R.NAME;

/*
Prediction Result:
('a_s_88296f', 'a_s_3b74ac', 'a_s_4a8075', None)
('G', 'a_s_3b74ac', 'a_s_4a8075', None)
('a_s_88296f', 'a_s_3b74ac', 'A', None)
('C', 'a_s_3b74ac', 'a_s_4a8075', None)
('a_s_88296f', 'a_s_7b5b5f', 'a_s_4a8075', None)
('a_s_88296f', 'A', 'a_s_4a8075', None)
('a_s_88296f', 'exp_fcc4f6', 'a_s_4a8075', None)
('@', 'exp_fcc4f6', 'E', None)
('D', 'exp_fcc4f6', '!', None)
*/