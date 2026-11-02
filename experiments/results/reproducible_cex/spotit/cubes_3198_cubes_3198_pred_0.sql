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
INSERT INTO ROOMS VALUES (1, 7, 0, 0, 0, 0, 0);
INSERT INTO ROOMS VALUES (0, 6, 0, 0, 0, 0, 0);
INSERT INTO RESERVATIONS VALUES (-1, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO RESERVATIONS VALUES (0, 1, 0, 0, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomname FROM (SELECT * FROM (SELECT * FROM rooms ORDER BY roomname, rooms.roomid NULLS LAST) LIMIT 1);

/*
Gold Result:
('6',)
*/

-- Prediction Query
SELECT roomName FROM Rooms ORDER BY maxOccupancy DESC, Rooms.roomid NULLS LAST LIMIT 1;

/*
Prediction Result:
('6',)
*/