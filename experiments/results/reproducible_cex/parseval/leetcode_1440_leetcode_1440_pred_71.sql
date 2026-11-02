-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_eee85d', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_219b72', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('_', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_15dc51', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('B', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('P', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eee85d', 'a_s_22b806', 'a_s_219b72');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_22b806', 'a_s_219b72');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eee85d', 'a_s_22b806', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('_', 'a_s_22b806', 'a_s_219b72');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eee85d', 'a_s_894da8', 'a_s_219b72');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eee85d', 'A', 'a_s_219b72');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eee85d', 'exp_fcc4f6', 'a_s_219b72');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', '`');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', 'P');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_eee85d', 'a_s_22b806', 'a_s_219b72', 'false')
('G', 'a_s_22b806', 'a_s_219b72', 'false')
('a_s_eee85d', 'a_s_22b806', 'A', 'false')
('_', 'a_s_22b806', 'a_s_219b72', 'false')
('a_s_eee85d', 'a_s_894da8', 'a_s_219b72', 'false')
('a_s_eee85d', 'A', 'a_s_219b72', 'false')
('a_s_eee85d', 'exp_fcc4f6', 'a_s_219b72', 'false')
('@', 'exp_fcc4f6', '`', 'false')
('B', 'exp_fcc4f6', 'P', 'false')
*/

-- Prediction Query
WITH CTE1 AS (SELECT LEFT_OPERAND, VALUE AS LEFT_VALUE, OPERATOR, RIGHT_OPERAND AS RESERVED_RIGHT FROM EXPRESSIONS INNER JOIN VARIABLES ON LEFT_OPERAND = NAME), CTE2 AS (SELECT RIGHT_OPERAND, VALUE AS RIGHT_VALUE, OPERATOR, LEFT_OPERAND AS RESERVED_LEFT FROM EXPRESSIONS INNER JOIN VARIABLES ON RIGHT_OPERAND = NAME), CTE3 AS (SELECT LEFT_OPERAND, LEFT_VALUE, A.OPERATOR, RIGHT_OPERAND, RIGHT_VALUE FROM CTE1 AS A INNER JOIN CTE2 AS B ON A.OPERATOR = B.OPERATOR AND LEFT_OPERAND = RESERVED_LEFT AND RIGHT_OPERAND = RESERVED_RIGHT) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(LEFT_VALUE > RIGHT_VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(LEFT_VALUE = RIGHT_VALUE, 'true', 'false') ELSE IIF(LEFT_VALUE < RIGHT_VALUE, 'true', 'false') END AS VALUE FROM CTE3;

/*
Prediction Result:
('a_s_eee85d', 'a_s_22b806', 'a_s_219b72', 'false')
('G', 'a_s_22b806', 'a_s_219b72', 'true')
('a_s_eee85d', 'a_s_22b806', 'A', 'false')
('_', 'a_s_22b806', 'a_s_219b72', 'true')
('a_s_eee85d', 'a_s_894da8', 'a_s_219b72', 'false')
('a_s_eee85d', 'A', 'a_s_219b72', 'false')
('a_s_eee85d', 'exp_fcc4f6', 'a_s_219b72', 'false')
('@', 'exp_fcc4f6', '`', 'false')
('B', 'exp_fcc4f6', 'P', 'false')
*/