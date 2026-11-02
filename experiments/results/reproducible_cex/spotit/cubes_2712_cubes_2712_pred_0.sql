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
INSERT INTO DRIVER VALUES (1, 12, 9, 0, 40);
INSERT INTO DRIVER VALUES (0, 14, 13, -1, 40);
INSERT INTO SCHOOL VALUES (1, 0, 0, 0, 0);
INSERT INTO SCHOOL VALUES (0, 0, 0, 0, 0);
INSERT INTO SCHOOL_BUS VALUES (0, 1, 0, 0);
INSERT INTO SCHOOL_BUS VALUES (1, 1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT home_city FROM (SELECT home_city, party, COUNT(DISTINCT age) AS n_distinct FROM (SELECT * FROM driver WHERE (age = 40 AND age >= 2)) GROUP BY home_city, party) ORDER BY home_city;

/*
Gold Result:
('-1',)
('0',)
*/

-- Prediction Query
SELECT home_city FROM driver WHERE age > 40 GROUP BY home_city HAVING COUNT(*) >= 2;

/*
Prediction Result:
*/