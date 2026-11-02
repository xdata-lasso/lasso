-- Schema DDL
CREATE TABLE "SWIMMER" (
    "ID" INT,
    "NAME" TEXT,
    "NATIONALITY" TEXT,
    "METER_100" FLOAT,
    "METER_200" TEXT,
    "METER_300" TEXT,
    "METER_400" TEXT,
    "METER_500" TEXT,
    "METER_600" TEXT,
    "METER_700" TEXT,
    "TIME" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "STADIUM" (
    "ID" INT,
    "NAME" TEXT,
    "CAPACITY" INT,
    "CITY" TEXT,
    "COUNTRY" TEXT,
    "OPENING_YEAR" INT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "EVENT" (
    "ID" INT,
    "STADIUM_ID" INT,
    "NAME" TEXT,
    "YEAR" TEXT,
    PRIMARY KEY ("ID"),
    FOREIGN KEY ("STADIUM_ID") REFERENCES "STADIUM"("ID")
);
CREATE TABLE "RECORD" (
    "SWIMMER_ID" INT,
    "EVENT_ID" INT,
    "ID" INT,
    "RESULT" TEXT,
    PRIMARY KEY ("SWIMMER_ID", "EVENT_ID"),
    FOREIGN KEY ("SWIMMER_ID") REFERENCES "SWIMMER"("ID"),
    FOREIGN KEY ("EVENT_ID") REFERENCES "EVENT"("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO SWIMMER VALUES (-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO SWIMMER VALUES (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO STADIUM VALUES (0, 15, 0, 16, 0, 0);
INSERT INTO STADIUM VALUES (1, 15, 0, 16, 0, 0);
INSERT INTO EVENT VALUES (1, 0, 0, 0);
INSERT INTO EVENT VALUES (0, 0, 0, 0);
INSERT INTO RECORD VALUES (0, 0, 0, 0);
INSERT INTO RECORD VALUES (-1, 1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM (SELECT * FROM (SELECT country, opening_year, COUNT(*) AS n FROM stadium GROUP BY country, opening_year) AS LHS WHERE EXISTS(SELECT 1 FROM (SELECT MAX(n) AS n FROM (SELECT country, opening_year, COUNT(*) AS n FROM stadium GROUP BY country, opening_year)) AS RHS WHERE (LHS.n = RHS.n))) ORDER BY country;

/*
Gold Result:
('0',)
*/

-- Prediction Query
SELECT country FROM stadium GROUP BY country ORDER BY COUNT(*) DESC, country NULLS LAST LIMIT 1;

/*
Prediction Result:
('0',)
*/