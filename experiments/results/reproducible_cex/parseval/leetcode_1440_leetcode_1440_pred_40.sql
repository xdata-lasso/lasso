-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_5f82d6', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_9903da', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('C', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('_', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('O', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('?', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_19e9e0', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('D', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_5f82d6', 'a_s_e25857', 'a_s_9903da');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'a_s_e25857', 'a_s_9903da');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_5f82d6', 'a_s_e25857', '_');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('O', 'a_s_e25857', 'a_s_9903da');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_5f82d6', 'a_s_e25857', '?');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_5f82d6', 'a_s_e929e0', 'a_s_9903da');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_5f82d6', 'A', 'a_s_9903da');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_5f82d6', 'exp_fcc4f6', 'a_s_9903da');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_5f82d6', 'a_s_e25857', 'a_s_9903da', 'false')
('C', 'a_s_e25857', 'a_s_9903da', 'false')
('a_s_5f82d6', 'a_s_e25857', '_', 'false')
('O', 'a_s_e25857', 'a_s_9903da', 'false')
('a_s_5f82d6', 'a_s_e25857', '?', 'false')
('a_s_5f82d6', 'a_s_e929e0', 'a_s_9903da', 'false')
('a_s_5f82d6', 'A', 'a_s_9903da', 'false')
('a_s_5f82d6', 'exp_fcc4f6', 'a_s_9903da', 'false')
('@', 'exp_fcc4f6', 'D', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN E.OPERATOR = '>' THEN IIF(LFT.VALUE > RGT.VALUE, 'true', 'false') WHEN E.OPERATOR = '<' THEN IIF(LFT.VALUE < RGT.VALUE, 'true', 'false') ELSE IIF(LFT.VALUE = RGT.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS LFT ON E.LEFT_OPERAND = LFT.NAME LEFT JOIN VARIABLES AS RGT ON E.RIGHT_OPERAND = RGT.NAME;

/*
Prediction Result:
('a_s_5f82d6', 'a_s_e25857', 'a_s_9903da', 'true')
('C', 'a_s_e25857', 'a_s_9903da', 'false')
('a_s_5f82d6', 'a_s_e25857', '_', 'false')
('O', 'a_s_e25857', 'a_s_9903da', 'false')
('a_s_5f82d6', 'a_s_e25857', '?', 'false')
('a_s_5f82d6', 'a_s_e929e0', 'a_s_9903da', 'true')
('a_s_5f82d6', 'A', 'a_s_9903da', 'true')
('a_s_5f82d6', 'exp_fcc4f6', 'a_s_9903da', 'true')
('@', 'exp_fcc4f6', 'D', 'false')
*/