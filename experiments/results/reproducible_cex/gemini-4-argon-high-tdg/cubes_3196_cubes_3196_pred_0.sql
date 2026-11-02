-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R1', 'Old Charm', 2, 'Queen', 4, 100, 'traditional');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R2', 'Woodland Retreat', 3, 'King', 6, 140, 'rustic');
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (201, 'R1', '2023-06-01', '2023-06-04', 100.0, 'Miller', 'Sam', 2, 0);
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