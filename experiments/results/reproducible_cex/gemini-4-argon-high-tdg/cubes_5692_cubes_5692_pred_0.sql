-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('RM9', 'Ocean View', 4, 'Queen', 8, 400, 'modern');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('RM2', 'Royal Suite', 1, 'King', 2, 80, 'traditional');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('RM5', 'Palm Suite', 2, 'Double', 3, 300, 'rustic');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('RM1', 'Ocean View', 3, 'Twin', 5, 350, 'traditional');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('RM3', 'Sunset Room', 1, 'Queen', 1, 50, 'modern');
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (201, 'RM9', '2023-05-10', '2023-05-12', 400.0, 'Taylor', 'Alex', 2, 2);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (202, 'RM2', '2023-06-01', '2023-06-03', 80.0, 'Lee', 'Chris', 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomid, roomname FROM (SELECT * FROM (SELECT * FROM rooms ORDER BY roomname, rooms.roomid NULLS LAST) LIMIT 3);

/*
Gold Result:
('RM1', 'Ocean View')
('RM9', 'Ocean View')
('RM5', 'Palm Suite')
*/

-- Prediction Query
SELECT RoomId, roomName FROM Rooms ORDER BY basePrice DESC, Rooms.roomid NULLS LAST LIMIT 3;

/*
Prediction Result:
('RM9', 'Ocean View')
('RM1', 'Ocean View')
('RM5', 'Palm Suite')
*/