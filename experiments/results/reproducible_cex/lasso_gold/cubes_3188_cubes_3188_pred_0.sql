-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('PM', 'Recluse and defiance', 1037, 'everything', 1038, 1039, 'guy');
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('her', 'Recluse and defiance', 1038, 'throw', 1039, 1040, 'animal');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "decor" FROM "rooms" WHERE ("roomname" = 'Recluse and defiance') ORDER BY decor, rooms.roomid NULLS LAST;

/*
Gold Result:
('animal',)
('guy',)
*/

-- Prediction Query
SELECT decor FROM Rooms WHERE roomName = 'Recluse and defiance';

/*
Prediction Result:
('guy',)
('animal',)
*/