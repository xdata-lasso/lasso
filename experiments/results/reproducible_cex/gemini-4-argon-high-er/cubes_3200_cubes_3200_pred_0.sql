-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R1', 'Room A', 1, 'Queen', 2, 100, 'Modern');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomname FROM (SELECT roomid, roomname, beds, bedtype, maxoccupancy, baseprice, decor, AVG(baseprice) OVER () AS meanbaseprice FROM rooms) WHERE (meanbaseprice <= baseprice) ORDER BY roomname;

/*
Gold Result:
('Room A',)
*/

-- Prediction Query
SELECT roomName FROM Rooms WHERE basePrice > (SELECT AVG(basePrice) FROM Rooms);

/*
Prediction Result:
*/