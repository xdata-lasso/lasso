-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_5b22e0', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_996a2b', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_6bcedd', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('B', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('E', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_5b22e0', 'a_s_25a64f', 'a_s_996a2b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_25a64f', 'a_s_996a2b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_5b22e0', 'a_s_25a64f', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_5b22e0', 'a_s_2e6701', 'a_s_996a2b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_5b22e0', 'A', 'a_s_996a2b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_5b22e0', 'exp_fcc4f6', 'a_s_996a2b');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'E');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_5b22e0', 'a_s_25a64f', 'a_s_996a2b', 'false')
('A', 'a_s_25a64f', 'a_s_996a2b', 'false')
('a_s_5b22e0', 'a_s_25a64f', 'A', 'false')
('a_s_5b22e0', 'a_s_2e6701', 'a_s_996a2b', 'false')
('a_s_5b22e0', 'A', 'a_s_996a2b', 'false')
('a_s_5b22e0', 'exp_fcc4f6', 'a_s_996a2b', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('`', 'exp_fcc4f6', 'E', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE OPERATOR WHEN '>' THEN IIF(LEFTVARIABLES.VALUE > RIGHTVARIABLES.VALUE, 'true', 'false') WHEN '<' THEN IIF(LEFTVARIABLES.VALUE < RIGHTVARIABLES.VALUE, 'true', 'false') ELSE IIF(LEFTVARIABLES.VALUE = RIGHTVARIABLES.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS JOIN VARIABLES AS LEFTVARIABLES ON LEFT_OPERAND = LEFTVARIABLES.NAME JOIN VARIABLES AS RIGHTVARIABLES ON RIGHT_OPERAND = RIGHTVARIABLES.NAME;

/*
Prediction Result:
('a_s_5b22e0', 'a_s_25a64f', 'a_s_996a2b', 'true')
('A', 'a_s_25a64f', 'a_s_996a2b', 'false')
('a_s_5b22e0', 'a_s_25a64f', 'A', 'false')
('a_s_5b22e0', 'a_s_2e6701', 'a_s_996a2b', 'true')
('a_s_5b22e0', 'A', 'a_s_996a2b', 'true')
('a_s_5b22e0', 'exp_fcc4f6', 'a_s_996a2b', 'true')
('B', 'exp_fcc4f6', '@', 'false')
('`', 'exp_fcc4f6', 'E', 'false')
*/