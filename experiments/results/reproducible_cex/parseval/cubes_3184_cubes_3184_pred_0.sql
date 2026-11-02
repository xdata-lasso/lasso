-- Schema DDL
CREATE TABLE "Rooms" ("RoomId" TEXT PRIMARY KEY, "roomName" TEXT, "beds" INTEGER, "bedType" TEXT, "maxOccupancy" INTEGER, "basePrice" INTEGER, "decor" TEXT);

CREATE TABLE "Reservations" ("Code" INTEGER PRIMARY KEY, "Room" TEXT, "CheckIn" TEXT, "CheckOut" TEXT, "Rate" REAL, "LastName" TEXT, "FirstName" TEXT, "Adults" INTEGER, "Kids" INTEGER, FOREIGN KEY ("Room") REFERENCES "Rooms" ("RoomId"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: rooms --
INSERT INTO "rooms" ("roomid", "roomname", "beds", "bedtype", "maxoccupancy", "baseprice", "decor") VALUES ('roomid_1', '5k5swwqcgs', 247012447, '8c4pgu7vfe', -1633151678, -252690330, 'uzhs');

-- Inserting into table: reservations --
INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (-2147483648, 'roomid_1', 'rwbbp6luhvd', 'tti', 182.319045, 'res_1ab8a2', 'res_6a7552', -1257178728, 1236688122);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (-2147483647, 'roomid_1', 'dposiie5unw', 'klfa9000t', 827.854302, 'res_1ab8a2', 'res_6a7552', -1964997180, 1149850321);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (-2147483646, 'roomid_1', 'e376nium52', 'zbuo4nrqrof', 586.906897, 'res_1ab8a2', 'res_6a7552', -472966518, -921187550);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (-2147483645, 'roomid_1', 'p', '02eutliqa11r', 997.73177, 'res_1ab8a2', 'res_6a7552', -525979501, 1898504886);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (-2147483644, 'roomid_1', 'o9hl72kl', 'x1', 482.572691, 'res_1ab8a2', 'res_6a7552', 105869088, -2081315180);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (-2147483643, 'roomid_1', 'dwyrq13pyu78', '9', 557.003843, 'res_1ab8a2', 'res_6a7552', -1362461264, -904834265);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (-2147483642, 'roomid_1', '4', 'p5qi2rk', 811.601922, 'res_1ab8a2', 'res_6a7552', -705985602, 537874887);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (-2147483641, 'roomid_1', 'f8jegd2', 'vy9uxj4', 124.573829, 'res_1ab8a2', 'res_6a7552', -2050247126, -736979194);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (-2147483640, 'roomid_1', 'h2gndqwnqcx5', 'hncprjtu0dz', 521.610309, 'res_1ab8a2', 'res_6a7552', -1748371085, -1742081330);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (-2147483639, 'roomid_1', 'f3dqv0gc', '9', 540.154414, 'res_1ab8a2', NULL, 1606439408, 1443629118);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (-2147483638, 'roomid_1', 'bilyrkn', '6vck6ah0f8js', 346.706184, 'res_1ab8a2', NULL, -1388029300, -566887085);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (-2147483637, 'roomid_1', 'xa', '7ryfdrz16n', 130.468488, 'res_1ab8a2', NULL, -1496556994, -2115841792);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (-2147483636, 'roomid_1', 'h', 'ogrgjd8y', 763.019095, NULL, 'res_6a7552', 1250290042, -1717646459);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (-2147483635, 'roomid_1', 'itsj3', 'y', 360.694313, NULL, 'res_6a7552', 1972233925, 1792827279);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (-2147483634, 'roomid_1', '01jh3den', 'c68x8vacx', 516.027628, NULL, 'res_6a7552', -1762140823, 1371234901);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (-2147483633, 'roomid_1', '1of77pzo72c', 'dctmf', 102.360106, 'res_1ab8a2', 'res_6a7552', 7929158, -1744557630);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (-2147483632, 'roomid_1', 'q8qdjpe1', 'o22', 518.274259, 'res_1ab8a2', 'res_6a7552', 2004147439, -691774480);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (-2147483631, 'roomid_1', 'ttg6', 'n', 918.655561, 'res_1ab8a2', 'res_6a7552', 944975670, -1575410149);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (-2147483630, 'roomid_1', 'bfkfoacd', '7z2zezj', 837.309049, 'res_1ab8a2', 'res_6a7552', -604098478, 1248858185);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (-2147483629, 'roomid_1', 'ysxcmr0o', 'ztdgj5i3lq5l', 811.930904, 'res_1ab8a2', 'res_6a7552', -1556979799, -55240145);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (-2147483628, 'roomid_1', 'qs27p2r94', 'th', 577.602934, 'res_1ab8a2', 'res_6a7552', 1162591638, -2136247961);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (-2147483627, 'roomid_1', 'a3o', 'v8u', 311.951038, NULL, 'ROY', 618058035, 1553368934);

INSERT INTO "reservations" ("code", "room", "checkin", "checkout", "rate", "lastname", "firstname", "adults", "kids") VALUES (2, 'roomid_1', '57', 'lfvyz7zzb', 70.267562, 'yvkv42q7sx58', 'b4pmaus3auv', -1278087274, -1140595602);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "firstname", "lastname", COUNT(*) AS "n" FROM "reservations" GROUP BY "firstname", "lastname") WHERE ("firstname" = 'ROY' OR "lastname" = 'SWEAZY') ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Reservations WHERE FirstName = 'ROY' AND LastName = 'SWEAZY';

/*
Prediction Result:
(0,)
*/