-- Schema DDL
CREATE TABLE "aircraft" ("aid" INTEGER, "aname" TEXT, "crusingrange" INTEGER);

CREATE TABLE "employees" ("eid" INTEGER, "ename" TEXT, "salary" REAL);

CREATE TABLE "certified" ("eid" INTEGER, "aid" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "aircraft" ("aid", "aname", "crusingrange") VALUES (1007, 'Cristian Santos', 1008);
INSERT INTO "certified" ("eid", "aid") VALUES (1009, 1007);
INSERT INTO "employees" ("eid", "ename", "salary") VALUES (1009, 'Connie Lawrence', 80000);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT aname FROM (SELECT LHS.aid AS aid, LHS.aname AS aname, LHS.crusingrange AS crusingrange, LHS.eid AS eid, LHS.ename AS ename, LHS.salary AS salary FROM (SELECT LHS.aid AS aid, LHS.aname AS aname, LHS.crusingrange AS crusingrange, RHS.eid AS eid, RHS.ename AS ename, RHS.salary AS salary FROM aircraft AS LHS CROSS JOIN employees AS RHS) AS LHS INNER JOIN certified AS RHS ON (LHS.aid = RHS.aid AND LHS.eid = RHS.eid)) WHERE (salary > 80000.0) ORDER BY aname;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT A.aname FROM aircraft AS A WHERE A.Aid IN (SELECT C.aid FROM certified AS C CROSS JOIN employees AS E WHERE C.eid = E.eid AND NOT EXISTS(SELECT * FROM employees AS E1 WHERE E1.eid = E.eid AND E1.salary < 80000));

/*
Prediction Result:
('Cristian Santos',)
*/