-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_6164d1', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_421103', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('I', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('Q', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_206da1', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('D', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('C', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('B', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6164d1', 'a_s_663482', 'a_s_421103');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6164d1', '<', 'a_s_421103');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_663482', 'a_s_421103');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6164d1', 'a_s_663482', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6164d1', 'a_s_458467', 'a_s_421103');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6164d1', 'A', 'a_s_421103');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6164d1', 'exp_fcc4f6', 'a_s_421103');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_6164d1', 'a_s_663482', 'a_s_421103', 'false')
('a_s_6164d1', '<', 'a_s_421103', 'false')
('A', 'a_s_663482', 'a_s_421103', 'false')
('a_s_6164d1', 'a_s_663482', 'A', 'false')
('a_s_6164d1', 'a_s_458467', 'a_s_421103', 'false')
('a_s_6164d1', 'A', 'a_s_421103', 'false')
('D', 'exp_fcc4f6', '@', 'false')
('a_s_6164d1', 'exp_fcc4f6', 'a_s_421103', 'false')
('C', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT A.LEFT_OPERAND, A.OPERATOR, A.RIGHT_OPERAND, CASE A.OPERATOR WHEN '>' THEN CASE WHEN B.VALUE > C.VALUE THEN 'true' ELSE 'false' END WHEN '=' THEN CASE WHEN B.VALUE = C.VALUE THEN 'true' ELSE 'false' END WHEN '<' THEN CASE WHEN B.VALUE < C.VALUE THEN 'true' ELSE 'false' END END AS VALUE FROM EXPRESSIONS AS A INNER JOIN VARIABLES AS B ON B.NAME = A.LEFT_OPERAND INNER JOIN VARIABLES AS C ON C.NAME = A.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_6164d1', 'a_s_663482', 'a_s_421103', None)
('a_s_6164d1', '<', 'a_s_421103', 'false')
('A', 'a_s_663482', 'a_s_421103', None)
('a_s_6164d1', 'a_s_663482', 'A', None)
('a_s_6164d1', 'a_s_458467', 'a_s_421103', None)
('a_s_6164d1', 'A', 'a_s_421103', None)
('D', 'exp_fcc4f6', '@', None)
('a_s_6164d1', 'exp_fcc4f6', 'a_s_421103', None)
('C', 'exp_fcc4f6', 'B', None)
*/