-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: college --
INSERT INTO "college" ("cname", "state", "enr") VALUES ('lhs_9004ff', 'lhs_3fed1b', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('lhs_3aa21f', 'lhs_8d244e', 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "state" FROM (SELECT * FROM "college" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "tryout" WHERE ("ppos" <> 'striker')) AS RHS WHERE (LHS.cname = RHS.cname))) ORDER BY state, "state" NULLS LAST;

/*
Gold Result:
('lhs_3fed1b',)
('lhs_8d244e',)
*/

-- Prediction Query
SELECT T1.state FROM college AS T1 JOIN tryout AS T2 ON T1.cName = T2.cName WHERE T2.pPos = 'striker';

/*
Prediction Result:
*/