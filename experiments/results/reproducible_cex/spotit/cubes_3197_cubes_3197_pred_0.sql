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
INSERT INTO ROOMS VALUES (3, 0, 2, 0, 0, 161, 1521580426459410409);
INSERT INTO ROOMS VALUES (4, 0, 0, 0, 0, 0, 7);
INSERT INTO RESERVATIONS VALUES (1, 3, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO RESERVATIONS VALUES (0, 3, 0, 0, 0, 0, 0, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROOMNAME FROM (SELECT * FROM ROOMS WHERE (DECOR = 'modern' AND baseprice <> 160)) WHERE (beds = 2 OR baseprice = 2) ORDER BY roomname, ROOMNAME NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT roomName FROM Rooms WHERE basePrice < 160 AND beds = 2 AND decor = 'modern';

/*
Prediction Result:
*/