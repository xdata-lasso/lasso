-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('save', 'Donald Lewis', 1022, 'source', 1023, 1024, 'Matthew');
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