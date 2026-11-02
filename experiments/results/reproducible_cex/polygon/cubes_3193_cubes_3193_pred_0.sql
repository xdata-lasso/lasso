-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('8', NULL, 11, '12', 13, 121, '14');
INSERT INTO "Rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('7', NULL, 15, '16', 17, 120, '18');
INSERT INTO "Reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (10, '7', '19', '19', 19, '19', '19', 19, 19);
INSERT INTO "Reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (9, '7', '19', '19', 19, '19', '19', 19, 19);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomname FROM rooms WHERE (baseprice > 120 AND baseprice <= 150) ORDER BY roomname, rooms.roomid NULLS LAST;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT roomname FROM rooms WHERE baseprice BETWEEN 120 AND 150;

/*
Prediction Result:
(None,)
(None,)
*/