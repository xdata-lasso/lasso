-- Schema DDL
CREATE TABLE "company" ("Company_ID" INTEGER PRIMARY KEY, "Rank" INTEGER, "Company" TEXT, "Headquarters" TEXT, "Main_Industry" TEXT, "Sales_billion" REAL, "Profits_billion" REAL, "Assets_billion" REAL, "Market_Value" REAL);

CREATE TABLE "gas_station" ("Station_ID" INTEGER PRIMARY KEY, "Open_Year" INTEGER, "Location" TEXT, "Manager_Name" TEXT, "Vice_Manager_Name" TEXT, "Representative_Name" TEXT);

CREATE TABLE "station_company" ("Station_ID" INTEGER, "Company_ID" INTEGER, "Rank_of_the_Year" INTEGER, PRIMARY KEY ("Station_ID", "Company_ID"), FOREIGN KEY ("Company_ID") REFERENCES "company" ("Company_ID"), FOREIGN KEY ("Station_ID") REFERENCES "gas_station" ("Station_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: gas_station --
INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (-2147483648, -55602865, 'swwqcgsk', 'gas_819b24', '9n8c4pgu7v', 'e4');

INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (-2147483647, 1160656988, 'ia2yp', 'gas_819b24', 'uzhsrwbbp6lu', 'hvdlttilbnpr');

INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (-2147483646, 2087640001, 'dposiie5unw', 'gas_819b24', 'klfa9000t', 'c4ecigce');

INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (-2147483645, -1585009206, '52zb', 'gas_819b24', 'uo4nrqrofqy', '5s5b');

INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (-2147483644, 2107872094, '02eutliqa11r', 'gas_819b24', 'ytoo3o9', 'l7');

INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (-2147483643, 1178636309, 'ex1', 'gas_819b24', 'ji7zwau2', 'dwyrq13pyu78');

INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (-2147483642, 244829661, 'jsl', 'gas_819b24', 'b4yp5qi', 'rkf9vqx5');

INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (-2147483641, 1836127587, 'f8jegd2', 'gas_819b24', 'vy9uxj4', 'wb');

INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (-2147483640, -1929953647, 'ph2', 'gas_819b24', 'nd', 'wnqcx');

INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (-2147483639, 722884590, 'hncprjtu0dz', 'gas_819b24', '9fjgq8n2f', 'dqv0gcb9');

INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (-2147483638, 172461907, 'k3zbily', 'gas_819b24', 'kn6vc', '6ah');

INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (-2147483637, -348113485, 'jswwlq7xb', 'gas_819b24', '72fxa7ryfd', 'z16ni');

INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (-2147483636, 2011234363, 'ai5', NULL, 'h', 'ogrgjd8y');

INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (-2147483635, 1129658414, '1afgo', NULL, 'ri', 'tsj3ayxp1q4');

INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (-2147483634, -1538707438, 'den8c68x', NULL, 'vacx7afu5', '1of77p');

INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (-2147483633, -435350511, '72ctdctmfg62', NULL, '0v', 'q8qdjpe1');

INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (-2147483632, -1180042408, '78507cvt', NULL, 'ptt', '6b');

INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (-2147483631, -1171104889, '5zi36c4bfkfo', 'gas_819b24', 'c', '0');

INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (-2147483630, 76987628, 'zezjo7wg', 'gas_819b24', 'd5ysxc', 'r0oz');

INSERT INTO "gas_station" ("station_id", "open_year", "location", "manager_name", "vice_manager_name", "representative_name") VALUES (-2147483629, -870767087, 'j5', 'gas_819b24', '3lq', '5lnpim5k58qs');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT manager_name FROM (SELECT manager_name, COUNT(DISTINCT open_year) AS n_distinct FROM gas_station GROUP BY manager_name) WHERE (n_distinct >= 2000 OR n_distinct <> 1) ORDER BY manager_name;

/*
Gold Result:
(None,)
('gas_819b24',)
*/

-- Prediction Query
SELECT manager_name FROM gas_station WHERE open_year > 2000 GROUP BY manager_name ORDER BY COUNT(*) DESC, manager_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('gas_819b24',)
*/