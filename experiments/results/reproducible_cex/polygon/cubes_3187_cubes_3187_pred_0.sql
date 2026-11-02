-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('SWEAZY9', 'SWEAZY', -38600126409872398, 'SWEAZY', -38600126409872398, -38600126409872398, 'SWEAZY');
INSERT INTO "Rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('SWEAZY13', 'SWEAZY', -38600126409872398, 'SWEAZY', -38600126409872398, -38600126409872398, 'SWEAZY');
INSERT INTO "Reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (11, NULL, NULL, NULL, NULL, 'SWEAZY', 'ROY14', NULL, NULL);
INSERT INTO "Reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (10, 'SWEAZY13', 'ROY20', 'SWEAZY21', 22, 'SWEAZY', 'ROY', 23, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "kids" FROM "reservations" WHERE ("firstname" = 'ROY' OR "lastname" = 'SWEAZY') ORDER BY kids, reservations.code NULLS LAST;

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT kids FROM Reservations WHERE FirstName = 'ROY' AND LastName = 'SWEAZY';

/*
Prediction Result:
(None,)
*/