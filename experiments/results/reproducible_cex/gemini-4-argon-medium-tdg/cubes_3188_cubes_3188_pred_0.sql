-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R1', 'Recluse and defiance', 2, 'King', 4, 200, 'Modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R2', 'Recluse and defiance', 1, 'Queen', 2, 150, 'Modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R3', 'Recluse and defiance', 2, 'Double', 4, 180, 'Rustic');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R4', 'Recluse and defiance', 1, 'King', 2, 220, 'Traditional');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R5', 'Recluse and defiance', 1, 'Queen', 2, 120, NULL);
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R6', 'Recluse and Defiance', 1, 'Queen', 2, 150, 'Contemporary');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R7', 'Recluse and defiance ', 1, 'Queen', 2, 150, 'Minimalist');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R8', 'Other Room', 2, 'King', 4, 250, 'Modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R9', NULL, 2, 'King', 4, 250, 'Bohemian');
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (101, 'R1', '2023-01-01', '2023-01-05', 200.0, 'Smith', 'John', 2, 0);
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (102, 'R1', '2023-02-01', '2023-02-05', 200.0, 'Doe', 'Jane', 1, 1);
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (103, 'R8', '2023-03-01', '2023-03-05', 250.0, 'Brown', 'Charlie', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "decor" FROM "rooms" WHERE ("roomname" = 'Recluse and defiance') ORDER BY decor, rooms.roomid NULLS LAST;

/*
Gold Result:
(None,)
('Modern',)
('Modern',)
('Rustic',)
('Traditional',)
*/

-- Prediction Query
SELECT decor FROM Rooms WHERE roomName = 'Recluse and defiance';

/*
Prediction Result:
('Modern',)
('Modern',)
('Rustic',)
('Traditional',)
(None,)
*/