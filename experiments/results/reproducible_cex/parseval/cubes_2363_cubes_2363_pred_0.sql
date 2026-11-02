-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: county_public_safety --
INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483648, '5k5swwqcgs', 247012447, 1, -1980249628, -734455130, 906.21648, 'hria2ypu', 'hsrwbbp');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483647, 'luhvdltti', -1364429300, 1, -1257178728, 1236688122, 986.066566, 'dposiie5unw', 'klfa9000t');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483646, 'c4ecigce', -1585009206, 1, -53231346, -443340271, 676.357279, '4nrq', 'rofqyp5s5b');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (1, 'lhs_87582d', 1, 1, 1, 1, 1.0, 'lhs_0af4fd', 'lhs_47c2e7');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483644, 'p', 882961052, 1, 743312762, -1822992503, 297.722676, 'qa1', 'ryytoo3');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483643, '9hl7', 1178636309, 1, -1390245819, 1055976837, 913.303855, 'ji7zwau2', 'dwyrq13pyu78');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483642, '9', 244829661, 1, -1362461264, -904834265, 419.361606, 'yp5qi2rk', '9v');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483641, 'x58pz', -1529584866, 1, NULL, 1196308825, 712.084197, '1vy9uxj4', 'wb');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483640, 'v', 1581736075, 1, NULL, -261132974, 795.815869, 'dqwn', 'cx5hn');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483639, 'p', -988981234, 1, NULL, -841004020, 415.830002, '79fjgq8', 'n2f3dqv0gcb9');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483638, NULL, 172461907, 1, 1606439408, 1443629118, 463.845085, 'i', 'yrk');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483637, NULL, 32204797, 1, -1672720816, -1520489792, 346.706184, 'q7x', '7');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483636, NULL, 602161869, 1, 1350414441, 2094425101, 9.896305, 'ryfdrz16n', 'jja');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483635, '5dh', 1583472758, 1, 1449284300, -977470238, NULL, 'd8y', 't1afgog');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483634, 'itsj3', -491938169, 1, -106471771, 1235416111, NULL, 'jh3den8', 'c68x8vacx7');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483633, 'f', -47052816, 1, 645287482, 765724008, NULL, '7pzo72ctd', 't');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483632, 'mfg62g0v5q8q', NULL, 1, -1488156735, -1858644047, 140.053935, '2278', '07cvtjpt');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483631, 'tg6bnou5zi', NULL, 1, 1944978593, 1722106924, 17.379583, 'foa', 'cd07z2zezjo7');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483630, 'wgxd5ysxcm', NULL, 1, 1721638020, 983324983, 906.680956, 'ztdg', '5i3');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483629, 'q5l', 1339733032, 1, -1556979799, -55240145, 821.273487, 'qs27p2r94', NULL);

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483628, 'th', 333302050, 1, 1162591638, -2136247961, 155.873695, '3', NULL);

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483627, 'okv8uttmu2', -1252009958, 1, 1908593332, 697257217, 392.947196, 'zzbe8yvkv', NULL);

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483626, '42q7sx58b4', -1122409769, 1, 1849819405, -929383517, 13.328055, NULL, 'mkrpdj');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483625, 'wzw5chn9mo70', 628082526, 1, -1245584612, 1731843275, 364.404955, NULL, 'fwsz');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483624, 'o', 1010672881, 1, -1197954156, -2019656607, 260.170162, NULL, '0k32odwcl5a');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483623, 'msorlwyngc', -323362455, NULL, 453340472, 211603887, 633.999218, 'hizgk', 'yoeyo6l');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483622, 'hdt6fuq', 1294064538, NULL, 778835680, 1755752040, 852.508842, 'b52', 'gwnlas6');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483621, 'elboeowii1', -457369423, NULL, 1557188093, 548968280, 138.537557, '62q2xlyot', 'ow9oaawg96a');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483620, 'qb0tbindz39t', 2038321753, 1, 1376887048, NULL, 560.916337, '8', '5wcg');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483619, 'mbc3td', 1964331395, 1, -1943814113, NULL, 790.320515, '9603vz', 'xw1rxe9yfk7');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (-2147483618, 'k162n', -516345261, 1, -1191116453, NULL, 898.062947, '06dza3', 'rmkio18r');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (2, 'i2hy08ftp6', -1853955201, -805997097, -586285368, 1664452437, 919.033168, 'aby', 'mzn2mfx7h3');

INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (3, 'p6sto1cj', 1728926031, -63214972, 1106724223, 1966809332, 290.411595, 'y', 'yd1jmgjach8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT LHS.county_id AS county_id, LHS.name AS name, LHS.population AS population, LHS.police_officers AS police_officers, LHS.residents_per_officer AS residents_per_officer, LHS.case_burden AS case_burden, LHS.crime_rate AS crime_rate, LHS.police_force AS police_force, LHS.location AS LOCATION FROM county_public_safety AS LHS INNER JOIN (SELECT police_officers, COUNT(*) AS n FROM county_public_safety GROUP BY police_officers) AS RHS ON (LHS.county_id = RHS.n AND LHS.police_officers = RHS.police_officers)) ORDER BY LOCATION;

/*
Gold Result:
*/

-- Prediction Query
SELECT LOCATION FROM county_public_safety GROUP BY LOCATION ORDER BY COUNT(*) DESC, LOCATION NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/