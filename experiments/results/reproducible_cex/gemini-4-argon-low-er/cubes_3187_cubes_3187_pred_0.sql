-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Rooms" ("RoomId", "roomName", "beds", "bedType", "maxOccupancy", "basePrice", "decor") VALUES ('R1', 'Ocean View', 2, 'Queen', 4, 150, 'Modern');
INSERT INTO "Reservations" ("Code", "Room", "CheckIn", "CheckOut", "Rate", "LastName", "FirstName", "Adults", "Kids") VALUES (1, 'R1', '2023-01-01', '2023-01-05', 150.0, 'SMITH', 'ROY', 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "kids" FROM "reservations" WHERE ("firstname" = 'ROY' OR "lastname" = 'SWEAZY') ORDER BY kids, reservations.code NULLS LAST;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT kids FROM Reservations WHERE FirstName = 'ROY' AND LastName = 'SWEAZY';

/*
Prediction Result:
*/