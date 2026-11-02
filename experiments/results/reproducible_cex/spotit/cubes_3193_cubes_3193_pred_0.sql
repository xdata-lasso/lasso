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
INSERT INTO ROOMS VALUES (2, 0, 0, 0, 0, 151, 0);
INSERT INTO ROOMS VALUES (3, 0, 0, 0, 0, 120, 0);
INSERT INTO RESERVATIONS VALUES (-1, 2, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO RESERVATIONS VALUES (0, 3, 0, 0, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomname FROM rooms WHERE (baseprice > 120 AND baseprice <= 150) ORDER BY roomname, rooms.roomid NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT roomname FROM rooms WHERE baseprice BETWEEN 120 AND 150;

/*
Prediction Result:
('0',)
*/