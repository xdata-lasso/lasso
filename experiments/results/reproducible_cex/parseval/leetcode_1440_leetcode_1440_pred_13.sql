-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_c359cc', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_68dc7a', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('Q', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_a65f8b', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('1', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('a', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c359cc', 'a_s_8a179e', 'a_s_68dc7a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c359cc', '<', 'a_s_68dc7a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_8a179e', 'a_s_68dc7a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c359cc', 'a_s_8a179e', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c359cc', 'a_s_646a48', 'a_s_68dc7a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c359cc', 'A', 'a_s_68dc7a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c359cc', 'exp_fcc4f6', 'a_s_68dc7a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('1', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_c359cc', 'a_s_8a179e', 'a_s_68dc7a', 'false')
('a_s_c359cc', '<', 'a_s_68dc7a', 'false')
('A', 'a_s_8a179e', 'a_s_68dc7a', 'false')
('a_s_c359cc', 'a_s_8a179e', 'O', 'false')
('a_s_c359cc', 'a_s_646a48', 'a_s_68dc7a', 'false')
('a_s_c359cc', 'A', 'a_s_68dc7a', 'false')
('a_s_c359cc', 'exp_fcc4f6', 'a_s_68dc7a', 'false')
('1', 'exp_fcc4f6', '@', 'false')
('a', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
SELECT AGG.LEFT_OPERAND, AGG.OPERATOR, AGG.RIGHT_OPERAND, AGG.VALUE FROM (SELECT E.LEFT_OPERAND, V.VALUE AS LEFT_VALUE, E.OPERATOR, VV.VALUE AS RIGHT_VALUE, E.RIGHT_OPERAND, CASE WHEN E.OPERATOR = '=' THEN IIF(V.VALUE = VV.VALUE, 'true', 'false') WHEN E.OPERATOR = '<' THEN IIF(V.VALUE < VV.VALUE, 'true', 'false') WHEN E.OPERATOR = '>' THEN IIF(V.VALUE > VV.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E INNER JOIN VARIABLES AS V ON E.LEFT_OPERAND = V.NAME INNER JOIN VARIABLES AS VV ON E.RIGHT_OPERAND = VV.NAME) AS AGG;

/*
Prediction Result:
('a_s_c359cc', 'a_s_8a179e', 'a_s_68dc7a', None)
('a_s_c359cc', '<', 'a_s_68dc7a', 'false')
('A', 'a_s_8a179e', 'a_s_68dc7a', None)
('a_s_c359cc', 'a_s_8a179e', 'O', None)
('a_s_c359cc', 'a_s_646a48', 'a_s_68dc7a', None)
('a_s_c359cc', 'A', 'a_s_68dc7a', None)
('a_s_c359cc', 'exp_fcc4f6', 'a_s_68dc7a', None)
('1', 'exp_fcc4f6', '@', None)
('a', 'exp_fcc4f6', '`', None)
*/