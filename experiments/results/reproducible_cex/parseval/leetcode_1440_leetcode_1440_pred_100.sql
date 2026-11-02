-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_fa2ba8', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_d112cb', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('_', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_438ba8', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('D', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('Q', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fa2ba8', 'a_s_4ee2c3', 'a_s_d112cb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fa2ba8', '<', 'a_s_d112cb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_4ee2c3', 'a_s_d112cb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fa2ba8', 'a_s_4ee2c3', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('_', 'a_s_4ee2c3', 'a_s_d112cb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fa2ba8', 'a_s_4cb3f9', 'a_s_d112cb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fa2ba8', 'A', 'a_s_d112cb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_fa2ba8', 'exp_fcc4f6', 'a_s_d112cb');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', 'Q');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_fa2ba8', 'a_s_4ee2c3', 'a_s_d112cb', 'false')
('a_s_fa2ba8', '<', 'a_s_d112cb', 'false')
('G', 'a_s_4ee2c3', 'a_s_d112cb', 'false')
('a_s_fa2ba8', 'a_s_4ee2c3', 'A', 'false')
('_', 'a_s_4ee2c3', 'a_s_d112cb', 'false')
('a_s_fa2ba8', 'a_s_4cb3f9', 'a_s_d112cb', 'false')
('a_s_fa2ba8', 'A', 'a_s_d112cb', 'false')
('a_s_fa2ba8', 'exp_fcc4f6', 'a_s_d112cb', 'false')
('D', 'exp_fcc4f6', '@', 'false')
('`', 'exp_fcc4f6', 'Q', 'false')
*/

-- Prediction Query
SELECT E.*, (CASE WHEN E.OPERATOR = '<' THEN IIF(VX.VALUE < VY.VALUE, 'true', 'false') WHEN E.OPERATOR = '=' THEN IIF(VX.VALUE = VY.VALUE, 'true', 'false') WHEN E.OPERATOR = '>' THEN IIF(VX.VALUE > VY.VALUE, 'true', 'false') END) AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS VX ON E.LEFT_OPERAND = VX.NAME JOIN VARIABLES AS VY ON E.RIGHT_OPERAND = VY.NAME;

/*
Prediction Result:
('a_s_fa2ba8', 'a_s_4ee2c3', 'a_s_d112cb', None)
('a_s_fa2ba8', '<', 'a_s_d112cb', 'false')
('G', 'a_s_4ee2c3', 'a_s_d112cb', None)
('a_s_fa2ba8', 'a_s_4ee2c3', 'A', None)
('_', 'a_s_4ee2c3', 'a_s_d112cb', None)
('a_s_fa2ba8', 'a_s_4cb3f9', 'a_s_d112cb', None)
('a_s_fa2ba8', 'A', 'a_s_d112cb', None)
('a_s_fa2ba8', 'exp_fcc4f6', 'a_s_d112cb', None)
('D', 'exp_fcc4f6', '@', None)
('`', 'exp_fcc4f6', 'Q', None)
*/