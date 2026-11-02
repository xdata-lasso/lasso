-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R2', 'Royal Suite', 2, 'King', 4, 250, 'Modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R1', 'Royal Suite', 1, 'King', 2, 200, 'Rustic');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R3', 'Azure Retreat', 1, 'King', 2, 180, 'Coastal');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R4', 'Azure Retreat', 2, 'King', 4, 220, 'Coastal');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R5', 'Cozy Corner', 2, 'Queen', 4, 150, 'Traditional');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R6', 'Budget Inn', 1, 'Double', 2, 100, 'Modern');
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (101, 'R1', '2023-01-01', '2023-01-05', 200.0, 'Smith', 'John', 2, 0);
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (102, 'R1', '2023-02-01', '2023-02-05', 210.0, 'Doe', 'Jane', 1, 1);
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (103, 'R5', '2023-03-01', '2023-03-05', 150.0, 'Brown', 'Charlie', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "roomname", "decor" FROM "rooms" WHERE ("bedtype" = 'King') ORDER BY roomname, rooms.roomid NULLS LAST;

/*
Gold Result:
('Azure Retreat', 'Coastal')
('Azure Retreat', 'Coastal')
('Royal Suite', 'Rustic')
('Royal Suite', 'Modern')
*/

-- Prediction Query
SELECT roomName, decor FROM Rooms WHERE bedtype = 'King' ORDER BY basePrice, Rooms.roomid NULLS LAST;

/*
Prediction Result:
('Azure Retreat', 'Coastal')
('Royal Suite', 'Rustic')
('Azure Retreat', 'Coastal')
('Royal Suite', 'Modern')
*/