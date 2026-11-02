-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_c68daf', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_250e43', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_40c780', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('D', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('b', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c68daf', 'a_s_ad4763', 'a_s_250e43');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c68daf', '<', 'a_s_250e43');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_ad4763', 'a_s_250e43');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c68daf', 'a_s_ad4763', 'G');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c68daf', 'a_s_ad4763', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c68daf', 'a_s_721f58', 'a_s_250e43');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c68daf', 'A', 'a_s_250e43');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_c68daf', 'exp_fcc4f6', 'a_s_250e43');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', 'b');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_c68daf', 'a_s_ad4763', 'a_s_250e43', 'false')
('a_s_c68daf', '<', 'a_s_250e43', 'false')
('A', 'a_s_ad4763', 'a_s_250e43', 'false')
('a_s_c68daf', 'a_s_ad4763', 'G', 'false')
('a_s_c68daf', 'a_s_ad4763', 'O', 'false')
('a_s_c68daf', 'a_s_721f58', 'a_s_250e43', 'false')
('a_s_c68daf', 'A', 'a_s_250e43', 'false')
('a_s_c68daf', 'exp_fcc4f6', 'a_s_250e43', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('D', 'exp_fcc4f6', 'b', 'false')
*/

-- Prediction Query
WITH CTE AS (SELECT V.VALUE AS LEFT_, E.LEFT_OPERAND, E.OPERATOR, ROW_NUMBER() OVER () AS RN FROM VARIABLES AS V INNER JOIN EXPRESSIONS AS E ON V.NAME = E.LEFT_OPERAND), CTE1 AS (SELECT V.VALUE AS RIGHT_, E.RIGHT_OPERAND, ROW_NUMBER() OVER () AS RN FROM VARIABLES AS V INNER JOIN EXPRESSIONS AS E ON V.NAME = E.RIGHT_OPERAND) SELECT CTE.LEFT_OPERAND, CTE.OPERATOR, CTE1.RIGHT_OPERAND, CASE WHEN CTE.OPERATOR = '=' THEN CASE WHEN CTE.LEFT_ = CTE1.RIGHT_ THEN 'true' ELSE 'false' END WHEN CTE.OPERATOR = '>' THEN CASE WHEN CTE.LEFT_ > CTE1.RIGHT_ THEN 'true' ELSE 'false' END WHEN CTE.OPERATOR = '<' THEN CASE WHEN CTE.LEFT_ < CTE1.RIGHT_ THEN 'true' ELSE 'false' END END AS VALUE FROM CTE INNER JOIN CTE1 ON CTE.RN = CTE1.RN;

/*
Prediction Result:
('a_s_c68daf', 'a_s_ad4763', 'a_s_250e43', None)
('a_s_c68daf', '<', 'a_s_250e43', 'false')
('A', 'a_s_ad4763', 'a_s_250e43', None)
('a_s_c68daf', 'a_s_ad4763', 'G', None)
('a_s_c68daf', 'a_s_ad4763', 'O', None)
('a_s_c68daf', 'a_s_721f58', 'a_s_250e43', None)
('a_s_c68daf', 'A', 'a_s_250e43', None)
('a_s_c68daf', 'exp_fcc4f6', 'a_s_250e43', None)
('B', 'exp_fcc4f6', '@', None)
('D', 'exp_fcc4f6', 'b', None)
*/