-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests accidental INNER JOIN or fan-out with Reservations (rooms with 0, 1, and multiple reservations).
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R1', 'Unbooked King', 1, 'King', 2, 100, 'modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R2', 'MultiBooked Queen', 2, 'Queen', 4, 150, 'rustic');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R3', 'Booked Twin', 2, 'Twin', 2, 80, 'traditional');
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (101, 'R2', '2023-01-01', '2023-01-05', 150.0, 'Smith', 'John', 2, 0);
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (102, 'R2', '2023-02-01', '2023-02-05', 150.0, 'Doe', 'Jane', 1, 1);
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (103, 'R3', '2023-03-01', '2023-03-05', 80.0, 'Brown', 'Bob', 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "roomname" FROM "rooms" WHERE ("bedtype" = 'King' OR "bedtype" = 'Queen') ORDER BY roomname, rooms.roomid NULLS LAST;

/*
Gold Result:
('MultiBooked Queen',)
('Unbooked King',)
*/

-- Prediction Query
SELECT roomName FROM Rooms WHERE bedType = 'King' OR bedType = 'Queen';

/*
Prediction Result:
('Unbooked King',)
('MultiBooked Queen',)
*/