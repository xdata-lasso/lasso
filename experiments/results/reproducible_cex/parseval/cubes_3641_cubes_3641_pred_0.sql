-- Schema DDL
CREATE TABLE "aircraft" ("Aircraft_ID" INTEGER PRIMARY KEY, "Order_Year" INTEGER, "Manufacturer" TEXT, "Model" TEXT, "Fleet_Series" TEXT, "Powertrain" TEXT, "Fuel_Propulsion" TEXT);

CREATE TABLE "pilot" ("Pilot_ID" INTEGER PRIMARY KEY, "Pilot_name" TEXT, "Rank" INTEGER, "Age" INTEGER, "Nationality" TEXT, "Position" TEXT, "Join_Year" INTEGER, "Team" TEXT);

CREATE TABLE "pilot_record" ("Pilot_ID" INTEGER, "Aircraft_ID" INTEGER, "Date" TEXT, "Record_ID" INTEGER, PRIMARY KEY ("Pilot_ID", "Aircraft_ID", "Date"), FOREIGN KEY ("Aircraft_ID") REFERENCES "aircraft" ("Aircraft_ID"), FOREIGN KEY ("Pilot_ID") REFERENCES "pilot" ("Pilot_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: pilot --
INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483648, '5k5swwqcgs', 247012447, 1, '8c4pgu7vfe', 'pil_aa59cc', -1633151678, 'a2y');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483647, 'uzhs', 700293388, 1, 'wbbp6luhvdlt', 'pil_aa59cc', -841692980, 'bnp');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483646, 'mdpos', -1576219117, 1, '5u', 'pil_aa59cc', 1861536320, '6klfa9');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (1, 'lhs_28a2e5', 1, 1, 'lhs_bd1714', 'lhs_562099', 1, 'lhs_45cb48');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483644, '00t5c4e', 1274489983, 1, 'gce', 'pil_aa59cc', -1585009206, '52zb');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483643, 'uo4nrqrofqy', -1106983592, 1, '5bbp0', 'pil_aa59cc', 743312762, 'eutliqa11r');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483642, 'ytoo3o9', -1666765085, 1, '72klex14ji7z', 'pil_aa59cc', -2081315180, '2dwyrq13pyu7');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483641, 'd99rljsl0', -2031361952, 1, NULL, 'pil_aa59cc', 1649269347, 'p5qi2rkf9v');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483640, 'x58pz', -1529584866, 1, NULL, 'pil_aa59cc', 1196308825, 'd21vy9uxj4hw');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483639, 'd', -736979194, 1, NULL, 'pil_aa59cc', 2103044118, 'h2gndqwnqcx5');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483638, 'hncprjtu0dz', -1748371085, 1, 'q8', 'pil_aa59cc', -1255130038, NULL);

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483637, '3d', 513454646, 1, '0gcb98', 'pil_aa59cc', -1454058168, NULL);

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483636, 'bilyrkn', -688098735, 1, '6ah', 'pil_aa59cc', -348113485, NULL);

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483635, 'jswwlq7xb', 602161869, 1, 'xa', 'pil_aa59cc', NULL, '7ryfdrz16n');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483634, 'jja', -7597509, 1, 'h5ogrgjd8yz', 'pil_aa59cc', NULL, '1afgo');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483633, 'ri', -902895762, 1, 'ayxp1q43', 'pil_aa59cc', NULL, '1jh3den');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483632, NULL, 357330522, 1, '68x8vacx7a', 'pil_aa59cc', 2078438287, '5w1of7');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483631, NULL, 76996700, 1, 'o72ctdc', 'pil_aa59cc', 1303877941, 'mfg62g0v5q8q');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483630, NULL, -1488156735, 1, '1i', 'pil_aa59cc', 1897687032, '278507cv');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483629, 'jpttg', -2033879835, NULL, 'u5zi', 'pil_aa59cc', 1944978593, 'bfkfoacd');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483628, '7z2zezj', 1448731351, NULL, 'wgxd5ysxc', 'pil_aa59cc', -405743609, 'g');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483627, '5i3', -1405314653, NULL, '5lnpim5k58qs', 'pil_aa59cc', 1615073310, '7p2r94gth2m');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483626, 'ajjl', NULL, 1, '3', 'pil_aa59cc', 1803796945, '8uttmu');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483625, 'ne578lfv', NULL, 1, 'yz7zzbe8yvk', 'pil_aa59cc', 1043710187, '42q7sx58b4');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483624, 'pmaus3auvmkr', NULL, 1, 'pdjwzw5chn9', 'pil_aa59cc', 101754718, 'a9n0jxfo');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483623, 'ws', 1719800120, 1, 'o', NULL, 1010672881, 'obb0q0k');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483622, '2odwcl5a', 292557306, 1, 'orlwyngc1dj', NULL, 211603887, 'rhizgk1yoey');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483621, 'o6l0hdt6fu', -477129795, 1, 'uzkb521gwnl', NULL, 1718516876, '6elbo');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483620, 'ow', -1589605308, 1, 'z5nxih6', 'pil_aa59cc', -251205568, 'xlyotow9');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483619, 'aawg', 1044710644, 1, 'qb0tbindz39t', 'pil_aa59cc', 2038321753, 'z9t');

INSERT INTO "pilot" ("pilot_id", "pilot_name", "rank", "age", "nationality", "position", "join_year", "team") VALUES (-2147483618, '8', 748154000, 1, 'cgumbc', 'pil_aa59cc', 1295379066, 'd0w9603vzxw1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nationality FROM (SELECT LHS.pilot_id AS pilot_id, LHS.pilot_name AS pilot_name, LHS.rank AS rank, LHS.age AS age, LHS.nationality AS nationality, LHS.position AS POSITION, LHS.join_year AS join_year, LHS.team AS team FROM pilot AS LHS INNER JOIN (SELECT POSITION, MAX(n) AS n FROM (SELECT age, POSITION, COUNT(*) AS n FROM pilot GROUP BY age, POSITION) GROUP BY POSITION) AS RHS ON (LHS.pilot_id = RHS.n AND LHS.position = RHS.position)) ORDER BY nationality;

/*
Gold Result:
('lhs_bd1714',)
*/

-- Prediction Query
SELECT Nationality FROM pilot GROUP BY Nationality ORDER BY COUNT(*) DESC, Nationality NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/