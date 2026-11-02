-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('blue', 'modern', 1019, 'best', 1020, 1021, 'great');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "summaxoccupancy" AS "sum_maxoccupancy_" FROM (SELECT "decor", SUM("maxoccupancy") AS "summaxoccupancy" FROM "rooms" GROUP BY "decor") WHERE ("decor" = 'modern') ORDER BY sum_maxoccupancy_;

/*
Gold Result:
*/

-- Prediction Query
SELECT SUM(maxOccupancy) FROM Rooms WHERE decor = 'modern';

/*
Prediction Result:
(None,)
*/