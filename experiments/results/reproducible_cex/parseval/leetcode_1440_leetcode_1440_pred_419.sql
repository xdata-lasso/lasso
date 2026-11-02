-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_78f968', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_3327ab', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('C', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_a3db08', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('!', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('E', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_78f968', 'a_s_7ec33f', 'a_s_3327ab');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_78f968', '<', 'a_s_3327ab');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_7ec33f', 'a_s_3327ab');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_78f968', 'a_s_7ec33f', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_78f968', 'a_s_c43e1e', 'a_s_3327ab');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_78f968', 'A', 'a_s_3327ab');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_78f968', 'exp_fcc4f6', 'a_s_3327ab');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', '!');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('E', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_78f968', 'a_s_7ec33f', 'a_s_3327ab', 'false')
('a_s_78f968', '<', 'a_s_3327ab', 'false')
('A', 'a_s_7ec33f', 'a_s_3327ab', 'false')
('a_s_78f968', 'a_s_7ec33f', 'A', 'false')
('a_s_78f968', 'a_s_c43e1e', 'a_s_3327ab', 'false')
('a_s_78f968', 'A', 'a_s_3327ab', 'false')
('a_s_78f968', 'exp_fcc4f6', 'a_s_3327ab', 'false')
('@', 'exp_fcc4f6', '!', 'false')
('E', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
SELECT V1.NAME AS LEFT_OPERAND, E.OPERATOR, V2.NAME AS RIGHT_OPERAND, CASE WHEN OPERATOR = '=' THEN IIF(V1.VALUE = V2.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(V1.VALUE < V2.VALUE, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(V1.VALUE > V2.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V1 ON V1.NAME = E.LEFT_OPERAND LEFT JOIN VARIABLES AS V2 ON V2.NAME = E.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_78f968', 'a_s_7ec33f', 'a_s_3327ab', None)
('a_s_78f968', '<', 'a_s_3327ab', 'false')
('A', 'a_s_7ec33f', 'a_s_3327ab', None)
('a_s_78f968', 'a_s_7ec33f', 'A', None)
('a_s_78f968', 'a_s_c43e1e', 'a_s_3327ab', None)
('a_s_78f968', 'A', 'a_s_3327ab', None)
('a_s_78f968', 'exp_fcc4f6', 'a_s_3327ab', None)
('@', 'exp_fcc4f6', '!', None)
('E', 'exp_fcc4f6', '`', None)
*/