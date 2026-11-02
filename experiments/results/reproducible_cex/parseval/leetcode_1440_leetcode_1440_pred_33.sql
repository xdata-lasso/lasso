-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_0c7fc3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_2a269e', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_b42a9f', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('P', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('B', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('Q', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_0c7fc3', 'a_s_26cf94', 'a_s_2a269e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_0c7fc3', '<', 'a_s_2a269e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_26cf94', 'a_s_2a269e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_0c7fc3', 'a_s_26cf94', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_0c7fc3', 'a_s_bf3a8e', 'a_s_2a269e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_0c7fc3', 'A', 'a_s_2a269e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_0c7fc3', 'exp_fcc4f6', 'a_s_2a269e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('P', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('Q', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_0c7fc3', 'a_s_26cf94', 'a_s_2a269e', 'false')
('a_s_0c7fc3', '<', 'a_s_2a269e', 'false')
('G', 'a_s_26cf94', 'a_s_2a269e', 'false')
('a_s_0c7fc3', 'a_s_26cf94', 'O', 'false')
('a_s_0c7fc3', 'a_s_bf3a8e', 'a_s_2a269e', 'false')
('a_s_0c7fc3', 'A', 'a_s_2a269e', 'false')
('a_s_0c7fc3', 'exp_fcc4f6', 'a_s_2a269e', 'false')
('P', 'exp_fcc4f6', '@', 'false')
('Q', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN E.OPERATOR = '>' THEN IIF(V1.VALUE > V2.VALUE, 'true', 'false') WHEN E.OPERATOR = '<' THEN IIF(V1.VALUE < V2.VALUE, 'true', 'false') ELSE IIF(V1.VALUE = V2.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME LEFT JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_0c7fc3', 'a_s_26cf94', 'a_s_2a269e', 'true')
('a_s_0c7fc3', '<', 'a_s_2a269e', 'false')
('G', 'a_s_26cf94', 'a_s_2a269e', 'false')
('a_s_0c7fc3', 'a_s_26cf94', 'O', 'false')
('a_s_0c7fc3', 'a_s_bf3a8e', 'a_s_2a269e', 'true')
('a_s_0c7fc3', 'A', 'a_s_2a269e', 'true')
('a_s_0c7fc3', 'exp_fcc4f6', 'a_s_2a269e', 'true')
('P', 'exp_fcc4f6', '@', 'false')
('Q', 'exp_fcc4f6', 'B', 'false')
*/