-- Schema DDL
CREATE TABLE "phone" ("Phone_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Memory_in_G" INTEGER, "Carrier" TEXT, "Price" REAL);

CREATE TABLE "market" ("Market_ID" INTEGER PRIMARY KEY, "District" TEXT, "Num_of_employees" INTEGER, "Num_of_shops" REAL, "Ranking" INTEGER);

CREATE TABLE "phone_market" ("Market_ID" INTEGER, "Phone_ID" TEXT, "Num_of_stock" INTEGER, PRIMARY KEY ("Market_ID", "Phone_ID"), FOREIGN KEY ("Phone_ID") REFERENCES "phone" ("Phone_ID"), FOREIGN KEY ("Market_ID") REFERENCES "market" ("Market_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: phone --
INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483648, 'pho_e0edd7', -55602865, 'pho_acdf55', 486.033807);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483647, 'pho_e0edd7', -664303813, 'pho_acdf55', 833.684115);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483646, 'pho_e0edd7', -1022641847, 'pho_acdf55', 97.952323);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483645, 'pho_e0edd7', 247012447, 'pho_acdf55', 868.436572);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483644, 'pho_e0edd7', -1980249628, 'pho_acdf55', 249.706432);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483643, 'pho_e0edd7', -734455130, 'pho_acdf55', 906.21648);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483642, NULL, -1633151678, 'pho_acdf55', 134.487977);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483641, NULL, -252690330, 'pho_acdf55', 797.015047);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483640, NULL, 1115440883, 'pho_acdf55', 882.963176);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483639, 'pho_e0edd7', 1465859724, NULL, 294.861575);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483638, 'pho_e0edd7', -1349201381, NULL, 737.440743);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483637, 'pho_e0edd7', -1910425938, NULL, 303.05704);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483636, 'pho_e0edd7', -1610064545, 'pho_acdf55', 22.535764);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483635, 'pho_e0edd7', 429706943, 'pho_acdf55', 240.969194);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483634, 'pho_e0edd7', 462974032, 'pho_acdf55', 792.223623);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483633, 'pho_e0edd7', -1137908826, 'pho_acdf55', 619.836822);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483632, 'pho_e0edd7', -918961358, 'pho_acdf55', 126.856521);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483631, 'pho_e0edd7', -45536098, 'pho_acdf55', 933.422701);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483630, 'pho_e0edd7', 44952191, 'pho_acdf55', 768.216462);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483629, 'pho_e0edd7', 1620389964, 'pho_acdf55', 627.258639);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483628, 'pho_e0edd7', 947159877, 'pho_acdf55', 963.351729);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483627, 'pho_e0edd7', 1408123494, 'pho_acdf55', 983.124993);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483626, 'pho_e0edd7', -1964997180, 'pho_acdf55', 734.586266);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483625, 'pho_e0edd7', 1149850321, 'pho_acdf55', 44.682291);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483624, 'pho_e0edd7', -1833165707, 'pho_acdf55', 517.275698);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483623, 'pho_e0edd7', 1155439218, 'pho_acdf55', 805.746877);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483622, 'pho_e0edd7', -761141909, 'pho_acdf55', 779.28645);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483621, 'pho_e0edd7', 283598170, 'pho_acdf55', 452.706544);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483620, 'pho_e0edd7', 742285925, 'pho_acdf55', 21.917736);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483619, 'pho_e0edd7', -747753377, 'pho_acdf55', 478.908865);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483618, 'pho_e0edd7', 902887186, 'pho_acdf55', 979.158161);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483617, 'pho_e0edd7', -967741825, 'pho_acdf55', 680.514642);

INSERT INTO "phone" ("phone_id", "name", "memory_in_g", "carrier", "price") VALUES (-2147483616, 'pho_e0edd7', 373262291, 'pho_acdf55', 389.878901);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT carrier FROM (SELECT * FROM (SELECT * FROM (SELECT carrier, name, COUNT(*) AS n FROM phone GROUP BY carrier, name) ORDER BY name DESC) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Carrier FROM phone GROUP BY Carrier ORDER BY COUNT(*) DESC, Carrier NULLS LAST LIMIT 1;

/*
Prediction Result:
('pho_acdf55',)
*/