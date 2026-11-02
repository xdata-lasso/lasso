-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_2a583b', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_98f5d6', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('_', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_de995b', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('Q', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2a583b', 'a_s_53ea5a', 'a_s_98f5d6');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2a583b', '<', 'a_s_98f5d6');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_53ea5a', 'a_s_98f5d6');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2a583b', 'a_s_53ea5a', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2a583b', 'a_s_76b4fe', 'a_s_98f5d6');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2a583b', 'A', 'a_s_98f5d6');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2a583b', 'exp_fcc4f6', 'a_s_98f5d6');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'Q');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_2a583b', 'a_s_53ea5a', 'a_s_98f5d6', 'false')
('a_s_2a583b', '<', 'a_s_98f5d6', 'false')
('A', 'a_s_53ea5a', 'a_s_98f5d6', 'false')
('a_s_2a583b', 'a_s_53ea5a', 'A', 'false')
('a_s_2a583b', 'a_s_76b4fe', 'a_s_98f5d6', 'false')
('a_s_2a583b', 'A', 'a_s_98f5d6', 'false')
('a_s_2a583b', 'exp_fcc4f6', 'a_s_98f5d6', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('`', 'exp_fcc4f6', 'Q', 'false')
*/

-- Prediction Query
SELECT E.*, CASE WHEN (CASE WHEN OPERATOR = '=' THEN V1.VALUE = V2.VALUE WHEN OPERATOR = '<' THEN V1.VALUE < V2.VALUE ELSE V1.VALUE > V2.VALUE END) = 1 THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_2a583b', 'a_s_53ea5a', 'a_s_98f5d6', 'false')
('a_s_2a583b', '<', 'a_s_98f5d6', 'false')
('A', 'a_s_53ea5a', 'a_s_98f5d6', 'false')
('a_s_2a583b', 'a_s_53ea5a', 'A', 'true')
('a_s_2a583b', 'a_s_76b4fe', 'a_s_98f5d6', 'false')
('a_s_2a583b', 'A', 'a_s_98f5d6', 'false')
('a_s_2a583b', 'exp_fcc4f6', 'a_s_98f5d6', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('`', 'exp_fcc4f6', 'Q', 'true')
*/