-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R1', 'Zenith', 1, 'King', 2, 150, 'modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R2', 'Alpine', 2, 'Queen', 4, 200, 'rustic');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R3', 'Bistro', 2, 'Double', 4, 120, 'traditional');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R4', 'Cascade', 1, 'King', 2, 180, 'traditional');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R5', 'Dune', 2, 'Twin', 2, 100, 'modern');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "roomname" FROM "rooms" WHERE ("bedtype" = 'King' OR "bedtype" = 'Queen') ORDER BY roomname, rooms.roomid NULLS LAST;

/*
Gold Result:
('Alpine',)
('Cascade',)
('Zenith',)
*/

-- Prediction Query
SELECT roomName FROM Rooms WHERE bedType = 'King' OR bedType = 'Queen';

/*
Prediction Result:
('Zenith',)
('Alpine',)
('Cascade',)
*/