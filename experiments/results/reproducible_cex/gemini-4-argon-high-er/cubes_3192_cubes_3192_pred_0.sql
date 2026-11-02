-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('1', 'Zebra', 1, 'King', 2, 100, 'traditional');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('2', 'Apple', 1, 'Queen', 2, 100, 'traditional');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "roomname", "bedtype" FROM "rooms" WHERE ("decor" = 'traditional') ORDER BY roomname, rooms.roomid NULLS LAST;

/*
Gold Result:
('Apple', 'Queen')
('Zebra', 'King')
*/

-- Prediction Query
SELECT roomName, bedType FROM Rooms WHERE decor = 'traditional';

/*
Prediction Result:
('Zebra', 'King')
('Apple', 'Queen')
*/