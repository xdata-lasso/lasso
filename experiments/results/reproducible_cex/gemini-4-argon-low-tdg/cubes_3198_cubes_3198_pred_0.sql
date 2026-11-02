-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
-- Tie-breaking on RoomId (with NULL RoomId): In SQLite, TEXT PRIMARY KEY allows NULL values.
-- The query specifies `rooms.roomid NULLS LAST`.
-- If two rooms share the lowest roomName, one with RoomId = NULL and one with RoomId = 'R1', 'R1' comes first because of NULLS LAST.
-- Catches mutants that omit NULLS LAST on roomid and simultaneously leak/project other columns or filter differently.
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES (NULL, 'A_Room', 1, 'King', 2, 100, 'Modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R1', 'A_Room', 2, 'Queen', 4, 200, 'Rustic');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R2', 'B_Room', 3, 'Double', 6, 300, 'Traditional');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomname FROM (SELECT * FROM (SELECT * FROM rooms ORDER BY roomname, rooms.roomid NULLS LAST) LIMIT 1);

/*
Gold Result:
('A_Room',)
*/

-- Prediction Query
SELECT roomName FROM Rooms ORDER BY maxOccupancy DESC, Rooms.roomid NULLS LAST LIMIT 1;

/*
Prediction Result:
('B_Room',)
*/