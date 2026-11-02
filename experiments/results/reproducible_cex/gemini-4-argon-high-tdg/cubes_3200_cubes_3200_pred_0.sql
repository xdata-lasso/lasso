-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('A1', 'Zebra Suite', 2, 'Queen', 4, 200, 'modern');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('B2', 'Beta Room', 1, 'King', 2, 300, 'traditional');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('C3', 'Omega Room', 3, 'Double', 6, 100, 'rustic');
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (101, 'C3', '2023-01-01', '2023-01-05', 500.0, 'Smith', 'John', 2, 0);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (102, 'C3', '2023-02-01', '2023-02-05', 500.0, 'Doe', 'Jane', 1, 1);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (103, 'A1', '2023-03-01', '2023-03-03', 50.0, 'Brown', 'Charlie', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomname FROM (SELECT roomid, roomname, beds, bedtype, maxoccupancy, baseprice, decor, AVG(baseprice) OVER () AS meanbaseprice FROM rooms) WHERE (meanbaseprice <= baseprice) ORDER BY roomname;

/*
Gold Result:
('Beta Room',)
('Zebra Suite',)
*/

-- Prediction Query
SELECT roomName FROM Rooms WHERE basePrice > (SELECT AVG(basePrice) FROM Rooms);

/*
Prediction Result:
('Beta Room',)
*/