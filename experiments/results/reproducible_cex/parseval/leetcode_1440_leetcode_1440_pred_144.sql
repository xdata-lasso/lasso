-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_9de802', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_6c2721', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_57fbb7', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('E', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('C', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('e', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('@', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('!', -1980249628);

INSERT INTO "variables" ("name", "value") VALUES ('D', -734455130);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9de802', 'a_s_28f13c', 'a_s_6c2721');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_28f13c', 'a_s_6c2721');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9de802', 'a_s_28f13c', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9de802', 'a_s_c46115', 'a_s_6c2721');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9de802', 'A', 'a_s_6c2721');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9de802', 'exp_fcc4f6', 'a_s_6c2721');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('E', 'exp_fcc4f6', 'C');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('e', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('!', 'exp_fcc4f6', 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_9de802', 'a_s_28f13c', 'a_s_6c2721', 'false')
('A', 'a_s_28f13c', 'a_s_6c2721', 'false')
('a_s_9de802', 'a_s_28f13c', 'O', 'false')
('a_s_9de802', 'a_s_c46115', 'a_s_6c2721', 'false')
('a_s_9de802', 'A', 'a_s_6c2721', 'false')
('a_s_9de802', 'exp_fcc4f6', 'a_s_6c2721', 'false')
('E', 'exp_fcc4f6', 'C', 'false')
('e', 'exp_fcc4f6', '@', 'false')
('!', 'exp_fcc4f6', 'D', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(L.VALUE > R.VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(L.VALUE = R.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(L.VALUE < R.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS L ON E.LEFT_OPERAND = L.NAME JOIN VARIABLES AS R ON E.RIGHT_OPERAND = R.NAME;

/*
Prediction Result:
('a_s_9de802', 'a_s_28f13c', 'a_s_6c2721', None)
('A', 'a_s_28f13c', 'a_s_6c2721', None)
('a_s_9de802', 'a_s_28f13c', 'O', None)
('a_s_9de802', 'a_s_c46115', 'a_s_6c2721', None)
('a_s_9de802', 'A', 'a_s_6c2721', None)
('a_s_9de802', 'exp_fcc4f6', 'a_s_6c2721', None)
('E', 'exp_fcc4f6', 'C', None)
('e', 'exp_fcc4f6', '@', None)
('!', 'exp_fcc4f6', 'D', None)
*/