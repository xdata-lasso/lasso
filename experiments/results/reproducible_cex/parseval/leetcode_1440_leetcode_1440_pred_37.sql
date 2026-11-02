-- Schema DDL
CREATE TABLE "Variables" ("name" TEXT(255) PRIMARY KEY, "value" INTEGER);

CREATE TABLE "Expressions" ("left_operand" TEXT(255), "operator" TEXT(255), "right_operand" TEXT(255), PRIMARY KEY ("left_operand", "operator", "right_operand"), FOREIGN KEY ("left_operand") REFERENCES "Variables" ("name"), FOREIGN KEY ("right_operand") REFERENCES "Variables" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: variables --
INSERT INTO "variables" ("name", "value") VALUES ('a_s_ec2114', 1);

INSERT INTO "variables" ("name", "value") VALUES ('a_s_866500', 1);

INSERT INTO "variables" ("name", "value") VALUES ('name_3', 1);

INSERT INTO "variables" ("name", "value") VALUES ('G', 1);

INSERT INTO "variables" ("name", "value") VALUES ('A', -55602865);

INSERT INTO "variables" ("name", "value") VALUES ('O', 1);

INSERT INTO "variables" ("name", "value") VALUES ('b_s_027f0e', -59984348);

INSERT INTO "variables" ("name", "value") VALUES ('B', -664303813);

INSERT INTO "variables" ("name", "value") VALUES ('@', -1022641847);

INSERT INTO "variables" ("name", "value") VALUES ('D', -1726781632);

INSERT INTO "variables" ("name", "value") VALUES ('b', 247012447);

-- Inserting into table: expressions --
INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ec2114', 'a_s_c4022a', 'a_s_866500');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ec2114', '<', 'a_s_866500');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('A', 'a_s_c4022a', 'a_s_866500');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ec2114', 'a_s_c4022a', 'A');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ec2114', 'a_s_023cd3', 'a_s_866500');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ec2114', 'A', 'a_s_866500');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('a_s_ec2114', 'exp_fcc4f6', 'a_s_866500');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('@', 'exp_fcc4f6', 'B');

INSERT INTO "expressions" ("left_operand", "operator", "right_operand") VALUES ('b', 'exp_fcc4f6', 'D');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A.*, CASE WHEN ((B.VALUE < C.VALUE AND A.OPERATOR = '<') OR (B.VALUE = C.VALUE AND A.OPERATOR = '=') OR (B.VALUE > C.VALUE AND A.OPERATOR = '>')) THEN 'true' ELSE 'false' END AS VALUE FROM EXPRESSIONS AS A JOIN VARIABLES AS B ON A.LEFT_OPERAND = B.NAME JOIN VARIABLES AS C ON A.RIGHT_OPERAND = C.NAME;

/*
Gold Result:
('a_s_ec2114', 'a_s_c4022a', 'a_s_866500', 'false')
('a_s_ec2114', '<', 'a_s_866500', 'false')
('A', 'a_s_c4022a', 'a_s_866500', 'false')
('a_s_ec2114', 'a_s_c4022a', 'A', 'false')
('a_s_ec2114', 'a_s_023cd3', 'a_s_866500', 'false')
('a_s_ec2114', 'A', 'a_s_866500', 'false')
('a_s_ec2114', 'exp_fcc4f6', 'a_s_866500', 'false')
('@', 'exp_fcc4f6', 'B', 'false')
('b', 'exp_fcc4f6', 'D', 'false')
*/

-- Prediction Query
SELECT E.LEFT_OPERAND, E.OPERATOR, E.RIGHT_OPERAND, CASE WHEN OPERATOR = '>' THEN IIF(VL.VALUE > VR.VALUE, 'true', 'false') WHEN OPERATOR = '<' THEN IIF(VL.VALUE < VR.VALUE, 'true', 'false') WHEN OPERATOR = '=' THEN IIF(VL.VALUE = VR.VALUE, 'true', 'false') END AS VALUE FROM EXPRESSIONS AS E INNER JOIN VARIABLES AS VL ON VL.NAME = E.LEFT_OPERAND INNER JOIN VARIABLES AS VR ON VR.NAME = E.RIGHT_OPERAND;

/*
Prediction Result:
('a_s_ec2114', 'a_s_c4022a', 'a_s_866500', None)
('a_s_ec2114', '<', 'a_s_866500', 'false')
('A', 'a_s_c4022a', 'a_s_866500', None)
('a_s_ec2114', 'a_s_c4022a', 'A', None)
('a_s_ec2114', 'a_s_023cd3', 'a_s_866500', None)
('a_s_ec2114', 'A', 'a_s_866500', None)
('a_s_ec2114', 'exp_fcc4f6', 'a_s_866500', None)
('@', 'exp_fcc4f6', 'B', None)
('b', 'exp_fcc4f6', 'D', None)
*/