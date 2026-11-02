-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_2c4e49', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_d519db', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_dc9b16', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('a', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('D', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2c4e49', 'a_s_9cc1e9', 'a_s_d519db');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2c4e49', '<', 'a_s_d519db');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_9cc1e9', 'a_s_d519db');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2c4e49', 'a_s_9cc1e9', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2c4e49', 'a_s_417ced', 'a_s_d519db');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2c4e49', 'A', 'a_s_d519db');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_2c4e49', 'exp_fcc4f6', 'a_s_d519db');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_2c4e49', 'a_s_9cc1e9', 'a_s_d519db', 'false')
('a_s_2c4e49', '<', 'a_s_d519db', 'false')
('A', 'a_s_9cc1e9', 'a_s_d519db', 'false')
('a_s_2c4e49', 'a_s_9cc1e9', 'A', 'false')
('a_s_2c4e49', 'a_s_417ced', 'a_s_d519db', 'false')
('a_s_2c4e49', 'A', 'a_s_d519db', 'false')
('a_s_2c4e49', 'exp_fcc4f6', 'a_s_d519db', 'false')
('a', 'exp_fcc4f6', '@', 'false')
('D', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '<' THEN IIF(VL.VALUE < VR.VALUE, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(VL.VALUE > VR.VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(VL.VALUE = VR.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS VL ON E.LEFT_OPERAND = VL.NAME JOIN VARIABLES AS VR ON E.RIGHT_OPERAND = VR.NAME;

/*
Prediction Result:
('a_s_2c4e49', 'a_s_9cc1e9', 'a_s_d519db', None)
('a_s_2c4e49', '<', 'a_s_d519db', 'false')
('A', 'a_s_9cc1e9', 'a_s_d519db', None)
('a_s_2c4e49', 'a_s_9cc1e9', 'A', None)
('a_s_2c4e49', 'a_s_417ced', 'a_s_d519db', None)
('a_s_2c4e49', 'A', 'a_s_d519db', None)
('a_s_2c4e49', 'exp_fcc4f6', 'a_s_d519db', None)
('a', 'exp_fcc4f6', '@', None)
('D', 'exp_fcc4f6', '`', None)
*/