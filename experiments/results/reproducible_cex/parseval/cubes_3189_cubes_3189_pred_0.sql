-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: rooms --
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('rhs_4efb6c', 'rhs_87fa54', 1, 'rhs_748962', 1, 1, '5k5swwqcgs');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('lhs_2c523e', '9n8', 1610062532, 'pgu7vfe4', 1160656988, -992890117, 'a2ypuzhsrwbb');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('rhs_e13ff8', 'rhs_3498a0', 1, 'rhs_8fb265', 1, 1, 'p6luhvdlttil');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('lhs_684f53', 'n', 462974032, 'posiie5unw6k', 1151980946, 1620389964, '00t5c4ecigc');

-- Inserting into table: reservations --
INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (1, 'lhs_2c523e', 'lhs_9154c1', 'lhs_59e61a', 1.0, 'lhs_b620db', 'lhs_1673d4', 1, 1);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (-2147483647, 'lhs_684f53', 'lhs_1e5c0d', 'lhs_2e3458', 1.0, 'lhs_599c76', 'lhs_3ca15c', 1, 1);
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
(2,)
*/