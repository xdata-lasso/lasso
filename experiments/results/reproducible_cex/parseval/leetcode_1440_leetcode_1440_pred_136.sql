-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_6b2f0f', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_e91fb4', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('E', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_e1ec48', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('C', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('F', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6b2f0f', 'a_s_cdaf00', 'a_s_e91fb4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6b2f0f', '<', 'a_s_e91fb4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_cdaf00', 'a_s_e91fb4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6b2f0f', 'a_s_cdaf00', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6b2f0f', 'a_s_cdaf00', 'E');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6b2f0f', 'a_s_5c19ca', 'a_s_e91fb4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6b2f0f', 'A', 'a_s_e91fb4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_6b2f0f', 'exp_fcc4f6', 'a_s_e91fb4');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'exp_fcc4f6', 'F');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_6b2f0f', 'a_s_cdaf00', 'a_s_e91fb4', 'false')
('a_s_6b2f0f', '<', 'a_s_e91fb4', 'false')
('A', 'a_s_cdaf00', 'a_s_e91fb4', 'false')
('a_s_6b2f0f', 'a_s_cdaf00', 'O', 'false')
('a_s_6b2f0f', 'a_s_cdaf00', 'E', 'false')
('a_s_6b2f0f', 'a_s_5c19ca', 'a_s_e91fb4', 'false')
('a_s_6b2f0f', 'A', 'a_s_e91fb4', 'false')
('a_s_6b2f0f', 'exp_fcc4f6', 'a_s_e91fb4', 'false')
('B', 'exp_fcc4f6', '@', 'false')
('C', 'exp_fcc4f6', 'F', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, (CASE WHEN OPERATOR = '>' THEN IIF(LFT.VALUE > RIT.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(LFT.VALUE < RIT.VALUE, 'true', 'false') ELSE IIF(LFT.VALUE = RIT.VALUE, 'true', 'false') END) AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS LFT ON E.LEFT_OPERAND = LFT.NAME JOIN VARIABLES AS RIT ON E.RIGHT_OPERAND = RIT.NAME;

/*
Prediction Result:
('a_s_6b2f0f', 'a_s_cdaf00', 'a_s_e91fb4', 'true')
('a_s_6b2f0f', '<', 'a_s_e91fb4', 'false')
('A', 'a_s_cdaf00', 'a_s_e91fb4', 'false')
('a_s_6b2f0f', 'a_s_cdaf00', 'O', 'true')
('a_s_6b2f0f', 'a_s_cdaf00', 'E', 'false')
('a_s_6b2f0f', 'a_s_5c19ca', 'a_s_e91fb4', 'true')
('a_s_6b2f0f', 'A', 'a_s_e91fb4', 'true')
('a_s_6b2f0f', 'exp_fcc4f6', 'a_s_e91fb4', 'true')
('B', 'exp_fcc4f6', '@', 'false')
('C', 'exp_fcc4f6', 'F', 'false')
*/