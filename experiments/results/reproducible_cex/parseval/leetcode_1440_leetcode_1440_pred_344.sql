-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_07101d', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_9fcbdd', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_18da50', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('E', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('B', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('a', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_07101d', 'a_s_ff3a27', 'a_s_9fcbdd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_ff3a27', 'a_s_9fcbdd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_07101d', 'a_s_ff3a27', 'O');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_07101d', 'a_s_bcaf96', 'a_s_9fcbdd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_07101d', 'A', 'a_s_9fcbdd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_07101d', 'exp_fcc4f6', 'a_s_9fcbdd');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('E', 'exp_fcc4f6', '@');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a', 'exp_fcc4f6', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_07101d', 'a_s_ff3a27', 'a_s_9fcbdd', 'false')
('A', 'a_s_ff3a27', 'a_s_9fcbdd', 'false')
('a_s_07101d', 'a_s_ff3a27', 'O', 'false')
('a_s_07101d', 'a_s_bcaf96', 'a_s_9fcbdd', 'false')
('a_s_07101d', 'A', 'a_s_9fcbdd', 'false')
('a_s_07101d', 'exp_fcc4f6', 'a_s_9fcbdd', 'false')
('E', 'exp_fcc4f6', '@', 'false')
('a', 'exp_fcc4f6', 'B', 'false')
*/

-- Prediction Query
SELECT E.*, CASE (CASE OPERATOR WHEN '>' THEN L.VALUE > R.VALUE WHEN '<' THEN L.VALUE < R.VALUE ELSE L.VALUE = R.VALUE END) WHEN 0 THEN 'false' ELSE 'true' END AS VALUE FROM EXPRESSIONS AS E JOIN VARIABLES AS L ON E.LEFT_OPERAND = L.NAME JOIN VARIABLES AS R ON E.RIGHT_OPERAND = R.NAME;

/*
Prediction Result:
('a_s_07101d', 'a_s_ff3a27', 'a_s_9fcbdd', 'true')
('A', 'a_s_ff3a27', 'a_s_9fcbdd', 'false')
('a_s_07101d', 'a_s_ff3a27', 'O', 'false')
('a_s_07101d', 'a_s_bcaf96', 'a_s_9fcbdd', 'true')
('a_s_07101d', 'A', 'a_s_9fcbdd', 'true')
('a_s_07101d', 'exp_fcc4f6', 'a_s_9fcbdd', 'true')
('E', 'exp_fcc4f6', '@', 'false')
('a', 'exp_fcc4f6', 'B', 'false')
*/