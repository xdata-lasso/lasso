-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests empty result set when no 'modern' decor exists (distinguishes GROUP BY + WHERE from ungrouped SUM which returns a row with NULL).
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R1', 'Rustic Room', 2, 'Queen', 4, 100, 'rustic');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R2', 'Modern Uppercase', 1, 'King', 2, 120, 'Modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R3', 'Modern Substring', 1, 'Twin', 2, 90, 'modernistic');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R4', 'Null Decor', 2, 'Double', 4, 110, NULL);
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