-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R04', 'Zebra Suite', 2, 'King', 4, 250, 'traditional');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R02', 'Alpha Room', 1, 'King', 2, 150, 'traditional');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R01', 'Alpha Room', 2, 'Queen', 4, 180, 'traditional');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R06', 'Beta Room', 2, 'Queen', 4, 200, 'traditional');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R05', 'Beta Room', 1, 'King', 2, 190, 'traditional');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R03', 'Alpha Room', 2, 'Queen', 4, 180, 'traditional');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R07', 'Modern Loft', 1, 'King', 2, 300, 'modern');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R08', 'Rustic Cabin', 3, 'Double', 6, 220, 'rustic');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R09', 'Case Test', 1, 'Twin', 2, 100, 'Traditional');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R10', 'Null Decor', 1, 'Queen', 2, 120, NULL);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (101, 'R01', '2023-01-01', '2023-01-05', 180.0, 'Smith', 'John', 2, 0);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (102, 'R01', '2023-02-01', '2023-02-05', 180.0, 'Doe', 'Jane', 1, 1);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (103, 'R07', '2023-03-01', '2023-03-05', 300.0, 'Brown', 'Charlie', 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "roomname", "bedtype" FROM "rooms" WHERE ("decor" = 'traditional') ORDER BY roomname, rooms.roomid NULLS LAST;

/*
Gold Result:
('Alpha Room', 'Queen')
('Alpha Room', 'King')
('Alpha Room', 'Queen')
('Beta Room', 'King')
('Beta Room', 'Queen')
('Zebra Suite', 'King')
*/

-- Prediction Query
SELECT roomName, bedType FROM Rooms WHERE decor = 'traditional';

/*
Prediction Result:
('Zebra Suite', 'King')
('Alpha Room', 'King')
('Alpha Room', 'Queen')
('Beta Room', 'Queen')
('Beta Room', 'King')
('Alpha Room', 'Queen')
*/