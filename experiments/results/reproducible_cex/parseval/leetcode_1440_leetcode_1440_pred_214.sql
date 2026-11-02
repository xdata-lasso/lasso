-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_f185a4', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_7a4a57', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('C', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('Q', 1);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_c85bc8', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('#', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('H', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('K', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f185a4', 'a_s_1a9110', 'a_s_7a4a57');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'a_s_1a9110', 'a_s_7a4a57');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f185a4', 'a_s_1a9110', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_1a9110', 'a_s_7a4a57');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f185a4', 'a_s_1552e1', 'a_s_7a4a57');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f185a4', 'A', 'a_s_7a4a57');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_f185a4', 'exp_fcc4f6', 'a_s_7a4a57');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('#', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('H', 'exp_fcc4f6', 'K');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_f185a4', 'a_s_1a9110', 'a_s_7a4a57', 'false')
('C', 'a_s_1a9110', 'a_s_7a4a57', 'false')
('a_s_f185a4', 'a_s_1a9110', 'A', 'false')
('G', 'a_s_1a9110', 'a_s_7a4a57', 'false')
('a_s_f185a4', 'a_s_1552e1', 'a_s_7a4a57', 'false')
('a_s_f185a4', 'A', 'a_s_7a4a57', 'false')
('a_s_f185a4', 'exp_fcc4f6', 'a_s_7a4a57', 'false')
('#', 'exp_fcc4f6', '@', 'false')
('H', 'exp_fcc4f6', 'K', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN E.OPERATOR = '<' THEN CASE WHEN V1.VALUE < V2.VALUE THEN 'true' ELSE 'false' END WHEN E.OPERATOR = '=' THEN CASE WHEN V1.VALUE = V2.VALUE THEN 'true' ELSE 'false' END ELSE CASE WHEN V1.VALUE > V2.VALUE THEN 'true' ELSE 'false' END END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_f185a4', 'a_s_1a9110', 'a_s_7a4a57', 'false')
('C', 'a_s_1a9110', 'a_s_7a4a57', 'false')
('a_s_f185a4', 'a_s_1a9110', 'A', 'false')
('G', 'a_s_1a9110', 'a_s_7a4a57', 'false')
('a_s_f185a4', 'a_s_1552e1', 'a_s_7a4a57', 'false')
('a_s_f185a4', 'A', 'a_s_7a4a57', 'false')
('a_s_f185a4', 'exp_fcc4f6', 'a_s_7a4a57', 'false')
('#', 'exp_fcc4f6', '@', 'true')
('H', 'exp_fcc4f6', 'K', 'true')
*/