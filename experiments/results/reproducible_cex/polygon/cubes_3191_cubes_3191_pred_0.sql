-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('King8', 'King1', 1, 'King11', 1, 1, 'King1');
INSERT INTO "Rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('King7', 'King14', 15, 'King', 16, 17, 'King18');
INSERT INTO "Reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (10, 'King7', 'King1', 'King1', 1, 'King1', 'King1', 1, 1);
INSERT INTO "Reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (9, 'King7', 'King1', 'King1', 1, 'King1', 'King1', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "bedtype", COUNT(*) AS "n" FROM "rooms" GROUP BY "bedtype") WHERE ("bedtype" = 'King') ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Rooms WHERE bedType = 'King';

/*
Prediction Result:
(1,)
*/