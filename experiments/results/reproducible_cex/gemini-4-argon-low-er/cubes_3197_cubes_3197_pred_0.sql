-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R1', 'TestRoom', 2, 'Queen', 4, 200, 'modern');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "roomname" FROM (SELECT * FROM "rooms" WHERE ("decor" = 'modern' AND baseprice <> 160)) WHERE (beds = 2 OR baseprice = 2) ORDER BY roomname, "roomname" NULLS LAST;

/*
Gold Result:
('TestRoom',)
*/

-- Prediction Query
SELECT roomName FROM Rooms WHERE basePrice < 160 AND beds = 2 AND decor = 'modern';

/*
Prediction Result:
*/