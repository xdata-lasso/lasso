-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_334975', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_03bffe', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_1657eb', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('D', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('P', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('Q', -1980249628);

INSERT INTO "variables" ("name", "value") VALUES ('E', -734455130);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_334975', 'a_s_1e9c5d', 'a_s_03bffe');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_1e9c5d', 'a_s_03bffe');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_334975', 'a_s_1e9c5d', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_334975', 'a_s_85af98', 'a_s_03bffe');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_334975', 'A', 'a_s_03bffe');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_334975', 'exp_fcc4f6', 'a_s_03bffe');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('P', 'exp_fcc4f6', '`');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('Q', 'exp_fcc4f6', 'E');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_334975', 'a_s_1e9c5d', 'a_s_03bffe', 'false')
('A', 'a_s_1e9c5d', 'a_s_03bffe', 'false')
('a_s_334975', 'a_s_1e9c5d', 'A', 'false')
('a_s_334975', 'a_s_85af98', 'a_s_03bffe', 'false')
('a_s_334975', 'A', 'a_s_03bffe', 'false')
('D', 'exp_fcc4f6', '@', 'false')
('a_s_334975', 'exp_fcc4f6', 'a_s_03bffe', 'false')
('P', 'exp_fcc4f6', '`', 'false')
('Q', 'exp_fcc4f6', 'E', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, CASE WHEN OPERATOR = '<' THEN IIF(V1.VALUE < V2.VALUE, 'true', 'false') WHEN OPERATOR = '>' THEN IIF(V1.VALUE < V2.VALUE, 'true', 'false') ELSE IIF(V1.VALUE = V2.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS V1 ON V1.NAME = E.LEFT_OPERAND JOIN VARIABLES AS V2 ON V2.NAME = E.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_334975', 'a_s_1e9c5d', 'a_s_03bffe', 'true')
('A', 'a_s_1e9c5d', 'a_s_03bffe', 'false')
('a_s_334975', 'a_s_1e9c5d', 'A', 'false')
('a_s_334975', 'a_s_85af98', 'a_s_03bffe', 'true')
('a_s_334975', 'A', 'a_s_03bffe', 'true')
('D', 'exp_fcc4f6', '@', 'false')
('a_s_334975', 'exp_fcc4f6', 'a_s_03bffe', 'true')
('P', 'exp_fcc4f6', '`', 'false')
('Q', 'exp_fcc4f6', 'E', 'false')
*/