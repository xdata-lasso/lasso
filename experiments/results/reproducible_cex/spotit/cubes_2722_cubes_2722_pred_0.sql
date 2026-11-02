-- Schema DDL
CREATE TABLE "DRIVER" (
    "DRIVER_ID" INT,
    "NAME" TEXT,
    "PARTY" TEXT,
    "HOME_CITY" TEXT,
    "AGE" INT,
    PRIMARY KEY ("DRIVER_ID")
);
CREATE TABLE "SCHOOL" (
    "SCHOOL_ID" INT,
    "GRADE" TEXT,
    "SCHOOL" TEXT,
    "LOCATION" TEXT,
    "TYPE" TEXT,
    PRIMARY KEY ("SCHOOL_ID")
);
CREATE TABLE "SCHOOL_BUS" (
    "SCHOOL_ID" INT,
    "DRIVER_ID" INT,
    "YEARS_WORKING" INT,
    "IF_FULL_TIME" INT,
    PRIMARY KEY ("SCHOOL_ID", "DRIVER_ID"),
    FOREIGN KEY ("DRIVER_ID") REFERENCES "DRIVER"("DRIVER_ID"),
    FOREIGN KEY ("SCHOOL_ID") REFERENCES "SCHOOL"("SCHOOL_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO DRIVER VALUES (3, 13, 14, -1, 0);
INSERT INTO DRIVER VALUES (2, 13, 11, 0, 0);
INSERT INTO SCHOOL VALUES (1, 0, 0, 0, 0);
INSERT INTO SCHOOL VALUES (0, 0, 0, 0, 0);
INSERT INTO SCHOOL_BUS VALUES (1, 3, 0, 0);
INSERT INTO SCHOOL_BUS VALUES (1, 2, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT home_city FROM (SELECT LHS.name AS name, LHS.n AS n, RHS.party AS party, RHS.home_city AS home_city, RHS.age AS age FROM (SELECT name, COUNT(*) AS n FROM driver GROUP BY name) AS LHS INNER JOIN driver AS RHS ON (LHS.n = RHS.driver_id AND LHS.name = RHS.name)) ORDER BY home_city;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT home_city FROM driver GROUP BY home_city ORDER BY COUNT(*) DESC, home_city NULLS LAST LIMIT 1;

/*
Prediction Result:
('-1',)
*/