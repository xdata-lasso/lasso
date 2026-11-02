-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('ROY', 'Leslie Johnson', 1008, 'better', 1009, 1010, 'discover');
INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (1011, 'ROY', 'early', 'mouth', 1012.5, 'SWEAZY', 'Joy', 1013, 1014);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "kids" FROM "reservations" WHERE ("firstname" = 'ROY' OR "lastname" = 'SWEAZY') ORDER BY kids, reservations.code NULLS LAST;

/*
Gold Result:
(1014,)
*/

-- Prediction Query
SELECT kids FROM Reservations WHERE FirstName = 'ROY' AND LastName = 'SWEAZY';

/*
Prediction Result:
*/