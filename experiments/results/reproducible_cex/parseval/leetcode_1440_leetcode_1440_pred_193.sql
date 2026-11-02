-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_68817f', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_ee77dc', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_dc31e3', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('H', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('_', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_68817f', 'a_s_b303f1', 'a_s_ee77dc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_68817f', '<', 'a_s_ee77dc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_b303f1', 'a_s_ee77dc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_68817f', 'a_s_b303f1', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_68817f', 'a_s_70968b', 'a_s_ee77dc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_68817f', 'A', 'a_s_ee77dc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_68817f', 'exp_fcc4f6', 'a_s_ee77dc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('H', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('_', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_68817f', 'a_s_b303f1', 'a_s_ee77dc', 'false')
('a_s_68817f', '<', 'a_s_ee77dc', 'false')
('A', 'a_s_b303f1', 'a_s_ee77dc', 'false')
('a_s_68817f', 'a_s_b303f1', 'O', 'false')
('a_s_68817f', 'a_s_70968b', 'a_s_ee77dc', 'false')
('a_s_68817f', 'A', 'a_s_ee77dc', 'false')
('a_s_68817f', 'exp_fcc4f6', 'a_s_ee77dc', 'false')
('H', 'exp_fcc4f6', '@', 'false')
('_', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '<' THEN CASE WHEN (B.VALUE < C.VALUE) = 0 THEN 'false' ELSE 'true' END WHEN OPERATOR = '>' THEN CASE WHEN (B.VALUE > C.VALUE) = 0 THEN 'false' ELSE 'true' END ELSE CASE WHEN (B.VALUE = C.VALUE) = 0 THEN 'false' ELSE 'true' END END AS VALUE FROM EXPRESSIONS AS A LEFT JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME LEFT JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Prediction Result:
('a_s_68817f', 'a_s_b303f1', 'a_s_ee77dc', 'true')
('a_s_68817f', '<', 'a_s_ee77dc', 'false')
('A', 'a_s_b303f1', 'a_s_ee77dc', 'false')
('a_s_68817f', 'a_s_b303f1', 'O', 'false')
('a_s_68817f', 'a_s_70968b', 'a_s_ee77dc', 'true')
('a_s_68817f', 'A', 'a_s_ee77dc', 'true')
('a_s_68817f', 'exp_fcc4f6', 'a_s_ee77dc', 'true')
('H', 'exp_fcc4f6', '@', 'false')
('_', 'exp_fcc4f6', '`', 'false')
*/