-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('12', '28', NULL, NULL, NULL, -133, NULL);
INSERT INTO "Rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('9', '31', 14, '16', 18, -132, '20');
INSERT INTO "Reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (11, '9', '-133', '-133', -133, '-133', '-133', -133, -133);
INSERT INTO "Reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (10, '9', '-133', '-133', -133, '-133', '-133', -133, -133);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomname FROM (SELECT roomid, roomname, beds, bedtype, maxoccupancy, baseprice, decor, AVG(baseprice) OVER () AS meanbaseprice FROM rooms) WHERE (meanbaseprice <= baseprice) ORDER BY roomname;

/*
Gold Result:
('31',)
*/

-- Prediction Query
SELECT roomName FROM Rooms WHERE basePrice > (SELECT AVG(basePrice) FROM Rooms);

/*
Prediction Result:
('31',)
*/