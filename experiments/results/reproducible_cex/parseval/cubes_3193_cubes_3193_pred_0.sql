-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: rooms --
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('roo_7b2416', 'roo_71cfde', -55602865, 'swwqcgsk', 1610062532, 121, 'pgu7vfe4');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('A', 'roo_71cfde', 1160656988, 'ia2yp', -1670923962, 121, 'rwbbp6luhvd');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('C', 'roo_71cfde', -1377057208, 'ilbnp', 1236688122, 121, 'dpos');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('?', 'ie5', -1209887326, 'klfa9000t', 1408123494, 151, '4');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('@', '5k5swwqcgs', 247012447, '8c4pgu7vfe', -1633151678, 120, 'a2y');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('G', '5k5swwqcgs', 247012447, '8c4pgu7vfe', -1633151678, NULL, 'a2y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomname FROM rooms WHERE (baseprice > 120 AND baseprice <= 150) ORDER BY roomname, rooms.roomid NULLS LAST;

/*
Gold Result:
('roo_71cfde',)
('roo_71cfde',)
('roo_71cfde',)
*/

-- Prediction Query
SELECT roomname FROM rooms WHERE baseprice BETWEEN 120 AND 150;

/*
Prediction Result:
('roo_71cfde',)
('roo_71cfde',)
('roo_71cfde',)
('5k5swwqcgs',)
*/