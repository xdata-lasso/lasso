-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('hear', 'Mark Ferguson', 1037, 'hospital', 1038, 1039, 'traditional');
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('husband', 'Mark Diaz', 1038, 'raise', 1039, 1040, 'traditional');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "roomname", "bedtype" FROM "rooms" WHERE ("decor" = 'traditional') ORDER BY roomname, rooms.roomid NULLS LAST;

/*
Gold Result:
('Mark Diaz', 'raise')
('Mark Ferguson', 'hospital')
*/

-- Prediction Query
SELECT roomName, bedType FROM Rooms WHERE decor = 'traditional';

/*
Prediction Result:
('Mark Ferguson', 'hospital')
('Mark Diaz', 'raise')
*/