-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_ef40a9', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_e778ce', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('I', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_524c33', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('D', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('B', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ef40a9', 'a_s_db3527', 'a_s_e778ce');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ef40a9', '<', 'a_s_e778ce');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_db3527', 'a_s_e778ce');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ef40a9', 'a_s_db3527', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ef40a9', 'a_s_0d563f', 'a_s_e778ce');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ef40a9', 'A', 'a_s_e778ce');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ef40a9', 'exp_fcc4f6', 'a_s_e778ce');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('`', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_ef40a9', 'a_s_db3527', 'a_s_e778ce', 'false')
('a_s_ef40a9', '<', 'a_s_e778ce', 'false')
('A', 'a_s_db3527', 'a_s_e778ce', 'false')
('a_s_ef40a9', 'a_s_db3527', 'A', 'false')
('a_s_ef40a9', 'a_s_0d563f', 'a_s_e778ce', 'false')
('a_s_ef40a9', 'A', 'a_s_e778ce', 'false')
('a_s_ef40a9', 'exp_fcc4f6', 'a_s_e778ce', 'false')
('`', 'exp_fcc4f6', '@', 'false')
('B', 'exp_fcc4f6', 'D', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN (CASE WHEN V1.VALUE > V2.VALUE = 1 THEN 'true' ELSE 'false' END) WHEN OPERATOR = '=' THEN (CASE WHEN V1.VALUE = V2.VALUE = 1 THEN 'true' ELSE 'false' END) WHEN OPERATOR = '<' THEN (CASE WHEN V1.VALUE < V2.VALUE = 1 THEN 'true' ELSE 'false' END) END AS VALUE FROM EXPRESSIONS CROSS JOIN VARIABLES AS V1 JOIN VARIABLES AS V2 ON V1.NAME = LEFT_OPERAND AND V2.NAME = RIGHT_OPERAND;

/*
Prediction Result:
('a_s_ef40a9', 'a_s_db3527', 'a_s_e778ce', None)
('a_s_ef40a9', '<', 'a_s_e778ce', 'false')
('A', 'a_s_db3527', 'a_s_e778ce', None)
('a_s_ef40a9', 'a_s_db3527', 'A', None)
('a_s_ef40a9', 'a_s_0d563f', 'a_s_e778ce', None)
('a_s_ef40a9', 'A', 'a_s_e778ce', None)
('a_s_ef40a9', 'exp_fcc4f6', 'a_s_e778ce', None)
('`', 'exp_fcc4f6', '@', None)
('B', 'exp_fcc4f6', 'D', None)
*/