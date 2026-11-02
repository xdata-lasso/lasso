-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_df90ff', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_9736ec', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('I', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('E', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_6219fb', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('@', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('D', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('C', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_df90ff', 'a_s_5e1e69', 'a_s_9736ec');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_5e1e69', 'a_s_9736ec');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_df90ff', 'a_s_5e1e69', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_df90ff', 'a_s_df0db5', 'a_s_9736ec');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_df90ff', 'A', 'a_s_9736ec');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_df90ff', 'exp_fcc4f6', 'a_s_9736ec');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'B');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_df90ff', 'a_s_5e1e69', 'a_s_9736ec', 'false')
('A', 'a_s_5e1e69', 'a_s_9736ec', 'false')
('a_s_df90ff', 'a_s_5e1e69', 'A', 'false')
('a_s_df90ff', 'a_s_df0db5', 'a_s_9736ec', 'false')
('a_s_df90ff', 'A', 'a_s_9736ec', 'false')
('a_s_df90ff', 'exp_fcc4f6', 'a_s_9736ec', 'false')
('@', 'exp_fcc4f6', 'B', 'false')
('D', 'exp_fcc4f6', 'C', 'false')
*/

-- Prediction Query
SELECT EXPRESSIONS.LEFT_OPERAND, EXPRESSIONS.OPERATOR, EXPRESSIONS.RIGHT_OPERAND, IIF(CASE WHEN EXPRESSIONS.OPERATOR = '>' THEN (VARILEFT.VALUE > VARIRIGHT.VALUE) WHEN EXPRESSIONS.OPERATOR = '<' THEN (VARILEFT.VALUE < VARIRIGHT.VALUE) ELSE (VARILEFT.VALUE = VARIRIGHT.VALUE) END = 0, 'false', 'true') AS VALUE FROM EXPRESSIONS AS EXPRESSIONS JOIN VARIABLES AS VARILEFT ON VARILEFT.NAME = EXPRESSIONS.LEFT_OPERAND JOIN VARIABLES AS VARIRIGHT ON VARIRIGHT.NAME = EXPRESSIONS.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_df90ff', 'a_s_5e1e69', 'a_s_9736ec', 'true')
('A', 'a_s_5e1e69', 'a_s_9736ec', 'false')
('a_s_df90ff', 'a_s_5e1e69', 'A', 'false')
('a_s_df90ff', 'a_s_df0db5', 'a_s_9736ec', 'true')
('a_s_df90ff', 'A', 'a_s_9736ec', 'true')
('a_s_df90ff', 'exp_fcc4f6', 'a_s_9736ec', 'true')
('@', 'exp_fcc4f6', 'B', 'false')
('D', 'exp_fcc4f6', 'C', 'false')
*/