-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R1', 'Trad One', 2, 'Queen', 4, 150, 'traditional');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R2', 'Rustic One', 1, 'King', 2, 120, 'rustic');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R3', 'Modern Upper', 2, 'Queen', 4, 160, 'Modern');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R4', 'Modern Prefix', 1, 'King', 2, 130, 'modernistic');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R5', 'Null Decor', 2, 'Double', 4, 110, NULL);
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