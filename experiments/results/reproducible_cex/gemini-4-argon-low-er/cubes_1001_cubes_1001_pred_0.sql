-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO College (cName, state, enr) VALUES ('C1', 'CA', 1000);
INSERT INTO College (cName, state, enr) VALUES ('C2', 'CA', 2000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count_distinct_state_ FROM (SELECT COUNT(DISTINCT enr) AS n_distinct FROM (SELECT cname, state, enr, cname_other, state_other, enr_other, AVG(enr) OVER () AS meanenr FROM (SELECT * FROM (SELECT LHS.cname AS cname, LHS.state AS state, LHS.enr AS enr, RHS.cname AS cname_other, RHS.state AS state_other, RHS.enr AS enr_other FROM college AS LHS CROSS JOIN college AS RHS) WHERE (state <> state_other AND enr > enr_other)))) ORDER BY count_distinct_state_;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT state) FROM college WHERE enr > (SELECT AVG(enr) FROM college);

/*
Prediction Result:
(1,)
*/