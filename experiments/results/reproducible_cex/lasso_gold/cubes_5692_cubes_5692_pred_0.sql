-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('purpose', 'Noah Rhodes', 1001, 'save', 1007, 1013, 'source');
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('brother', 'Angie Henderson', 1008.0, 'knowledge', 1018.0, 1026.0, 'great');
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('ago', 'Daniel Wagner', 1015.0, 'grow', 1029.0, 1039.0, 'blue');
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('site', 'Cristian Santos', 1022.0, 'fall', 1040.0, 1052.0, 'best');
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('face', 'Connie Lawrence', 1029.0, 'clearly', 1051.0, 1065.0, 'husband');
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('election', 'Abigail Shaffer', 1036.0, 'dinner', 1062.0, 1078.0, 'bill');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomid, roomname FROM (SELECT * FROM (SELECT * FROM rooms ORDER BY roomname, rooms.roomid NULLS LAST) LIMIT 3);

/*
Gold Result:
('election', 'Abigail Shaffer')
('brother', 'Angie Henderson')
('face', 'Connie Lawrence')
*/

-- Prediction Query
SELECT RoomId, roomName FROM Rooms ORDER BY basePrice DESC, Rooms.roomid NULLS LAST LIMIT 3;

/*
Prediction Result:
('election', 'Abigail Shaffer')
('face', 'Connie Lawrence')
('site', 'Cristian Santos')
*/