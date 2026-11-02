-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R1', 'Alpha', 2, 'Queen', 4, 120, 'modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R2', 'Beta', 2, 'Queen', 4, 121, 'modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R3', 'Gamma', 2, 'Queen', 4, 149, 'modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R4', 'Delta', 2, 'Queen', 4, 150, 'modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R5', 'Epsilon', 2, 'Queen', 4, 151, 'modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R6', 'Zeta', 2, 'Queen', 4, NULL, 'modern');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomname FROM rooms WHERE (baseprice > 120 AND baseprice <= 150) ORDER BY roomname, rooms.roomid NULLS LAST;

/*
Gold Result:
('Beta',)
('Delta',)
('Gamma',)
*/

-- Prediction Query
SELECT roomname FROM rooms WHERE baseprice BETWEEN 120 AND 150;

/*
Prediction Result:
('Alpha',)
('Beta',)
('Gamma',)
('Delta',)
*/