-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: rooms --
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('roo_418bf9', 'roo_13c102', 2, 'roo_5ae6e3', 1, 3, 'modern');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('roo_24d702', 'roo_a07f67', 3, 'roo_ee03ed', 1, 2, 'modern');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('G', '5k5swwqcgs', 247012447, '8c4pgu7vfe', -1633151678, 1, 'modern');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('roomid_4', 'q_0_d2ec6d', 2, 'a2y', 1115440883, NULL, 'hsrwbbp');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('roomid_5', 'q_0_d2ec6d', NULL, 'luhvdltti', -1364429300, 2, 'nprmdposii');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('A', '5u', 1861536320, '6klfa9', 1620389964, 1, 'modern');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "roomname" FROM (SELECT * FROM "rooms" WHERE ("decor" = 'modern' AND baseprice <> 160)) WHERE (beds = 2 OR baseprice = 2) ORDER BY roomname, "roomname" NULLS LAST;

/*
Gold Result:
('roo_13c102',)
('roo_a07f67',)
*/

-- Prediction Query
SELECT roomName FROM Rooms WHERE basePrice < 160 AND beds = 2 AND decor = 'modern';

/*
Prediction Result:
('roo_13c102',)
*/