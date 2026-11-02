-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_67bb95', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_646910', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('C', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('I', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_c028fe', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('@', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_67bb95', 'a_s_dcd1f9', 'a_s_646910');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_67bb95', '<', 'a_s_646910');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_dcd1f9', 'a_s_646910');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_67bb95', 'a_s_dcd1f9', 'C');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('I', 'a_s_dcd1f9', 'a_s_646910');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_67bb95', 'a_s_dcd1f9', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_67bb95', 'a_s_42dea2', 'a_s_646910');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_67bb95', 'A', 'a_s_646910');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_67bb95', 'exp_fcc4f6', 'a_s_646910');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_67bb95', 'a_s_dcd1f9', 'a_s_646910', 'false')
('a_s_67bb95', '<', 'a_s_646910', 'false')
('G', 'a_s_dcd1f9', 'a_s_646910', 'false')
('a_s_67bb95', 'a_s_dcd1f9', 'C', 'false')
('I', 'a_s_dcd1f9', 'a_s_646910', 'false')
('a_s_67bb95', 'a_s_dcd1f9', 'G', 'false')
('a_s_67bb95', 'a_s_42dea2', 'a_s_646910', 'false')
('a_s_67bb95', 'A', 'a_s_646910', 'false')
('a_s_67bb95', 'exp_fcc4f6', 'a_s_646910', 'false')
('B', 'exp_fcc4f6', '@', 'false')
*/

-- Prediction Query
WITH CTE AS (SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, V1.VALUE AS RIGHT_VALUE, V2.VALUE AS LEFT_VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME LEFT JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(LEFT_VALUE > RIGHT_VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(LEFT_VALUE < RIGHT_VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(LEFT_VALUE = RIGHT_VALUE, 'true', 'false') END AS VALUE FROM CTE;

/*
Prediction Result:
('a_s_67bb95', 'a_s_dcd1f9', 'a_s_646910', None)
('a_s_67bb95', '<', 'a_s_646910', 'false')
('G', 'a_s_dcd1f9', 'a_s_646910', None)
('a_s_67bb95', 'a_s_dcd1f9', 'C', None)
('I', 'a_s_dcd1f9', 'a_s_646910', None)
('a_s_67bb95', 'a_s_dcd1f9', 'G', None)
('a_s_67bb95', 'a_s_42dea2', 'a_s_646910', None)
('a_s_67bb95', 'A', 'a_s_646910', None)
('a_s_67bb95', 'exp_fcc4f6', 'a_s_646910', None)
('B', 'exp_fcc4f6', '@', None)
*/