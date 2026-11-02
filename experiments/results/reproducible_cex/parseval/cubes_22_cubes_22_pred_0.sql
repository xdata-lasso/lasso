-- Schema DDL
CREATE TABLE "i011_1" ("VehicleID" INTEGER, "Name" TEXT);

CREATE TABLE "i011_2" ("LocationID" INTEGER, "VehicleID" INTEGER, "City" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: i011_1 --
INSERT INTO "i011_1" ("vehicleid", "name") VALUES (1, 'lhs_ff42a0');

INSERT INTO "i011_1" ("vehicleid", "name") VALUES (1, 'lhs_ff42a0');

INSERT INTO "i011_1" ("vehicleid", "name") VALUES (1, 'lhs_ee6c56');

INSERT INTO "i011_1" ("vehicleid", "name") VALUES (1, 'lhs_ff42a0');

INSERT INTO "i011_1" ("vehicleid", "name") VALUES (1, 'lhs_ff42a0');

INSERT INTO "i011_1" ("vehicleid", "name") VALUES (1, 'lhs_ff42a0');

INSERT INTO "i011_1" ("vehicleid", "name") VALUES (1, 'lhs_ff42a0');

INSERT INTO "i011_1" ("vehicleid", "name") VALUES (1, 'lhs_ff42a0');

-- Inserting into table: i011_2 --
INSERT INTO "i011_2" ("locationid", "vehicleid", "city") VALUES (-55602865, 1, 'swwqcgsk');

INSERT INTO "i011_2" ("locationid", "vehicleid", "city") VALUES (1610062532, 1, 'pgu7vfe4');

INSERT INTO "i011_2" ("locationid", "vehicleid", "city") VALUES (1160656988, 1, 'ia2yp');

INSERT INTO "i011_2" ("locationid", "vehicleid", "city") VALUES (-1670923962, 1, 'rwbbp6luhvd');

INSERT INTO "i011_2" ("locationid", "vehicleid", "city") VALUES (-1377057208, 1, 'ilbnp');

INSERT INTO "i011_2" ("locationid", "vehicleid", "city") VALUES (1236688122, 1, 'dpos');

INSERT INTO "i011_2" ("locationid", "vehicleid", "city") VALUES (-1576219117, NULL, '5u');

INSERT INTO "i011_2" ("locationid", "vehicleid", "city") VALUES (1861536320, 1, '6klfa9');

INSERT INTO "i011_2" ("locationid", "vehicleid", "city") VALUES (1620389964, 1, '00t5c4ecigc');

INSERT INTO "i011_2" ("locationid", "vehicleid", "city") VALUES (528680845, 1, '76nium52');

INSERT INTO "i011_2" ("locationid", "vehicleid", "city") VALUES (-443340271, 1, 'uo4nrqrofqy');

INSERT INTO "i011_2" ("locationid", "vehicleid", "city") VALUES (-1106983592, 1, '5bbp0');

INSERT INTO "i011_2" ("locationid", "vehicleid", "city") VALUES (743312762, 1, 'eutliqa11r');

INSERT INTO "i011_2" ("locationid", "vehicleid", "city") VALUES (2137741668, 1, 'ytoo3o9hl7');

INSERT INTO "i011_2" ("locationid", "vehicleid", "city") VALUES (1178636309, 1, 'ex1');

INSERT INTO "i011_2" ("locationid", "vehicleid", "city") VALUES (-74849714, 1, '7zw');

INSERT INTO "i011_2" ("locationid", "vehicleid", "city") VALUES (481163439, 1, '2dwyrq');

INSERT INTO "i011_2" ("locationid", "vehicleid", "city") VALUES (-1097120355, 1, '78d99r');

INSERT INTO "i011_2" ("locationid", "vehicleid", "city") VALUES (-1362461264, 1, 'l0b4y');

INSERT INTO "i011_2" ("locationid", "vehicleid", "city") VALUES (-1116181514, 1, 'i2rkf');

INSERT INTO "i011_2" ("locationid", "vehicleid", "city") VALUES (222415430, 1, 'x58pz');

INSERT INTO "i011_2" ("locationid", "vehicleid", "city") VALUES (-1529584866, 1, 'd2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "vehicleid", "name", "concatcity" FROM (SELECT "LHS"."vehicleid" AS "vehicleid", "LHS"."name" AS "name", "RHS"."concatcity" AS "concatcity" FROM "i011_1" AS "LHS" INNER JOIN (SELECT "vehicleid", GROUP_CONCAT("city", ', ') AS concatcity FROM i011_2 GROUP BY vehicleid) AS RHS ON (LHS.vehicleid = RHS.vehicleid)) ORDER BY vehicleid, "vehicleid" NULLS LAST, "name" NULLS LAST, "concatcity" NULLS LAST;

/*
Gold Result:
(1, 'lhs_ee6c56', 'swwqcgsk, pgu7vfe4, ia2yp, rwbbp6luhvd, ilbnp, dpos, 6klfa9, 00t5c4ecigc, 76nium52, uo4nrqrofqy, 5bbp0, eutliqa11r, ytoo3o9hl7, ex1, 7zw, 2dwyrq, 78d99r, l0b4y, i2rkf, x58pz, d2')
(1, 'lhs_ff42a0', 'swwqcgsk, pgu7vfe4, ia2yp, rwbbp6luhvd, ilbnp, dpos, 6klfa9, 00t5c4ecigc, 76nium52, uo4nrqrofqy, 5bbp0, eutliqa11r, ytoo3o9hl7, ex1, 7zw, 2dwyrq, 78d99r, l0b4y, i2rkf, x58pz, d2')
(1, 'lhs_ff42a0', 'swwqcgsk, pgu7vfe4, ia2yp, rwbbp6luhvd, ilbnp, dpos, 6klfa9, 00t5c4ecigc, 76nium52, uo4nrqrofqy, 5bbp0, eutliqa11r, ytoo3o9hl7, ex1, 7zw, 2dwyrq, 78d99r, l0b4y, i2rkf, x58pz, d2')
(1, 'lhs_ff42a0', 'swwqcgsk, pgu7vfe4, ia2yp, rwbbp6luhvd, ilbnp, dpos, 6klfa9, 00t5c4ecigc, 76nium52, uo4nrqrofqy, 5bbp0, eutliqa11r, ytoo3o9hl7, ex1, 7zw, 2dwyrq, 78d99r, l0b4y, i2rkf, x58pz, d2')
(1, 'lhs_ff42a0', 'swwqcgsk, pgu7vfe4, ia2yp, rwbbp6luhvd, ilbnp, dpos, 6klfa9, 00t5c4ecigc, 76nium52, uo4nrqrofqy, 5bbp0, eutliqa11r, ytoo3o9hl7, ex1, 7zw, 2dwyrq, 78d99r, l0b4y, i2rkf, x58pz, d2')
(1, 'lhs_ff42a0', 'swwqcgsk, pgu7vfe4, ia2yp, rwbbp6luhvd, ilbnp, dpos, 6klfa9, 00t5c4ecigc, 76nium52, uo4nrqrofqy, 5bbp0, eutliqa11r, ytoo3o9hl7, ex1, 7zw, 2dwyrq, 78d99r, l0b4y, i2rkf, x58pz, d2')
(1, 'lhs_ff42a0', 'swwqcgsk, pgu7vfe4, ia2yp, rwbbp6luhvd, ilbnp, dpos, 6klfa9, 00t5c4ecigc, 76nium52, uo4nrqrofqy, 5bbp0, eutliqa11r, ytoo3o9hl7, ex1, 7zw, 2dwyrq, 78d99r, l0b4y, i2rkf, x58pz, d2')
(1, 'lhs_ff42a0', 'swwqcgsk, pgu7vfe4, ia2yp, rwbbp6luhvd, ilbnp, dpos, 6klfa9, 00t5c4ecigc, 76nium52, uo4nrqrofqy, 5bbp0, eutliqa11r, ytoo3o9hl7, ex1, 7zw, 2dwyrq, 78d99r, l0b4y, i2rkf, x58pz, d2')
*/

-- Prediction Query
SELECT i011_1.VehicleID, i011_1.Name, t.concatLocations FROM (SELECT VehicleID, City AS concatLocations FROM i011_2 GROUP BY VehicleID) AS t JOIN i011_1 ON i011_1.VehicleID = t.VehicleID;

/*
Prediction Result:
(1, 'lhs_ff42a0', 'swwqcgsk')
(1, 'lhs_ff42a0', 'swwqcgsk')
(1, 'lhs_ee6c56', 'swwqcgsk')
(1, 'lhs_ff42a0', 'swwqcgsk')
(1, 'lhs_ff42a0', 'swwqcgsk')
(1, 'lhs_ff42a0', 'swwqcgsk')
(1, 'lhs_ff42a0', 'swwqcgsk')
(1, 'lhs_ff42a0', 'swwqcgsk')
*/