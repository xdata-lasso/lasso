-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_ed81c5', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_fe650e', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('I', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_99fbcf', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('!', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('B', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('Q', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ed81c5', 'a_s_7ea59f', 'a_s_fe650e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ed81c5', '<', 'a_s_fe650e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_7ea59f', 'a_s_fe650e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ed81c5', 'a_s_7ea59f', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('I', 'a_s_7ea59f', 'a_s_fe650e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ed81c5', 'a_s_4edfe3', 'a_s_fe650e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ed81c5', 'A', 'a_s_fe650e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ed81c5', 'exp_fcc4f6', 'a_s_fe650e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', '!');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', 'Q');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_ed81c5', 'a_s_7ea59f', 'a_s_fe650e', 'false')
('a_s_ed81c5', '<', 'a_s_fe650e', 'false')
('O', 'a_s_7ea59f', 'a_s_fe650e', 'false')
('a_s_ed81c5', 'a_s_7ea59f', 'A', 'false')
('I', 'a_s_7ea59f', 'a_s_fe650e', 'false')
('a_s_ed81c5', 'a_s_4edfe3', 'a_s_fe650e', 'false')
('a_s_ed81c5', 'A', 'a_s_fe650e', 'false')
('a_s_ed81c5', 'exp_fcc4f6', 'a_s_fe650e', 'false')
('@', 'exp_fcc4f6', '!', 'false')
('B', 'exp_fcc4f6', 'Q', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '=' THEN IIF(V1.VALUE = V2.VALUE, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(V1.VALUE > V2.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(V1.VALUE < V2.VALUE, 'true', 'false') ELSE NULL END AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V1 ON V1.NAME = LEFT_OPERAND LEFT JOIN VARIABLES AS V2 ON V2.NAME = RIGHT_OPERAND;

/*
Prediction Result:
('a_s_ed81c5', 'a_s_7ea59f', 'a_s_fe650e', None)
('a_s_ed81c5', '<', 'a_s_fe650e', 'false')
('O', 'a_s_7ea59f', 'a_s_fe650e', None)
('a_s_ed81c5', 'a_s_7ea59f', 'A', None)
('I', 'a_s_7ea59f', 'a_s_fe650e', None)
('a_s_ed81c5', 'a_s_4edfe3', 'a_s_fe650e', None)
('a_s_ed81c5', 'A', 'a_s_fe650e', None)
('a_s_ed81c5', 'exp_fcc4f6', 'a_s_fe650e', None)
('@', 'exp_fcc4f6', '!', None)
('B', 'exp_fcc4f6', 'Q', None)
*/