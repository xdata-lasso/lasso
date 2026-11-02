-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: college --
INSERT INTO "college" ("cname", "state", "enr") VALUES ('col_98be23', 'col_9a106f', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('lhs_77dff6', 'A', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('rhs_6adbce', 'C', 0.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('col_b15dfc', 'col_d7bc4b', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('lhs_4c17c2', 'O', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('rhs_d8b9a7', 'A', 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count_distinct_state_ FROM (SELECT COUNT(DISTINCT enr) AS n_distinct FROM (SELECT cname, state, enr, cname_other, state_other, enr_other, AVG(enr) OVER () AS meanenr FROM (SELECT * FROM (SELECT LHS.cname AS cname, LHS.state AS state, LHS.enr AS enr, RHS.cname AS cname_other, RHS.state AS state_other, RHS.enr AS enr_other FROM college AS LHS CROSS JOIN college AS RHS) WHERE (state <> state_other AND enr > enr_other)))) ORDER BY count_distinct_state_;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT state) FROM college WHERE enr > (SELECT AVG(enr) FROM college);

/*
Prediction Result:
(4,)
*/