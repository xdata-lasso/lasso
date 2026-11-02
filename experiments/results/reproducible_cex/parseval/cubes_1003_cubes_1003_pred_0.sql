-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: college --
INSERT INTO "college" ("cname", "state", "enr") VALUES ('col_4ff961', 'e4', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('col_f15ec8', 'col_e2225c', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('col_330d09', 'col_9fb1f7', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n_distinct AS count_distinct_state_ FROM (SELECT cname, COUNT(DISTINCT state) AS n_distinct FROM (SELECT cname, state, enr, AVG(enr) OVER () AS meanenr FROM college) GROUP BY cname) ORDER BY count_distinct_state_;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT state) FROM college WHERE enr < (SELECT AVG(enr) FROM college);

/*
Prediction Result:
(0,)
*/