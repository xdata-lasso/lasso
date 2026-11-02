-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests the absence of 'King' bedType. Because the reference query groups by bedType and filters in the outer query, this dataset MUST return an empty result set (0 rows), rather than a single row with 0 (which a naive SELECT COUNT(*) WHERE bedType = 'King' without GROUP BY would return).
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R1', 'Cozy Queen', 1, 'Queen', 2, 150, 'Modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R2', 'Family Double', 2, 'Double', 4, 180, 'Traditional');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R3', 'Unknown Bed', 1, NULL, 2, 100, 'Rustic');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "bedtype", COUNT(*) AS "n" FROM "rooms" GROUP BY "bedtype") WHERE ("bedtype" = 'King') ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM Rooms WHERE bedType = 'King';

/*
Prediction Result:
(0,)
*/