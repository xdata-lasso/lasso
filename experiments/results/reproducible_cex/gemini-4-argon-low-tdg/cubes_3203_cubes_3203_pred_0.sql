-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R1', NULL, 1, 'King', 2, 100, 'Modern');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES (NULL, 'Beta Room', 2, 'Queen', 4, 120, 'Rustic');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R2', 'Beta Room', 1, 'Double', 2, 110, 'Traditional');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R3', 'Alpha Room', 3, 'Twin', 3, 90, 'Modern');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomname FROM rooms ORDER BY roomname, rooms.roomid NULLS LAST;

/*
Gold Result:
(None,)
('Alpha Room',)
('Beta Room',)
('Beta Room',)
*/

-- Prediction Query
SELECT roomName FROM Rooms ORDER BY basePrice, Rooms.roomid NULLS LAST;

/*
Prediction Result:
('Alpha Room',)
(None,)
('Beta Room',)
('Beta Room',)
*/