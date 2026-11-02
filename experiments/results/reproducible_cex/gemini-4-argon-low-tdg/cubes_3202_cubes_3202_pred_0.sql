-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering (bedType = 'King' vs others, case sensitivity, NULL),
-- primary sorting (roomName ASC), secondary sorting (RoomId ASC), and NULLS LAST on RoomId.
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R3', 'Zebra Room', 1, 'King', 2, 200, 'Modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R2', 'Alpha Room', 1, 'King', 2, 150, 'Traditional');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R1', 'Alpha Room', 2, 'King', 4, 180, 'Modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES (NULL, 'Alpha Room', 1, 'King', 2, 100, 'Rustic');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R4', 'Beta Room', 2, 'Queen', 4, 150, 'Modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R5', 'Gamma Room', 1, 'king', 2, 150, 'Modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R6', 'Delta Room', 1, NULL, 2, 150, 'Modern');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "roomname", "decor" FROM "rooms" WHERE ("bedtype" = 'King') ORDER BY roomname, rooms.roomid NULLS LAST;

/*
Gold Result:
('Alpha Room', 'Modern')
('Alpha Room', 'Traditional')
('Alpha Room', 'Rustic')
('Zebra Room', 'Modern')
*/

-- Prediction Query
SELECT roomName, decor FROM Rooms WHERE bedtype = 'King' ORDER BY basePrice, Rooms.roomid NULLS LAST;

/*
Prediction Result:
('Alpha Room', 'Rustic')
('Alpha Room', 'Traditional')
('Alpha Room', 'Modern')
('Zebra Room', 'Modern')
*/