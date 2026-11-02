-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_b4febe', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_7b4093', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('C', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('/', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_a3227f', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('E', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1980249628);

INSERT INTO "variables" ("name", "value") VALUES ('a', -734455130);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b4febe', 'a_s_9a391f', 'a_s_7b4093');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'a_s_9a391f', 'a_s_7b4093');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b4febe', 'a_s_9a391f', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_9a391f', 'a_s_7b4093');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b4febe', 'a_s_9a391f', '/');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b4febe', 'a_s_dab0c2', 'a_s_7b4093');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b4febe', 'A', 'a_s_7b4093');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_b4febe', 'exp_fcc4f6', 'a_s_7b4093');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'E');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'a');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_b4febe', 'a_s_9a391f', 'a_s_7b4093', 'false')
('C', 'a_s_9a391f', 'a_s_7b4093', 'false')
('a_s_b4febe', 'a_s_9a391f', 'O', 'false')
('O', 'a_s_9a391f', 'a_s_7b4093', 'false')
('a_s_b4febe', 'a_s_9a391f', '/', 'false')
('a_s_b4febe', 'a_s_dab0c2', 'a_s_7b4093', 'false')
('a_s_b4febe', 'A', 'a_s_7b4093', 'false')
('a_s_b4febe', 'exp_fcc4f6', 'a_s_7b4093', 'false')
('@', 'exp_fcc4f6', 'E', 'false')
('`', 'exp_fcc4f6', 'a', 'false')
*/

-- Prediction Query
SELECT E.*, CASE WHEN E.OPERATOR = '>' THEN CASE WHEN L.VALUE > R.VALUE THEN 'true' ELSE 'false' END WHEN E.OPERATOR = '=' THEN CASE WHEN L.VALUE = R.VALUE THEN 'true' ELSE 'false' END WHEN E.OPERATOR = '<' THEN CASE WHEN L.VALUE < R.VALUE THEN 'true' ELSE 'false' END END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS L ON E.LEFT_OPERAND = L.NAME JOIN VARIABLES AS R ON E.RIGHT_OPERAND = R.NAME;

/*
Prediction Result:
('a_s_b4febe', 'a_s_9a391f', 'a_s_7b4093', None)
('C', 'a_s_9a391f', 'a_s_7b4093', None)
('a_s_b4febe', 'a_s_9a391f', 'O', None)
('O', 'a_s_9a391f', 'a_s_7b4093', None)
('a_s_b4febe', 'a_s_9a391f', '/', None)
('a_s_b4febe', 'a_s_dab0c2', 'a_s_7b4093', None)
('a_s_b4febe', 'A', 'a_s_7b4093', None)
('a_s_b4febe', 'exp_fcc4f6', 'a_s_7b4093', None)
('@', 'exp_fcc4f6', 'E', None)
('`', 'exp_fcc4f6', 'a', None)
*/