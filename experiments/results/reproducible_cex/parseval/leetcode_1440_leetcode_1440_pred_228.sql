-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_4c3e9a', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_19669e', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('_', 1);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_d7cf87', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('P', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('`', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('D', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_4c3e9a', 'a_s_9f25bc', 'a_s_19669e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_9f25bc', 'a_s_19669e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_4c3e9a', 'a_s_9f25bc', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_4c3e9a', 'a_s_55fc00', 'a_s_19669e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_4c3e9a', 'A', 'a_s_19669e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_4c3e9a', 'exp_fcc4f6', 'a_s_19669e');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'P');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('D', 'exp_fcc4f6', '`');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_4c3e9a', 'a_s_9f25bc', 'a_s_19669e', 'false')
('A', 'a_s_9f25bc', 'a_s_19669e', 'false')
('a_s_4c3e9a', 'a_s_9f25bc', 'A', 'false')
('a_s_4c3e9a', 'a_s_55fc00', 'a_s_19669e', 'false')
('a_s_4c3e9a', 'A', 'a_s_19669e', 'false')
('a_s_4c3e9a', 'exp_fcc4f6', 'a_s_19669e', 'false')
('@', 'exp_fcc4f6', 'P', 'false')
('D', 'exp_fcc4f6', '`', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, IIF((CASE WHEN OPERATOR = '>' THEN V1.VALUE > V2.VALUE WHEN OPERATOR = '<' THEN V1.VALUE < V2.VALUE ELSE V1.VALUE = V2.VALUE END) = 1, 'true', 'false') AS VALUE FROM EXPRESSIONS AS E LEFT JOIN VARIABLES AS V1 ON E.LEFT_OPERAND = V1.NAME LEFT JOIN VARIABLES AS V2 ON E.RIGHT_OPERAND = V2.NAME;

/*
Prediction Result:
('a_s_4c3e9a', 'a_s_9f25bc', 'a_s_19669e', 'true')
('A', 'a_s_9f25bc', 'a_s_19669e', 'false')
('a_s_4c3e9a', 'a_s_9f25bc', 'A', 'false')
('a_s_4c3e9a', 'a_s_55fc00', 'a_s_19669e', 'true')
('a_s_4c3e9a', 'A', 'a_s_19669e', 'true')
('a_s_4c3e9a', 'exp_fcc4f6', 'a_s_19669e', 'true')
('@', 'exp_fcc4f6', 'P', 'false')
('D', 'exp_fcc4f6', '`', 'false')
*/