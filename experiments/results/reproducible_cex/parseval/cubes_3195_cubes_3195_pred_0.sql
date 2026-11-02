-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: rooms --
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('roo_43972a', 'roo_cea05b', -55602865, 'swwqcgsk', 0, NULL, '9n8c4pgu7v');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('A', 'e4', 1160656988, 'ia2yp', -1670923962, 160, 'rwbbp6luhvd');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('?', '5k5swwqcgs', 247012447, '8c4pgu7vfe', 2, 160, 'hria2ypu');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('@', 'hsrwbbp', 13244799, 'hvdltt', NULL, 160, 'lbn');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('`', 'rmdp', 2026480202, 'ie5', 1, 159, 'nw6klf');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('C', 'a9000t5c4eci', 1149850321, 'e', 2, 159, '76nium52');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomname, roomid FROM rooms WHERE (baseprice >= 160 OR maxoccupancy < 2) ORDER BY roomname, rooms.roomid NULLS LAST;

/*
Gold Result:
('5k5swwqcgs', '?')
('e4', 'A')
('hsrwbbp', '@')
('rmdp', '`')
('roo_cea05b', 'roo_43972a')
*/

-- Prediction Query
SELECT roomName, RoomId FROM Rooms WHERE basePrice > 160 AND maxOccupancy > 2;

/*
Prediction Result:
*/