-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions for basePrice (159, 160, 161) and maxOccupancy (1, 2, 3), as well as AND vs OR logic.
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R01', 'Alpha', 1, 'Queen', 2, 160, 'modern');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R02', 'Beta', 1, 'Queen', 2, 159, 'modern');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R03', 'Gamma', 1, 'Single', 1, 100, 'rustic');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R04', 'Delta', 2, 'King', 3, 150, 'traditional');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R05', 'Epsilon', 1, 'Single', 1, 161, 'modern');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomname, roomid FROM rooms WHERE (baseprice >= 160 OR maxoccupancy < 2) ORDER BY roomname, rooms.roomid NULLS LAST;

/*
Gold Result:
('Alpha', 'R01')
('Epsilon', 'R05')
('Gamma', 'R03')
*/

-- Prediction Query
SELECT roomName, RoomId FROM Rooms WHERE basePrice > 160 AND maxOccupancy > 2;

/*
Prediction Result:
*/