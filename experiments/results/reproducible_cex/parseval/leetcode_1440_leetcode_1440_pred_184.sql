-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_a0ca24', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_996a16', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('Q', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('I', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_59fc9c', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('@', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('D', -1980249628);

INSERT INTO "variables" ("name", "value") VALUES ('M', -734455130);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a0ca24', 'a_s_92793a', 'a_s_996a16');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a0ca24', '<', 'a_s_996a16');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_92793a', 'a_s_996a16');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a0ca24', 'a_s_92793a', 'Q');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a0ca24', 'a_s_92793a', 'I');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a0ca24', 'a_s_b5d823', 'a_s_996a16');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a0ca24', 'A', 'a_s_996a16');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_a0ca24', 'exp_fcc4f6', 'a_s_996a16');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'E');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('M', 'exp_fcc4f6', 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_a0ca24', 'a_s_92793a', 'a_s_996a16', 'false')
('a_s_a0ca24', '<', 'a_s_996a16', 'false')
('A', 'a_s_92793a', 'a_s_996a16', 'false')
('a_s_a0ca24', 'a_s_92793a', 'Q', 'false')
('a_s_a0ca24', 'a_s_92793a', 'I', 'false')
('a_s_a0ca24', 'a_s_b5d823', 'a_s_996a16', 'false')
('a_s_a0ca24', 'A', 'a_s_996a16', 'false')
('a_s_a0ca24', 'exp_fcc4f6', 'a_s_996a16', 'false')
('@', 'exp_fcc4f6', 'E', 'false')
('M', 'exp_fcc4f6', 'D', 'false')
*/

-- Prediction Query
WITH TEMP AS (SELECT LEFT_OPERAND, E.OPERATOR, RIGHT_OPERAND, CASE E.OPERATOR WHEN '<' THEN (VL.VALUE < VR.VALUE) WHEN '=' THEN (VL.VALUE = VR.VALUE) WHEN '>' THEN (VL.VALUE > VR.VALUE) END AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS VL ON E.LEFT_OPERAND = VL.NAME LEFT JOIN VARIABLES AS VR ON E.RIGHT_OPERAND = VR.NAME) SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE VALUE WHEN 0 THEN 'false' WHEN 1 THEN 'true' END AS VALUE FROM TEMP;

/*
Prediction Result:
('a_s_a0ca24', 'a_s_92793a', 'a_s_996a16', None)
('a_s_a0ca24', '<', 'a_s_996a16', 'false')
('A', 'a_s_92793a', 'a_s_996a16', None)
('a_s_a0ca24', 'a_s_92793a', 'Q', None)
('a_s_a0ca24', 'a_s_92793a', 'I', None)
('a_s_a0ca24', 'a_s_b5d823', 'a_s_996a16', None)
('a_s_a0ca24', 'A', 'a_s_996a16', None)
('a_s_a0ca24', 'exp_fcc4f6', 'a_s_996a16', None)
('@', 'exp_fcc4f6', 'E', None)
('M', 'exp_fcc4f6', 'D', None)
*/