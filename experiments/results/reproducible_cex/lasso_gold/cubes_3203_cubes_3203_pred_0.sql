-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('better', 'Olivia Moore', 1007, 'decide', 1008, 1009, 'sense');
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('rate', 'Jonathan Johnson', 1008, 'fall', 1009, 1010, 'table');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomname FROM rooms ORDER BY roomname, rooms.roomid NULLS LAST;

/*
Gold Result:
('Jonathan Johnson',)
('Olivia Moore',)
*/

-- Prediction Query
SELECT roomName FROM Rooms ORDER BY basePrice, Rooms.roomid NULLS LAST;

/*
Prediction Result:
('Olivia Moore',)
('Jonathan Johnson',)
*/