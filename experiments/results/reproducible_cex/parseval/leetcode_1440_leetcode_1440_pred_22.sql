-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_d8c7e5', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_fbf5cc', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('c_s_687e95', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('C', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d8c7e5', 'a_s_d65f2a', 'a_s_fbf5cc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d8c7e5', '<', 'a_s_fbf5cc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_d65f2a', 'a_s_fbf5cc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d8c7e5', 'a_s_d65f2a', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d8c7e5', 'a_s_efe727', 'a_s_fbf5cc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d8c7e5', 'A', 'a_s_fbf5cc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_d8c7e5', 'exp_fcc4f6', 'a_s_fbf5cc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_d8c7e5', 'a_s_d65f2a', 'a_s_fbf5cc', 'false')
('a_s_d8c7e5', '<', 'a_s_fbf5cc', 'false')
('A', 'a_s_d65f2a', 'a_s_fbf5cc', 'false')
('a_s_d8c7e5', 'a_s_d65f2a', 'A', 'false')
('a_s_d8c7e5', 'a_s_efe727', 'a_s_fbf5cc', 'false')
('a_s_d8c7e5', 'A', 'a_s_fbf5cc', 'false')
('a_s_d8c7e5', 'exp_fcc4f6', 'a_s_fbf5cc', 'false')
('C', 'exp_fcc4f6', '@', 'false')
('B', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(V1.VALUE > V2.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(V1.VALUE < V2.VALUE, 'true', 'false') ELSE IIF(V1.VALUE = V2.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_d8c7e5', 'a_s_d65f2a', 'a_s_fbf5cc', 'true')
('a_s_d8c7e5', '<', 'a_s_fbf5cc', 'false')
('A', 'a_s_d65f2a', 'a_s_fbf5cc', 'false')
('a_s_d8c7e5', 'a_s_d65f2a', 'A', 'false')
('a_s_d8c7e5', 'a_s_efe727', 'a_s_fbf5cc', 'true')
('a_s_d8c7e5', 'A', 'a_s_fbf5cc', 'true')
('a_s_d8c7e5', 'exp_fcc4f6', 'a_s_fbf5cc', 'true')
('C', 'exp_fcc4f6', '@', 'false')
('B', 'exp_fcc4f6', '`', 'false')
*/