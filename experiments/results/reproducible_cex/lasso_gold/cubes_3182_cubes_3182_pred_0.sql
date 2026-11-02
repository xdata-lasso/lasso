-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('offer', 'Jerry Ramirez', 1016, 'true', 1017, 1018, 'according');
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('fall', 'Tyler Rogers', 1023, 'best', 1024, 1025, 'husband');
INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (1019, 'offer', 'song', 'sure', 1020.5, 'Moore', 'Roberto', 1021, 1022);
INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (1026, 'fall', 'bill', 'her', 1027.5, 'Abbott', 'Cassandra', 1028, 1029);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomname, n AS count___, roomid AS room FROM (SELECT LHS.roomid AS roomid, LHS.roomname AS roomname, LHS.beds AS beds, LHS.bedtype AS bedtype, LHS.maxoccupancy AS maxoccupancy, LHS.baseprice AS baseprice, LHS.decor AS decor, RHS.n AS n FROM rooms AS LHS INNER JOIN (SELECT room, COUNT(*) AS n FROM reservations GROUP BY room) AS RHS ON (LHS.roomid = RHS.room)) ORDER BY roomname, count___ NULLS LAST, room NULLS LAST;

/*
Gold Result:
('Jerry Ramirez', 1, 'offer')
('Tyler Rogers', 1, 'fall')
*/

-- Prediction Query
SELECT T2.roomName, COUNT(*), T1.Room FROM Reservations AS T1 JOIN Rooms AS T2 ON T1.Room = T2.RoomId GROUP BY T1.Room;

/*
Prediction Result:
('Tyler Rogers', 1, 'fall')
('Jerry Ramirez', 1, 'offer')
*/