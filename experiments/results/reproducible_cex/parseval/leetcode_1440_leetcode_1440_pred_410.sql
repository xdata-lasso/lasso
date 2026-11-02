-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_8cb285', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_2bd342', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('C', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('_', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_c38aa1', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_8cb285', 'a_s_22e8c4', 'a_s_2bd342');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_8cb285', '<', 'a_s_2bd342');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'a_s_22e8c4', 'a_s_2bd342');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_8cb285', 'a_s_22e8c4', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('_', 'a_s_22e8c4', 'a_s_2bd342');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_8cb285', 'a_s_bce72e', 'a_s_2bd342');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_8cb285', 'A', 'a_s_2bd342');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_8cb285', 'exp_fcc4f6', 'a_s_2bd342');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'E');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_8cb285', 'a_s_22e8c4', 'a_s_2bd342', 'false')
('a_s_8cb285', '<', 'a_s_2bd342', 'false')
('C', 'a_s_22e8c4', 'a_s_2bd342', 'false')
('a_s_8cb285', 'a_s_22e8c4', 'A', 'false')
('_', 'a_s_22e8c4', 'a_s_2bd342', 'false')
('a_s_8cb285', 'a_s_bce72e', 'a_s_2bd342', 'false')
('a_s_8cb285', 'A', 'a_s_2bd342', 'false')
('a_s_8cb285', 'exp_fcc4f6', 'a_s_2bd342', 'false')
('@', 'exp_fcc4f6', 'E', 'false')
*/

-- Prediction Query
SELECT A.LEFT_OPERAND, A.OPERATOR, A.RIGHT_OPERAND, CASE WHEN OPERATOR = '=' THEN IIF(B.VALUE = C.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(B.VALUE < C.VALUE, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(B.VALUE > C.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Prediction Result:
('a_s_8cb285', 'a_s_22e8c4', 'a_s_2bd342', None)
('a_s_8cb285', '<', 'a_s_2bd342', 'false')
('C', 'a_s_22e8c4', 'a_s_2bd342', None)
('a_s_8cb285', 'a_s_22e8c4', 'A', None)
('_', 'a_s_22e8c4', 'a_s_2bd342', None)
('a_s_8cb285', 'a_s_bce72e', 'a_s_2bd342', None)
('a_s_8cb285', 'A', 'a_s_2bd342', None)
('a_s_8cb285', 'exp_fcc4f6', 'a_s_2bd342', None)
('@', 'exp_fcc4f6', 'E', None)
*/