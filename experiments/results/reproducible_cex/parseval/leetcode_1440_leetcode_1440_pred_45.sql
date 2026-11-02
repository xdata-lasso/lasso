-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_eac52f', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_f383bc', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_fd2b39', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('Q', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('D', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('?', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eac52f', 'a_s_f35f7d', 'a_s_f383bc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eac52f', '<', 'a_s_f383bc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_f35f7d', 'a_s_f383bc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eac52f', 'a_s_f35f7d', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eac52f', 'a_s_857a99', 'a_s_f383bc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eac52f', 'A', 'a_s_f383bc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_eac52f', 'exp_fcc4f6', 'a_s_f383bc');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'Q');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('?', 'exp_fcc4f6', 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_eac52f', 'a_s_f35f7d', 'a_s_f383bc', 'false')
('a_s_eac52f', '<', 'a_s_f383bc', 'false')
('A', 'a_s_f35f7d', 'a_s_f383bc', 'false')
('a_s_eac52f', 'a_s_f35f7d', 'A', 'false')
('a_s_eac52f', 'a_s_857a99', 'a_s_f383bc', 'false')
('a_s_eac52f', 'A', 'a_s_f383bc', 'false')
('a_s_eac52f', 'exp_fcc4f6', 'a_s_f383bc', 'false')
('@', 'exp_fcc4f6', 'Q', 'false')
('?', 'exp_fcc4f6', 'D', 'false')
*/

-- Prediction Query
SELECT LEFT_OPERAND, OPERATOR, RIGHT_OPERAND, (CASE WHEN OPERATOR = '>' THEN IIF((V.VALUE > V1.VALUE) = 1, 'true', 'false') WHEN OPERATOR = '=' THEN IIF((V.VALUE = V1.VALUE) = 1, 'true', 'false') WHEN OPERATOR = '<' THEN IIF((V.VALUE < V1.VALUE) = 1, 'true', 'false') END) AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V ON E.LEFT_OPERAND = V.NAME LEFT JOIN VARIABLES AS V1 ON E.RIGHT_OPERAND = V1.NAME;

/*
Prediction Result:
('a_s_eac52f', 'a_s_f35f7d', 'a_s_f383bc', None)
('a_s_eac52f', '<', 'a_s_f383bc', 'false')
('A', 'a_s_f35f7d', 'a_s_f383bc', None)
('a_s_eac52f', 'a_s_f35f7d', 'A', None)
('a_s_eac52f', 'a_s_857a99', 'a_s_f383bc', None)
('a_s_eac52f', 'A', 'a_s_f383bc', None)
('a_s_eac52f', 'exp_fcc4f6', 'a_s_f383bc', None)
('@', 'exp_fcc4f6', 'Q', None)
('?', 'exp_fcc4f6', 'D', None)
*/