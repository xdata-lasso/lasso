-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('purpose', 'Danielle Taylor', 1001, 'early', 1004, 1007, 'agreement');
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('brother', 'Patrick Gardner', 1008.0, 'mouth', 1015.0, 1020.0, 'option');
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('ago', 'Amanda Davis', 1015.0, 'play', 1026.0, 1033.0, 'decide');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomname FROM (SELECT roomid, roomname, beds, bedtype, maxoccupancy, baseprice, decor, AVG(baseprice) OVER () AS meanbaseprice FROM rooms) WHERE (meanbaseprice <= baseprice) ORDER BY roomname;

/*
Gold Result:
('Amanda Davis',)
('Patrick Gardner',)
*/

-- Prediction Query
SELECT roomName FROM Rooms WHERE basePrice > (SELECT AVG(basePrice) FROM Rooms);

/*
Prediction Result:
('Amanda Davis',)
*/