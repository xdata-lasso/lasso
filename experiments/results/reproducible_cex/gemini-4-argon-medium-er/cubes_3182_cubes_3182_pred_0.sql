-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R1', 'Zebra Room', 1, 'King', 2, 100, 'Modern');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R2', 'Alpha Room', 1, 'Queen', 2, 100, 'Modern');
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (1, 'R1', '2023-01-01', '2023-01-02', 100.0, 'Smith', 'John', 1, 0);
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (2, 'R2', '2023-01-01', '2023-01-02', 100.0, 'Doe', 'Jane', 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomname, n AS count___, roomid AS room FROM (SELECT LHS.roomid AS roomid, LHS.roomname AS roomname, LHS.beds AS beds, LHS.bedtype AS bedtype, LHS.maxoccupancy AS maxoccupancy, LHS.baseprice AS baseprice, LHS.decor AS decor, RHS.n AS n FROM rooms AS LHS INNER JOIN (SELECT room, COUNT(*) AS n FROM reservations GROUP BY room) AS RHS ON (LHS.roomid = RHS.room)) ORDER BY roomname, count___ NULLS LAST, room NULLS LAST;

/*
Gold Result:
('Alpha Room', 1, 'R2')
('Zebra Room', 1, 'R1')
*/

-- Prediction Query
SELECT T2.roomName, COUNT(*), T1.Room FROM Reservations AS T1 JOIN Rooms AS T2 ON T1.Room = T2.RoomId GROUP BY T1.Room;

/*
Prediction Result:
('Zebra Room', 1, 'R1')
('Alpha Room', 1, 'R2')
*/