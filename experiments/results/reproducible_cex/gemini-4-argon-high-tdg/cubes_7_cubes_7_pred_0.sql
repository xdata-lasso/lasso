-- Schema DDL
CREATE TABLE "aircraft" ("aid" INTEGER, "aname" TEXT, "crusingrange" INTEGER);

CREATE TABLE "employees" ("eid" INTEGER, "ename" TEXT, "salary" REAL);

CREATE TABLE "certified" ("eid" INTEGER, "aid" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO aircraft (aid, aname, crusingrange) VALUES (10, 'Zeppelin', 1000);
INSERT INTO aircraft (aid, aname, crusingrange) VALUES (20, 'Boeing 747', 5000);
INSERT INTO aircraft (aid, aname, crusingrange) VALUES (5, 'Airbus A380', 3000);
INSERT INTO aircraft (aid, aname, crusingrange) VALUES (30, 'Concorde', 4000);
INSERT INTO aircraft (aid, aname, crusingrange) VALUES (40, 'Cessna', 500);
INSERT INTO employees (eid, ename, salary) VALUES (1, 'Alice', 150000.0);
INSERT INTO employees (eid, ename, salary) VALUES (2, 'Bob', 90000.0);
INSERT INTO employees (eid, ename, salary) VALUES (3, 'Charlie', 120000.0);
INSERT INTO employees (eid, ename, salary) VALUES (4, 'David', 60000.0);
INSERT INTO employees (eid, ename, salary) VALUES (5, 'Eve', 200000.0);
INSERT INTO certified (eid, aid) VALUES (1, 10);
INSERT INTO certified (eid, aid) VALUES (2, 10);
INSERT INTO certified (eid, aid) VALUES (2, 20);
INSERT INTO certified (eid, aid) VALUES (4, 20);
INSERT INTO certified (eid, aid) VALUES (3, 5);
INSERT INTO certified (eid, aid) VALUES (4, 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT aname FROM (SELECT LHS.aid AS aid, LHS.aname AS aname, LHS.crusingrange AS crusingrange, LHS.eid AS eid, LHS.ename AS ename, LHS.salary AS salary FROM (SELECT LHS.aid AS aid, LHS.aname AS aname, LHS.crusingrange AS crusingrange, RHS.eid AS eid, RHS.ename AS ename, RHS.salary AS salary FROM aircraft AS LHS CROSS JOIN employees AS RHS) AS LHS INNER JOIN certified AS RHS ON (LHS.aid = RHS.aid AND LHS.eid = RHS.eid)) WHERE (salary > 80000.0) ORDER BY aname;

/*
Gold Result:
('Airbus A380',)
('Boeing 747',)
('Zeppelin',)
*/

-- Prediction Query
SELECT DISTINCT A.aname FROM aircraft AS A WHERE A.Aid IN (SELECT C.aid FROM certified AS C CROSS JOIN employees AS E WHERE C.eid = E.eid AND NOT EXISTS(SELECT * FROM employees AS E1 WHERE E1.eid = E.eid AND E1.salary < 80000));

/*
Prediction Result:
('Zeppelin',)
('Boeing 747',)
('Airbus A380',)
*/