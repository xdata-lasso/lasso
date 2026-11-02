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
INSERT INTO ROOMS VALUES (3, 0, 0, 0, NULL, 0, 0);
INSERT INTO ROOMS VALUES (0, 0, 0, 0, 1, 160, 0);
INSERT INTO RESERVATIONS VALUES (-1, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO RESERVATIONS VALUES (0, 0, 0, 0, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomname, roomid FROM rooms WHERE (baseprice >= 160 OR maxoccupancy < 2) ORDER BY roomname, rooms.roomid NULLS LAST;

/*
Gold Result:
('0', '0')
*/

-- Prediction Query
SELECT roomName, RoomId FROM Rooms WHERE basePrice > 160 AND maxOccupancy > 2;

/*
Prediction Result:
*/