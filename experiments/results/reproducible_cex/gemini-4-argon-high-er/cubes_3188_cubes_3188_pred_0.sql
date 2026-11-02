-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('A', 'Recluse and defiance', 2, 'King', 4, 100, 'traditional');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('B', 'Recluse and defiance', 2, 'Queen', 4, 150, 'modern');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "decor" FROM "rooms" WHERE ("roomname" = 'Recluse and defiance') ORDER BY decor, rooms.roomid NULLS LAST;

/*
Gold Result:
('modern',)
('traditional',)
*/

-- Prediction Query
SELECT decor FROM Rooms WHERE roomName = 'Recluse and defiance';

/*
Prediction Result:
('traditional',)
('modern',)
*/