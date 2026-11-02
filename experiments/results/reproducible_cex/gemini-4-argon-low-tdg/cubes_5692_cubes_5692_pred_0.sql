-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R04', 'B_Suite', 2, 'Queen', 4, 150, 'Modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R03', 'A_Suite', 1, 'King', 2, 200, 'Traditional');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R01', 'A_Suite', 2, 'Double', 4, 120, 'Rustic');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R05', 'C_Suite', 3, 'Twin', 3, 180, 'Modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R02', 'B_Suite', 1, 'Queen', 2, 100, 'Traditional');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomid, roomname FROM (SELECT * FROM (SELECT * FROM rooms ORDER BY roomname, rooms.roomid NULLS LAST) LIMIT 3);

/*
Gold Result:
('R01', 'A_Suite')
('R03', 'A_Suite')
('R02', 'B_Suite')
*/

-- Prediction Query
SELECT RoomId, roomName FROM Rooms ORDER BY basePrice DESC, Rooms.roomid NULLS LAST LIMIT 3;

/*
Prediction Result:
('R03', 'A_Suite')
('R05', 'C_Suite')
('R04', 'B_Suite')
*/