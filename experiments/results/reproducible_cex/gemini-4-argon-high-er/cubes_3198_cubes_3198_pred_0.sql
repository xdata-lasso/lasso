-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Rooms" ("RoomId", "roomName", "maxOccupancy") VALUES ('1', 'A', 1);
INSERT INTO "Rooms" ("RoomId", "roomName", "maxOccupancy") VALUES ('2', 'B', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomname FROM (SELECT * FROM (SELECT * FROM rooms ORDER BY roomname, rooms.roomid NULLS LAST) LIMIT 1);

/*
Gold Result:
('A',)
*/

-- Prediction Query
SELECT roomName FROM Rooms ORDER BY maxOccupancy DESC, Rooms.roomid NULLS LAST LIMIT 1;

/*
Prediction Result:
('B',)
*/