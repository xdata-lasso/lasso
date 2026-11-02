-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R1', 'Sunrise Suite', 2, 'Queen', 4, 150, 'Modern');
INSERT INTO Rooms (RoomId, roomName, beds, bedType, maxOccupancy, basePrice, decor) VALUES ('R2', 'Pine Cabin', 1, 'King', 2, 120, 'Rustic');
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (1, 'R2', 'R1', '2023-07-05', 150.0, 'Smith', 'Modern', 2, 1);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (2, 'R2', 'R1', '2023-07-05', 150.0, 'Smith', 'Modern', 2, 1);
INSERT INTO Reservations (Code, Room, CheckIn, CheckOut, Rate, LastName, FirstName, Adults, Kids) VALUES (3, 'R1', 'R2', '2023-08-10', 120.0, 'Jones', 'Rustic', 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT COUNT(*) AS n FROM (SELECT code, room, checkin, checkout, rate, lastname, firstname, adults, kids, roomname, beds, bedtype, maxoccupancy, baseprice, roomid, firstname AS decor FROM (SELECT code, room, checkin, checkout, rate, lastname, firstname, adults, kids, roomname, beds, bedtype, maxoccupancy, baseprice, checkin AS roomid FROM (SELECT LHS.code AS code, LHS.room AS room, LHS.checkin AS checkin, LHS.checkout AS checkout, LHS.rate AS rate, LHS.lastname AS lastname, LHS.firstname AS firstname, LHS.adults AS adults, LHS.kids AS kids, RHS.roomname AS roomname, RHS.beds AS beds, RHS.bedtype AS bedtype, RHS.maxoccupancy AS maxoccupancy, RHS.baseprice AS baseprice FROM reservations AS LHS INNER JOIN rooms AS RHS ON (LHS.checkin = RHS.roomid AND LHS.firstname = RHS.decor))))) ORDER BY count___;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM rooms WHERE NOT roomid IN (SELECT DISTINCT room FROM reservations);

/*
Prediction Result:
(0,)
*/