-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests boundary values for basePrice (119, 120, 121), multiple groups, different counts, and ordering.
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R1', 'Recluse', 1, 'King', 2, 119, 'modern');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R2', 'Octagon', 2, 'Queen', 4, 120, 'modern');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R3', 'Abscond', 2, 'King', 4, 150, 'modern');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R4', 'Frugal', 1, 'Double', 2, 120, 'rustic');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R5', 'Suite', 3, 'Queen', 6, 121, 'traditional');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R6', 'Royal', 2, 'King', 4, 200, 'traditional');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R7', 'Grand', 2, 'King', 4, 250, 'traditional');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R8', 'Cheap', 1, 'Twin', 1, 80, 'shabby');
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (101, 'R2', '2023-01-01', '2023-01-05', 120.0, 'Smith', 'John', 2, 0);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (102, 'R2', '2023-02-01', '2023-02-05', 120.0, 'Doe', 'Jane', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT decor, n AS count___ FROM (SELECT decor, COUNT(*) AS n FROM (SELECT * FROM rooms WHERE (baseprice >= 120)) GROUP BY decor) ORDER BY decor, count___ NULLS LAST;

/*
Gold Result:
('modern', 2)
('rustic', 1)
('traditional', 3)
*/

-- Prediction Query
SELECT decor, COUNT(*) FROM Rooms WHERE basePrice > 120 GROUP BY decor;

/*
Prediction Result:
('modern', 1)
('traditional', 3)
*/