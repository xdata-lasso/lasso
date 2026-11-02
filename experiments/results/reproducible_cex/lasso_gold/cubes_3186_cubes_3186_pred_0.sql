-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('husband', 'Roy Martin', 1037, 'King', 1039, 1041, 'result');
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('fall', 'Michael Miles', 1044.0, 'Queen', 1050.0, 1054.0, 'raise');
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('away', 'Kimberly Sanchez', 1043, 'King', 1045, 1047, 'rise');
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('politics', 'Devin Schaefer', 1050.0, 'Queen', 1056.0, 1060.0, 'onto');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "roomname" FROM "rooms" WHERE ("bedtype" = 'King' OR "bedtype" = 'Queen') ORDER BY roomname, rooms.roomid NULLS LAST;

/*
Gold Result:
('Devin Schaefer',)
('Kimberly Sanchez',)
('Michael Miles',)
('Roy Martin',)
*/

-- Prediction Query
SELECT roomName FROM Rooms WHERE bedType = 'King' OR bedType = 'Queen';

/*
Prediction Result:
('Roy Martin',)
('Michael Miles',)
('Kimberly Sanchez',)
('Devin Schaefer',)
*/