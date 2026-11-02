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
INSERT INTO COLLEGE VALUES (1, 0, 0);
INSERT INTO COLLEGE VALUES (0, 0, -1);
INSERT INTO PLAYER VALUES (3, 0, 0, 0);
INSERT INTO PLAYER VALUES (4, 0, 0, 0);
INSERT INTO TRYOUT VALUES (3, 0, 0, 0);
INSERT INTO TRYOUT VALUES (4, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cname, state, enr AS min_enr_ FROM (SELECT cname, state, MIN(enr) AS enr FROM college GROUP BY cname, state) ORDER BY cname, state NULLS LAST, min_enr_ NULLS LAST;

/*
Gold Result:
('0', '0', -1.0)
('1', '0', 0.0)
*/

-- Prediction Query
SELECT cName, state, MIN(enr) FROM college GROUP BY state;

/*
Prediction Result:
('0', '0', -1.0)
*/