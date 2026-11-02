-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_67abee', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_4d7a54', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_fc59f0', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('P', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('C', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_67abee', 'a_s_f0fd0a', 'a_s_4d7a54');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_f0fd0a', 'a_s_4d7a54');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_67abee', 'a_s_f0fd0a', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_f0fd0a', 'a_s_4d7a54');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_67abee', 'a_s_b3064a', 'a_s_4d7a54');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_67abee', 'A', 'a_s_4d7a54');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_67abee', 'exp_fcc4f6', 'a_s_4d7a54');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'exp_fcc4f6', 'P');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_67abee', 'a_s_f0fd0a', 'a_s_4d7a54', 'false')
('G', 'a_s_f0fd0a', 'a_s_4d7a54', 'false')
('a_s_67abee', 'a_s_f0fd0a', 'A', 'false')
('O', 'a_s_f0fd0a', 'a_s_4d7a54', 'false')
('a_s_67abee', 'a_s_b3064a', 'a_s_4d7a54', 'false')
('a_s_67abee', 'A', 'a_s_4d7a54', 'false')
('a_s_67abee', 'exp_fcc4f6', 'a_s_4d7a54', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('C', 'exp_fcc4f6', 'P', 'false')
*/

-- Prediction Query
SELECT A.*, CASE WHEN OPERATOR = '>' THEN CASE WHEN LEFT_NUM.VALUE > RHT_NUM.VALUE THEN 'true' ELSE 'false' END WHEN OPERATOR = '=' THEN CASE WHEN LEFT_NUM.VALUE = RHT_NUM.VALUE THEN 'true' ELSE 'false' END WHEN OPERATOR = '<' THEN CASE WHEN LEFT_NUM.VALUE < RHT_NUM.VALUE THEN 'true' ELSE 'false' END END AS VALUE FROM EXPRESSIONS AS A LEFT JOIN VARIABLES AS LEFT_NUM ON A.LEFT_OPERAND = LEFT_NUM.NAME LEFT JOIN VARIABLES AS RHT_NUM ON A.RIGHT_OPERAND = RHT_NUM.NAME;

/*
Prediction Result:
('a_s_67abee', 'a_s_f0fd0a', 'a_s_4d7a54', None)
('G', 'a_s_f0fd0a', 'a_s_4d7a54', None)
('a_s_67abee', 'a_s_f0fd0a', 'A', None)
('O', 'a_s_f0fd0a', 'a_s_4d7a54', None)
('a_s_67abee', 'a_s_b3064a', 'a_s_4d7a54', None)
('a_s_67abee', 'A', 'a_s_4d7a54', None)
('a_s_67abee', 'exp_fcc4f6', 'a_s_4d7a54', None)
('B', 'exp_fcc4f6', '@', None)
('C', 'exp_fcc4f6', 'P', None)
*/