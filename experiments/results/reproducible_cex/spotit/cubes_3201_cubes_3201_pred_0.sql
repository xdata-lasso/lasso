-- Schema DDL
CREATE TABLE "ROOMS" (
    "ROOMID" TEXT,
    "ROOMNAME" TEXT,
    "BEDS" INT,
    "BEDTYPE" TEXT,
    "MAXOCCUPANCY" INT,
    "BASEPRICE" INT,
    "DECOR" TEXT,
    PRIMARY KEY ("ROOMID")
);
CREATE TABLE "RESERVATIONS" (
    "CODE" INT,
    "ROOM" TEXT,
    "CHECKIN" TEXT,
    "CHECKOUT" TEXT,
    "RATE" FLOAT,
    "LASTNAME" TEXT,
    "FIRSTNAME" TEXT,
    "ADULTS" INT,
    "KIDS" INT,
    PRIMARY KEY ("CODE"),
    FOREIGN KEY ("ROOM") REFERENCES "ROOMS"("ROOMID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ROOMS VALUES (9, 10, 0, 11, 0, 120, 1);
INSERT INTO ROOMS VALUES (4, 5, 0, 6, 0, 121, 0);
INSERT INTO RESERVATIONS VALUES (0, 4, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO RESERVATIONS VALUES (1, 9, 0, 0, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT decor, n AS count___ FROM (SELECT decor, COUNT(*) AS n FROM (SELECT * FROM rooms WHERE (baseprice >= 120)) GROUP BY decor) ORDER BY decor, count___ NULLS LAST;

/*
Gold Result:
('0', 1)
('1', 1)
*/

-- Prediction Query
SELECT decor, COUNT(*) FROM Rooms WHERE basePrice > 120 GROUP BY decor;

/*
Prediction Result:
('0', 1)
*/