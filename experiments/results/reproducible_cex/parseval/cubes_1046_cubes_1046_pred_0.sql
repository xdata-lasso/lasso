-- Schema DDL
CREATE TABLE "station" ("id" INTEGER PRIMARY KEY, "name" TEXT, "lat" REAL, "long" REAL, "dock_count" INTEGER, "city" TEXT, "installation_date" TEXT);

CREATE TABLE "status" ("station_id" INTEGER, "bikes_available" INTEGER, "docks_available" INTEGER, "time" TEXT, FOREIGN KEY ("station_id") REFERENCES "station" ("id"));

CREATE TABLE "trip" ("id" INTEGER PRIMARY KEY, "duration" INTEGER, "start_date" TEXT, "start_station_name" TEXT, "start_station_id" INTEGER, "end_date" TEXT, "end_station_name" TEXT, "end_station_id" INTEGER, "bike_id" INTEGER, "subscription_type" TEXT, "zip_code" INTEGER);

CREATE TABLE "weather" ("date" TEXT, "max_temperature_f" INTEGER, "mean_temperature_f" INTEGER, "min_temperature_f" INTEGER, "max_dew_point_f" INTEGER, "mean_dew_point_f" INTEGER, "min_dew_point_f" INTEGER, "max_humidity" INTEGER, "mean_humidity" INTEGER, "min_humidity" INTEGER, "max_sea_level_pressure_inches" REAL, "mean_sea_level_pressure_inches" REAL, "min_sea_level_pressure_inches" REAL, "max_visibility_miles" INTEGER, "mean_visibility_miles" INTEGER, "min_visibility_miles" INTEGER, "max_wind_Speed_mph" INTEGER, "mean_wind_speed_mph" INTEGER, "max_gust_speed_mph" INTEGER, "precipitation_inches" INTEGER, "cloud_cover" INTEGER, "events" TEXT, "wind_dir_degrees" INTEGER, "zip_code" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: trip --
INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (2, 100, '5k5swwqcgs', 'tri_271e8f', 247012447, '8c4pgu7vfe', 'hria2ypu', 1644814318, 1465859724, 'rwbbp', 13244799);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (3, 100, 'hvdltt', 'tri_271e8f', -1610064545, 'n', 'rmdp', 2026480202, -1576219117, '5u', 1861536320);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (4, 101, '6klfa9', '00t5c4e', 1274489983, 'gce', '76nium52', -443340271, 757448742, '4nrq', 418417917);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (5, NULL, 'fqyp', 's5bbp02e', -751275471, 'iqa', '1ryytoo', 1644911394, -1666765085, '72klex14ji7z', -2081315180);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (6, 100, '2dwyrq13pyu7', NULL, 244829661, 'jsl', 'b4yp5qi', -227162283, 2056419640, 'vqx58pz0f', 176555546);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483643, -1937207087, 'vy9uxj4', 'C', -1612443122, 'd', 'lph2gn', 1968874827, -664193365, 'cx5hn', -1106350634);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483642, -1509264256, '0dz79f', 'A', -1485777725, '8n2f3', 'dqv0gcb98ozk', -155284187, 1686459626, 'lyr', 1038566008);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483641, 32204797, 'k', 'O', 37673509, 'h0f8jswwlq', 'xb72fxa7r', -515895469, 1427161052, 'z16ni', 2011234363);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483640, -1483100200, '5dh', 'A', 1583472758, 'rg', 'd8y', 1129658414, 1250290042, 'og', -946046410);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483639, -902895762, 'ayxp1q43', 'G', 1235416111, 'jh3den8', 'c68x8vacx7', 1523825314, 2078438287, '5w1of7', 76996700);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483638, -435350511, '72ctdctmfg62', 'A', -1744557630, '5q8qdj', 'e1io', -241848752, 2004147439, 'tjpttg', -2033879835);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483637, 1798111945, '5zi36c', 'O', 1722106924, 'f', 'foa', 382831862, -406331049, 'ezjo7wg', 1248858185);

INSERT INTO "trip" ("id", "duration", "start_date", "start_station_name", "start_station_id", "end_date", "end_station_name", "end_station_id", "bike_id", "subscription_type", "zip_code") VALUES (-2147483636, -57705450, 'xcmr0', 'A', 1269522000, 'ztdgj5i3lq5l', 'pim5', -1125548818, 1497321728, '4gth2mnaj', -1478011227);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT start_station_name FROM trip WHERE (duration <= 100) ORDER BY start_station_name;

/*
Gold Result:
(None,)
('A',)
('C',)
('G',)
('tri_271e8f',)
*/

-- Prediction Query
SELECT DISTINCT start_station_name FROM trip WHERE duration < 100;

/*
Prediction Result:
('C',)
('A',)
('G',)
*/