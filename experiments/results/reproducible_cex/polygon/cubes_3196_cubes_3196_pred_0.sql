-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('modern8', 'modern7', 7, 'modern7', NULL, 7, 'modern12');
INSERT INTO "Rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('modern7', 'modern7', 7, 'modern7', NULL, 7, 'modern11');
INSERT INTO "Reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (10, 'modern7', 'modern7', 'modern7', 7, 'modern7', 'modern7', 7, 7);
INSERT INTO "Reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (9, 'modern7', 'modern7', 'modern7', 7, 'modern7', 'modern7', 7, 7);
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