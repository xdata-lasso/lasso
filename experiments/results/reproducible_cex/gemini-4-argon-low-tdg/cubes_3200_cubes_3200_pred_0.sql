-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R1', 'Charlie', 2, 'Queen', 4, 100, 'Modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R2', 'Bravo', 1, 'King', 2, 150, 'Rustic');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R3', 'Alpha', 3, 'Double', 6, 200, 'Traditional');
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (101, 'R3', '2023-01-01', '2023-01-05', 200.0, 'Smith', 'John', 2, 0);
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (102, 'R3', '2023-02-01', '2023-02-05', 200.0, 'Doe', 'Jane', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomname FROM (SELECT roomid, roomname, beds, bedtype, maxoccupancy, baseprice, decor, AVG(baseprice) OVER () AS meanbaseprice FROM rooms) WHERE (meanbaseprice <= baseprice) ORDER BY roomname;

/*
Gold Result:
('Alpha',)
('Bravo',)
*/

-- Prediction Query
SELECT roomName FROM Rooms WHERE basePrice > (SELECT AVG(basePrice) FROM Rooms);

/*
Prediction Result:
('Alpha',)
*/