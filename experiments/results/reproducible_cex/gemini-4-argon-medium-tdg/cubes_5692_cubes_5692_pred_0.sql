-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('Z9', 'Alpha', 2, 'Queen', 4, 150, 'Modern');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('A1', 'Bravo', 1, 'King', 2, 200, 'Traditional');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('C3', 'Bravo', 2, 'Double', 4, 120, 'Rustic');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('B2', 'Bravo', 1, 'Queen', 2, 180, 'Modern');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('M5', 'Charlie', 3, 'Twin', 3, 100, 'Rustic');
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (101, 'A1', '2023-01-01', '2023-01-05', 200.0, 'Smith', 'John', 2, 0);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (102, 'A1', '2023-02-01', '2023-02-05', 200.0, 'Doe', 'Jane', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomid, roomname FROM (SELECT * FROM (SELECT * FROM rooms ORDER BY roomname, rooms.roomid NULLS LAST) LIMIT 3);

/*
Gold Result:
('Z9', 'Alpha')
('A1', 'Bravo')
('B2', 'Bravo')
*/

-- Prediction Query
SELECT RoomId, roomName FROM Rooms ORDER BY basePrice DESC, Rooms.roomid NULLS LAST LIMIT 3;

/*
Prediction Result:
('A1', 'Bravo')
('B2', 'Bravo')
('Z9', 'Alpha')
*/