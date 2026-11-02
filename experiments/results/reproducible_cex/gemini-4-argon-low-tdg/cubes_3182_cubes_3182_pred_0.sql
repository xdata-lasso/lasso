-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R1', 'Ocean View', 2, 'Queen', 4, 200, 'Modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R2', 'Mountain View', 1, 'King', 2, 150, 'Rustic');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R3', 'Ocean View', 1, 'King', 2, 180, 'Modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R4', 'Garden Suite', 3, 'Twin', 6, 300, 'Traditional');
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (101, 'R1', '2023-01-01', '2023-01-05', 200.0, 'Smith', 'John', 2, 0);
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (102, 'R1', '2023-02-01', '2023-02-05', 200.0, 'Doe', 'Jane', 1, 1);
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (103, 'R2', '2023-03-01', '2023-03-05', 150.0, 'Brown', 'Charlie', 2, 2);
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (104, 'R3', '2023-04-01', '2023-04-05', 180.0, 'Smith', 'John', 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomname, n AS count___, roomid AS room FROM (SELECT LHS.roomid AS roomid, LHS.roomname AS roomname, LHS.beds AS beds, LHS.bedtype AS bedtype, LHS.maxoccupancy AS maxoccupancy, LHS.baseprice AS baseprice, LHS.decor AS decor, RHS.n AS n FROM rooms AS LHS INNER JOIN (SELECT room, COUNT(*) AS n FROM reservations GROUP BY room) AS RHS ON (LHS.roomid = RHS.room)) ORDER BY roomname, count___ NULLS LAST, room NULLS LAST;

/*
Gold Result:
('Mountain View', 1, 'R2')
('Ocean View', 1, 'R3')
('Ocean View', 2, 'R1')
*/

-- Prediction Query
SELECT T2.roomName, COUNT(*), T1.Room FROM Reservations AS T1 JOIN Rooms AS T2 ON T1.Room = T2.RoomId GROUP BY T1.Room;

/*
Prediction Result:
('Ocean View', 2, 'R1')
('Mountain View', 1, 'R2')
('Ocean View', 1, 'R3')
*/