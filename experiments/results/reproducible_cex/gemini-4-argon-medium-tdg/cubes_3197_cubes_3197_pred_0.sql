-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R1', 'Alpha', 2, 'Queen', 4, 150, 'modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R2', 'Beta', 1, 'King', 2, 2, 'modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R3', 'Gamma', 2, 'Double', 4, 2, 'modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R4', 'Delta', 2, 'Queen', 4, 160, 'modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R5', 'Epsilon', 2, 'Queen', 4, 150, 'rustic');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R6', 'Zeta', 3, 'Twin', 6, 150, 'modern');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "roomname" FROM (SELECT * FROM "rooms" WHERE ("decor" = 'modern' AND baseprice <> 160)) WHERE (beds = 2 OR baseprice = 2) ORDER BY roomname, "roomname" NULLS LAST;

/*
Gold Result:
('Alpha',)
('Beta',)
('Gamma',)
*/

-- Prediction Query
SELECT roomName FROM Rooms WHERE basePrice < 160 AND beds = 2 AND decor = 'modern';

/*
Prediction Result:
('Alpha',)
('Gamma',)
*/