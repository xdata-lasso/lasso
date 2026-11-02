-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('purpose', 'Daniel Doyle', 1001, 'rate', 1005, 1009, 'discussion');
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('brother', 'Stephanie Miller', 1008.0, 'science', 1016.0, 1022.0, 'list');
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('ago', 'Allen Robinson', 1015.0, 'offer', 1027.0, 1035.0, 'perform');
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('site', 'Alyssa Gonzalez', 1022.0, 'kind', 1038.0, 1048.0, 'fall');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomname FROM (SELECT * FROM (SELECT * FROM rooms ORDER BY roomname, rooms.roomid NULLS LAST) LIMIT 1);

/*
Gold Result:
('Allen Robinson',)
*/

-- Prediction Query
SELECT roomName FROM Rooms ORDER BY maxOccupancy DESC, Rooms.roomid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alyssa Gonzalez',)
*/