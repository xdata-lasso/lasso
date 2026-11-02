-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests swapped column comparisons (e.g., CheckOut vs CheckIn, LastName vs FirstName, roomName vs RoomId)
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('A1', 'B1', 1, 'King', 2, 120, 'Classic');
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('B1', 'A1', 2, 'Queen', 4, 180, 'Vintage');
-- Decoy 1: CheckOut = RoomId ('A1') and LastName = decor ('Classic'), but CheckIn and FirstName do not match
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (201, 'A1', '2023-05-01', 'A1', 120.0, 'Classic', 'John', 2, 0);
-- Decoy 2: CheckIn = roomName ('B1' for Room A1) and FirstName = decor ('Classic')
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (202, 'A1', 'B1', '2023-05-02', 120.0, 'Doe', 'Classic', 1, 0);
-- Decoy 3: Crossed attributes - CheckIn = decor ('Classic') and FirstName = RoomId ('A1')
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (203, 'A1', 'Classic', '2023-05-03', 120.0, 'Doe', 'A1', 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT COUNT(*) AS n FROM (SELECT code, room, checkin, checkout, rate, lastname, firstname, adults, kids, roomname, beds, bedtype, maxoccupancy, baseprice, roomid, firstname AS decor FROM (SELECT code, room, checkin, checkout, rate, lastname, firstname, adults, kids, roomname, beds, bedtype, maxoccupancy, baseprice, checkin AS roomid FROM (SELECT LHS.code AS code, LHS.room AS room, LHS.checkin AS checkin, LHS.checkout AS checkout, LHS.rate AS rate, LHS.lastname AS lastname, LHS.firstname AS firstname, LHS.adults AS adults, LHS.kids AS kids, RHS.roomname AS roomname, RHS.beds AS beds, RHS.bedtype AS bedtype, RHS.maxoccupancy AS maxoccupancy, RHS.baseprice AS baseprice FROM reservations AS LHS INNER JOIN rooms AS RHS ON (LHS.checkin = RHS.roomid AND LHS.firstname = RHS.decor))))) ORDER BY count___;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(*) FROM rooms WHERE NOT roomid IN (SELECT DISTINCT room FROM reservations);

/*
Prediction Result:
(1,)
*/