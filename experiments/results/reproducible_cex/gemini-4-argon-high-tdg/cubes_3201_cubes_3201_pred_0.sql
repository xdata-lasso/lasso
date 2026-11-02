-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R1', 'Cabin One', 2, 'Queen', 4, 120, 'rustic');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R2', 'Cabin Two', 2, 'Queen', 4, 119, 'rustic');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('T1', 'Royal Suite', 2, 'King', 4, 150, 'traditional');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('T2', 'Royal Suite', 2, 'King', 4, 150, 'traditional');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('T3', 'Grand Suite', 3, 'King', 6, 200, 'traditional');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('M1', 'Loft A', 1, 'King', 2, 121, 'modern');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('M2', 'Loft B', 2, 'Queen', 4, 180, 'modern');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('M3', 'Studio C', 1, 'Double', 2, 80, 'modern');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('MIN1', 'Pod 1', 1, 'Twin', 1, 70, 'minimalist');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('MIN2', 'Pod 2', 1, 'Twin', 1, 70, 'minimalist');
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (101, 'M1', '2023-01-01', '2023-01-05', 121.0, 'Smith', 'John', 2, 0);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (102, 'M1', '2023-02-01', '2023-02-05', 125.0, 'Doe', 'Jane', 1, 1);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (103, 'T1', '2023-03-01', '2023-03-04', 150.0, 'Brown', 'Charlie', 2, 2);
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
('modern', 2)
('traditional', 3)
*/