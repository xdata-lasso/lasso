-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering (traditional vs others, case sensitivity, NULL), duplicates (DISTINCT vs ALL), tie-breaking on RoomId, and spurious joins with Reservations (rooms with 0, 1, and multiple reservations).
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R2', 'Alpha', 2, 'King', 4, 150, 'traditional');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R1', 'Alpha', 2, 'King', 4, 150, 'traditional');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R3', 'Beta', 1, 'Queen', 2, 100, 'traditional');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R4', 'Alpha', 1, 'Double', 2, 120, 'traditional');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R5', 'Gamma', 2, 'King', 4, 200, 'modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R6', 'Delta', 1, 'Queen', 2, 110, 'Traditional');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R7', 'Epsilon', 1, 'Twin', 2, 90, NULL);
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (101, 'R1', '2023-01-01', '2023-01-05', 150.0, 'Smith', 'John', 2, 0);
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (102, 'R1', '2023-02-01', '2023-02-05', 150.0, 'Doe', 'Jane', 1, 1);
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (103, 'R5', '2023-03-01', '2023-03-05', 200.0, 'Brown', 'Bob', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "roomname", "bedtype" FROM "rooms" WHERE ("decor" = 'traditional') ORDER BY roomname, rooms.roomid NULLS LAST;

/*
Gold Result:
('Alpha', 'King')
('Alpha', 'King')
('Alpha', 'Double')
('Beta', 'Queen')
*/

-- Prediction Query
SELECT roomName, bedType FROM Rooms WHERE decor = 'traditional';

/*
Prediction Result:
('Alpha', 'King')
('Alpha', 'King')
('Beta', 'Queen')
('Alpha', 'Double')
*/