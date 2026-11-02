-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_9e1c2b', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_28a198', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('I', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('Q', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('G', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_863f72', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('B', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9e1c2b', 'a_s_c7ebd4', 'a_s_28a198');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_c7ebd4', 'a_s_28a198');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9e1c2b', 'a_s_c7ebd4', 'I');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('Q', 'a_s_c7ebd4', 'a_s_28a198');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9e1c2b', 'a_s_c7ebd4', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9e1c2b', 'a_s_0f3b5f', 'a_s_28a198');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9e1c2b', 'A', 'a_s_28a198');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_9e1c2b', 'exp_fcc4f6', 'a_s_28a198');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_9e1c2b', 'a_s_c7ebd4', 'a_s_28a198', 'false')
('O', 'a_s_c7ebd4', 'a_s_28a198', 'false')
('a_s_9e1c2b', 'a_s_c7ebd4', 'I', 'false')
('Q', 'a_s_c7ebd4', 'a_s_28a198', 'false')
('a_s_9e1c2b', 'a_s_c7ebd4', 'G', 'false')
('a_s_9e1c2b', 'a_s_0f3b5f', 'a_s_28a198', 'false')
('a_s_9e1c2b', 'A', 'a_s_28a198', 'false')
('a_s_9e1c2b', 'exp_fcc4f6', 'a_s_28a198', 'false')
('B', 'exp_fcc4f6', '@', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, (CASE WHEN OPERATOR = '=' THEN IIF(VL.VALUE = VR.VALUE, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(VL.VALUE > VR.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(VL.VALUE < VR.VALUE, 'true', 'false') END) AS VALUE FROM EXPRESSIONS LEFT JOIN VARIABLES AS VL ON VL.NAME = LEFT_OPERAND LEFT JOIN VARIABLES AS VR ON VR.NAME = RIGHT_OPERAND;

/*
Prediction Result:
('a_s_9e1c2b', 'a_s_c7ebd4', 'a_s_28a198', None)
('O', 'a_s_c7ebd4', 'a_s_28a198', None)
('a_s_9e1c2b', 'a_s_c7ebd4', 'I', None)
('Q', 'a_s_c7ebd4', 'a_s_28a198', None)
('a_s_9e1c2b', 'a_s_c7ebd4', 'G', None)
('a_s_9e1c2b', 'a_s_0f3b5f', 'a_s_28a198', None)
('a_s_9e1c2b', 'A', 'a_s_28a198', None)
('a_s_9e1c2b', 'exp_fcc4f6', 'a_s_28a198', None)
('B', 'exp_fcc4f6', '@', None)
*/