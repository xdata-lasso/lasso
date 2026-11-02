-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R1', 'B Room', 1, 'King', 2, 100, 'Modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R2', 'A Room', 1, 'King', 2, 200, 'Rustic');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "roomname", "decor" FROM "rooms" WHERE ("bedtype" = 'King') ORDER BY roomname, rooms.roomid NULLS LAST;

/*
Gold Result:
('A Room', 'Rustic')
('B Room', 'Modern')
*/

-- Prediction Query
SELECT roomName, decor FROM Rooms WHERE bedtype = 'King' ORDER BY basePrice, Rooms.roomid NULLS LAST;

/*
Prediction Result:
('B Room', 'Modern')
('A Room', 'Rustic')
*/