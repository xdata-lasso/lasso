-- Schema DDL
CREATE TABLE "COLLEGE" (
    "CNAME" TEXT,
    "STATE" TEXT,
    "ENR" FLOAT,
    PRIMARY KEY ("CNAME")
);
CREATE TABLE "PLAYER" (
    "PID" FLOAT,
    "PNAME" TEXT,
    "YCARD" TEXT,
    "HS" FLOAT,
    PRIMARY KEY ("PID")
);
CREATE TABLE "TRYOUT" (
    "PID" FLOAT,
    "CNAME" TEXT,
    "PPOS" TEXT,
    "DECISION" TEXT,
    PRIMARY KEY ("CNAME", "PID"),
    FOREIGN KEY ("CNAME") REFERENCES "COLLEGE"("CNAME"),
    FOREIGN KEY ("PID") REFERENCES "PLAYER"("PID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO COLLEGE VALUES (4, 0, 0);
INSERT INTO COLLEGE VALUES (3, 0, 0);
INSERT INTO PLAYER VALUES (6, 0, 0, 0);
INSERT INTO PLAYER VALUES (5, 0, 0, 0);
INSERT INTO TRYOUT VALUES (5, 3, 0, 10);
INSERT INTO TRYOUT VALUES (5, 4, 1, 7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT ppos FROM (SELECT LHS.pid AS pid, LHS.cname AS cname, LHS.ppos AS ppos, LHS.decision AS decision, LHS.n AS n FROM (SELECT LHS.pid AS pid, LHS.cname AS cname, LHS.ppos AS ppos, LHS.decision AS decision, RHS.n AS n FROM tryout AS LHS INNER JOIN (SELECT pid, COUNT(*) AS n FROM tryout GROUP BY pid) AS RHS ON (LHS.pid = RHS.pid)) AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT pid, COUNT(*) AS n FROM tryout GROUP BY pid)) AS RHS ON (LHS.n = RHS.n)) ORDER BY ppos;

/*
Gold Result:
('0',)
('1',)
*/

-- Prediction Query
SELECT pPos FROM tryout GROUP BY pPos ORDER BY COUNT(*) DESC, pPos NULLS LAST LIMIT 1;

/*
Prediction Result:
('0',)
*/