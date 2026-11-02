-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_2e7c88', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_091d0b', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('Q', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_48587e', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('P', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('H', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('D', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2e7c88', 'a_s_c32123', 'a_s_091d0b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2e7c88', '<', 'a_s_091d0b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_c32123', 'a_s_091d0b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2e7c88', 'a_s_c32123', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2e7c88', 'a_s_9e18cb', 'a_s_091d0b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2e7c88', 'A', 'a_s_091d0b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2e7c88', 'exp_fcc4f6', 'a_s_091d0b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'P');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', 'H');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_2e7c88', 'a_s_c32123', 'a_s_091d0b', 'false')
('a_s_2e7c88', '<', 'a_s_091d0b', 'false')
('A', 'a_s_c32123', 'a_s_091d0b', 'false')
('a_s_2e7c88', 'a_s_c32123', 'A', 'false')
('a_s_2e7c88', 'a_s_9e18cb', 'a_s_091d0b', 'false')
('a_s_2e7c88', 'A', 'a_s_091d0b', 'false')
('a_s_2e7c88', 'exp_fcc4f6', 'a_s_091d0b', 'false')
('@', 'exp_fcc4f6', 'P', 'false')
('D', 'exp_fcc4f6', 'H', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, (CASE WHEN E.OPERATOR = '<' THEN IIF(V1.VALUE < V2.VALUE, 'true', 'false') WHEN E.OPERATOR = '>' THEN IIF(V1.VALUE > V2.VALUE, 'true', 'false') WHEN E.OPERATOR = '=' THEN IIF(V1.VALUE = V2.VALUE, 'true', 'false') END) AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_2e7c88', 'a_s_c32123', 'a_s_091d0b', None)
('a_s_2e7c88', '<', 'a_s_091d0b', 'false')
('A', 'a_s_c32123', 'a_s_091d0b', None)
('a_s_2e7c88', 'a_s_c32123', 'A', None)
('a_s_2e7c88', 'a_s_9e18cb', 'a_s_091d0b', None)
('a_s_2e7c88', 'A', 'a_s_091d0b', None)
('a_s_2e7c88', 'exp_fcc4f6', 'a_s_091d0b', None)
('@', 'exp_fcc4f6', 'P', None)
('D', 'exp_fcc4f6', 'H', None)
*/