-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_55ff6d', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_ec91dc', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', 1);

INSERT INTO "variables" ("name", "value") VALUES ('C', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('_', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_c04536', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('a', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('`', 247012447);

INSERT INTO "variables" ("name", "value") VALUES ('B', -1980249628);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_55ff6d', 'a_s_fd1616', 'a_s_ec91dc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('C', 'a_s_fd1616', 'a_s_ec91dc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_55ff6d', 'a_s_fd1616', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('G', 'a_s_fd1616', 'a_s_ec91dc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_55ff6d', 'a_s_aaacb7', 'a_s_ec91dc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_55ff6d', 'A', 'a_s_ec91dc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_55ff6d', 'exp_fcc4f6', 'a_s_ec91dc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'a');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('B', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_55ff6d', 'a_s_fd1616', 'a_s_ec91dc', 'false')
('C', 'a_s_fd1616', 'a_s_ec91dc', 'false')
('a_s_55ff6d', 'a_s_fd1616', 'A', 'false')
('G', 'a_s_fd1616', 'a_s_ec91dc', 'false')
('a_s_55ff6d', 'a_s_aaacb7', 'a_s_ec91dc', 'false')
('a_s_55ff6d', 'A', 'a_s_ec91dc', 'false')
('a_s_55ff6d', 'exp_fcc4f6', 'a_s_ec91dc', 'false')
('@', 'exp_fcc4f6', 'a', 'false')
('B', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
SELECT X.LEFT_OPERAND, X.OPERATOR, X.RIGHT_OPERAND, CASE WHEN X.VALUE = 1 THEN 'true' ELSE 'false' END AS VALUE FROM (SELECT EXPRESSIONS.*, CASE WHEN OPERATOR = '>' THEN L.VALUE > R.VALUE WHEN OPERATOR = '<' THEN L.VALUE < R.VALUE ELSE L.VALUE = R.VALUE END AS VALUE FROM EXPRESSIONS LEFT JOIN VARIABLES AS L ON EXPRESSIONS.LEFT_OPERAND = L.NAME LEFT JOIN VARIABLES AS R ON EXPRESSIONS.RIGHT_OPERAND = R.NAME) AS X;

/*
Prediction Result:
('a_s_55ff6d', 'a_s_fd1616', 'a_s_ec91dc', 'true')
('C', 'a_s_fd1616', 'a_s_ec91dc', 'false')
('a_s_55ff6d', 'a_s_fd1616', 'A', 'true')
('G', 'a_s_fd1616', 'a_s_ec91dc', 'false')
('a_s_55ff6d', 'a_s_aaacb7', 'a_s_ec91dc', 'true')
('a_s_55ff6d', 'A', 'a_s_ec91dc', 'true')
('a_s_55ff6d', 'exp_fcc4f6', 'a_s_ec91dc', 'true')
('@', 'exp_fcc4f6', 'a', 'false')
('B', 'exp_fcc4f6', '`', 'false')
*/