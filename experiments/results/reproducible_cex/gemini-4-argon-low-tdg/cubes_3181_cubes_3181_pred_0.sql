-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests empty result set vs scalar aggregation (SUM without OVER()). When no rows match WHERE, window function returns 0 rows, whereas scalar SUM() returns 1 row with NULL. Also tests case-sensitivity ('king' vs 'King').
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R1', 'Standard Queen', 2, 'Queen', 4, 120, 'Modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R2', 'Double Deluxe', 4, 'Double', 8, 220, 'Traditional');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R3', 'Lowercase King', 1, 'king', 2, 180, 'Rustic');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R4', 'Null BedType', 2, NULL, 4, 100, 'Modern');
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