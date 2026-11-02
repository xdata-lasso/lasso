-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Rooms" ("RoomId", "roomName", "bedType") VALUES ('R1', 'Zebra Room', 'King');
INSERT INTO "Rooms" ("RoomId", "roomName", "bedType") VALUES ('R2', 'Alpha Room', 'Queen');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "roomname" FROM "rooms" WHERE ("bedtype" = 'King' OR "bedtype" = 'Queen') ORDER BY roomname, rooms.roomid NULLS LAST;

/*
Gold Result:
('Alpha Room',)
('Zebra Room',)
*/

-- Prediction Query
SELECT roomName FROM Rooms WHERE bedType = 'King' OR bedType = 'Queen';

/*
Prediction Result:
('Zebra Room',)
('Alpha Room',)
*/