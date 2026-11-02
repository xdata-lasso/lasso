-- Schema DDL
CREATE TABLE "ENTREPRENEUR" (
    "ENTREPRENEUR_ID" INT,
    "PEOPLE_ID" INT,
    "COMPANY" TEXT,
    "MONEY_REQUESTED" FLOAT,
    "INVESTOR" TEXT,
    PRIMARY KEY ("ENTREPRENEUR_ID"),
    FOREIGN KEY ("PEOPLE_ID") REFERENCES "PEOPLE"("PEOPLE_ID")
);
CREATE TABLE "PEOPLE" (
    "PEOPLE_ID" INT,
    "NAME" TEXT,
    "HEIGHT" FLOAT,
    "WEIGHT" FLOAT,
    "DATE_OF_BIRTH" TEXT,
    PRIMARY KEY ("PEOPLE_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ENTREPRENEUR VALUES (1, 1, 17, 18, 0);
INSERT INTO ENTREPRENEUR VALUES (0, 1, 17, 18, 0);
INSERT INTO PEOPLE VALUES (1, 0, 0, 0, 0);
INSERT INTO PEOPLE VALUES (0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT investor_other AS investor FROM (SELECT LHS.investor AS investor, LHS.maxn AS maxn, RHS.investor AS investor_other, RHS.maxn AS maxn_other FROM (SELECT investor, MAX(n) AS maxn FROM (SELECT investor, COUNT(*) AS n FROM entrepreneur GROUP BY investor) GROUP BY investor) AS LHS CROSS JOIN (SELECT investor, MAX(n) AS maxn FROM (SELECT investor, COUNT(*) AS n FROM entrepreneur GROUP BY investor) GROUP BY investor) AS RHS) WHERE (maxn < maxn_other) ORDER BY investor;

/*
Gold Result:
*/

-- Prediction Query
SELECT Investor FROM entrepreneur GROUP BY Investor ORDER BY COUNT(*) DESC, Investor NULLS LAST LIMIT 1;

/*
Prediction Result:
('0',)
*/