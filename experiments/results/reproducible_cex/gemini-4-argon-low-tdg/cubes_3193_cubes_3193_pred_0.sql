-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions for basePrice (119, 120, 121, 150, 151) and NULL values.
-- Catches mutations changing '>' to '>=' or '<=' to '<', and incorrect NULL handling.
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R1', 'Alpha', 2, 'Queen', 4, 119, 'Modern');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R2', 'Beta', 2, 'Queen', 4, 120, 'Modern');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R3', 'Gamma', 2, 'King', 2, 121, 'Rustic');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R4', 'Delta', 1, 'King', 2, 150, 'Traditional');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R5', 'Epsilon', 2, 'Double', 4, 151, 'Modern');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R6', 'Zeta', 1, 'Queen', 2, NULL, 'Rustic');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomname FROM rooms WHERE (baseprice > 120 AND baseprice <= 150) ORDER BY roomname, rooms.roomid NULLS LAST;

/*
Gold Result:
('Delta',)
('Gamma',)
*/

-- Prediction Query
SELECT roomname FROM rooms WHERE baseprice BETWEEN 120 AND 150;

/*
Prediction Result:
('Beta',)
('Gamma',)
('Delta',)
*/