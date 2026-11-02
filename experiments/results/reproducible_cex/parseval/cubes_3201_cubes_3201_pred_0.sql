-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: rooms --
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('roo_0d7de5', 'roo_dbe079', 1, 'roo_3dc1a5', 1, 120, 'roo_4e71a6');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('roo_659e30', 'roo_d52115', 1, 'roo_3d51e5', 1, 120, 'roo_6a9502');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT decor, n AS count___ FROM (SELECT decor, COUNT(*) AS n FROM (SELECT * FROM rooms WHERE (baseprice >= 120)) GROUP BY decor) ORDER BY decor, count___ NULLS LAST;

/*
Gold Result:
('roo_4e71a6', 1)
('roo_6a9502', 1)
*/

-- Prediction Query
SELECT decor, COUNT(*) FROM Rooms WHERE basePrice > 120 GROUP BY decor;

/*
Prediction Result:
*/