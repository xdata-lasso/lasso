-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_74eefe', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_b6ad9b', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_87d55f', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('"', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('H', -1980249628);

INSERT INTO "variables" ("name", "value") VALUES ('b', -734455130);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_74eefe', 'a_s_ac60ee', 'a_s_b6ad9b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_ac60ee', 'a_s_b6ad9b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_74eefe', 'a_s_ac60ee', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_74eefe', 'a_s_3df73d', 'a_s_b6ad9b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_74eefe', 'A', 'a_s_b6ad9b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_74eefe', 'exp_fcc4f6', 'a_s_b6ad9b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', '`');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '"');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('H', 'exp_fcc4f6', 'b');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_74eefe', 'a_s_ac60ee', 'a_s_b6ad9b', 'false')
('O', 'a_s_ac60ee', 'a_s_b6ad9b', 'false')
('a_s_74eefe', 'a_s_ac60ee', 'O', 'false')
('a_s_74eefe', 'a_s_3df73d', 'a_s_b6ad9b', 'false')
('a_s_74eefe', 'A', 'a_s_b6ad9b', 'false')
('a_s_74eefe', 'exp_fcc4f6', 'a_s_b6ad9b', 'false')
('@', 'exp_fcc4f6', '`', 'false')
('B', 'exp_fcc4f6', '"', 'false')
('H', 'exp_fcc4f6', 'b', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '=' THEN IIF(V.VALUE = V2.VALUE, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(V.VALUE > V2.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(V.VALUE < V2.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS V ON E.LEFT_OPERAND = V.NAME JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_74eefe', 'a_s_ac60ee', 'a_s_b6ad9b', None)
('O', 'a_s_ac60ee', 'a_s_b6ad9b', None)
('a_s_74eefe', 'a_s_ac60ee', 'O', None)
('a_s_74eefe', 'a_s_3df73d', 'a_s_b6ad9b', None)
('a_s_74eefe', 'A', 'a_s_b6ad9b', None)
('a_s_74eefe', 'exp_fcc4f6', 'a_s_b6ad9b', None)
('@', 'exp_fcc4f6', '`', None)
('B', 'exp_fcc4f6', '"', None)
('H', 'exp_fcc4f6', 'b', None)
*/