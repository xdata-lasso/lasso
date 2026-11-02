-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('blue', 'King', 1019, 'great', 1020, 1021, 'best');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SUM("beds") OVER () AS "sum_beds_" FROM "rooms" WHERE ("bedtype" = 'King') ORDER BY sum_beds_;

/*
Gold Result:
*/

-- Prediction Query
SELECT SUM(beds) FROM Rooms WHERE bedtype = 'King';

/*
Prediction Result:
(None,)
*/