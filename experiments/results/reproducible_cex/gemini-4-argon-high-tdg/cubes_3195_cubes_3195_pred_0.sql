-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R04', 'Ocean View', 2, 'Queen', 2, 160, 'modern');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R01', 'Ocean View', 2, 'Single', 1, 159, 'rustic');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R03', 'Alpine', 1, 'King', 2, 159, 'traditional');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R02', 'Garden', 1, 'Single', 1, 160, 'modern');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R05', 'Budget', 1, 'Single', 0, 100, 'rustic');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R06', 'Penthouse', 3, 'King', 6, 250, 'modern');
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (101, 'R04', '2023-01-01', '2023-01-05', 160.0, 'Smith', 'John', 2, 0);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (102, 'R04', '2023-02-01', '2023-02-05', 175.0, 'Doe', 'Jane', 1, 1);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (103, 'R03', '2023-03-01', '2023-03-05', 200.0, 'Brown', 'Bob', 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomname, roomid FROM rooms WHERE (baseprice >= 160 OR maxoccupancy < 2) ORDER BY roomname, rooms.roomid NULLS LAST;

/*
Gold Result:
('Budget', 'R05')
('Garden', 'R02')
('Ocean View', 'R01')
('Ocean View', 'R04')
('Penthouse', 'R06')
*/

-- Prediction Query
SELECT roomName, RoomId FROM Rooms WHERE basePrice > 160 AND maxOccupancy > 2;

/*
Prediction Result:
('Penthouse', 'R06')
*/