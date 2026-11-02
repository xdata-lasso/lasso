-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: rooms --
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('roo_92e860', 'roo_0615ad', -55602865, 'swwqcgsk', 1610062532, -106629402, 'u7');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('roo_e9eb53', 'roo_eef99e', -734455130, '4h', -992890117, 1914020640, 'ypuzhsrw');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('roo_299992', 'roo_fd50b1', 1908028688, 'p', 13244799, -1659388584, 'l');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('(', 'roo_0615ad', -845863578, 'lbn', 462974032, 1, 'posiie5unw6k');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('A', 'roo_eef99e', 1151980946, 'a9', 1620389964, 0, '00t5c4ecigc');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('!', 'roo_0615ad', 528680845, '76nium52', -443340271, 1, 'uo4nrqrofqy');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('c', 'roo_eef99e', -1106983592, '5bbp0', 743312762, 0, 'eutliqa11r');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('L', 'roo_0615ad', 2137741668, 'ytoo3o9hl7', 1178636309, 1, 'ex1');

INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('M', 'roo_eef99e', -74849714, '7zw', 481163439, 0, '2dwyrq');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT roomid, roomname FROM (SELECT * FROM (SELECT * FROM rooms ORDER BY roomname, rooms.roomid NULLS LAST) LIMIT 3);

/*
Gold Result:
('!', 'roo_0615ad')
('(', 'roo_0615ad')
('L', 'roo_0615ad')
*/

-- Prediction Query
SELECT RoomId, roomName FROM Rooms ORDER BY basePrice DESC, Rooms.roomid NULLS LAST LIMIT 3;

/*
Prediction Result:
('roo_e9eb53', 'roo_eef99e')
('!', 'roo_0615ad')
('(', 'roo_0615ad')
*/