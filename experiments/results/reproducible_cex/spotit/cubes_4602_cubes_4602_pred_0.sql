-- Schema DDL
CREATE TABLE "ROLLER_COASTER" (
    "ROLLER_COASTER_ID" INT,
    "COUNTRY_ID" INT,
    "NAME" TEXT,
    "PARK" TEXT,
    "LENGTH" FLOAT,
    "HEIGHT" FLOAT,
    "SPEED" TEXT,
    "OPENED" TEXT,
    "STATUS" TEXT,
    PRIMARY KEY ("ROLLER_COASTER_ID"),
    FOREIGN KEY ("COUNTRY_ID") REFERENCES "COUNTRY"("COUNTRY_ID")
);
CREATE TABLE "COUNTRY" (
    "COUNTRY_ID" INT,
    "NAME" TEXT,
    "POPULATION" INT,
    "AREA" INT,
    "LANGUAGES" TEXT,
    PRIMARY KEY ("COUNTRY_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ROLLER_COASTER VALUES (-1, -1, 18, 3, 19, 20, 0, 21, 16);
INSERT INTO ROLLER_COASTER VALUES (0, 0, 12, 5, 13, 14, 0, 15, 17);
INSERT INTO COUNTRY VALUES (-1, 0, 0, 0, 0);
INSERT INTO COUNTRY VALUES (0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT park FROM (SELECT LHS.roller_coaster_id AS roller_coaster_id, LHS.name AS name, LHS.park AS park, LHS.country_id AS country_id, LHS.length AS LENGTH, LHS.height AS height, LHS.speed AS speed, LHS.opened AS opened, LHS.status AS status, RHS.status AS status_other, RHS.speed AS speed_other FROM roller_coaster AS LHS CROSS JOIN (SELECT status, MAX(speed) AS speed FROM roller_coaster GROUP BY status) AS RHS) WHERE (speed = speed_other) ORDER BY park;

/*
Gold Result:
('3',)
('3',)
('5',)
('5',)
*/

-- Prediction Query
SELECT Park FROM roller_coaster ORDER BY Speed DESC, roller_coaster.roller_coaster_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('3',)
*/