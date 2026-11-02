-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: rooms --
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('roomid_1', '5k5swwqcgs', 247012447, '8c4pgu7vfe', -1633151678, -252690330, 'uzhs');

-- Inserting into table: reservations --
INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (1, 'roomid_1', 'rwbbp6luhvd', 'tti', 182.319045, NULL, 'ROY', -1257178728, 1);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (2, 'roomid_1', 'dpos', 'ie5', 327.753528, NULL, 'ROY', -1209887326, 1);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (3, 'roomid_1', 'fa9', '00t5c4e', 950.466571, NULL, 'ROY', 1274489983, 1);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (4, 'roomid_1', 'e376nium52', 'zbuo4nrqrof', 586.906897, 'SWEAZY', 'p5s5bbp', 882961052, 743312762);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (5, 'roomid_1', 'tliqa1', 'ryytoo3', 228.583847, 'SWEAZY', 'ROY', -1666765085, 1178636309);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "kids" FROM "reservations" WHERE ("firstname" = 'ROY' OR "lastname" = 'SWEAZY') ORDER BY kids, reservations.code NULLS LAST;

/*
Gold Result:
(1,)
(1,)
(1,)
(743312762,)
(1178636309,)
*/

-- Prediction Query
SELECT kids FROM Reservations WHERE FirstName = 'ROY' AND LastName = 'SWEAZY';

/*
Prediction Result:
(1178636309,)
*/