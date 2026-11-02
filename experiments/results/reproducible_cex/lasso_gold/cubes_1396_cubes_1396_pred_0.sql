-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('Audrey Williams', 1241.5, 1245.5, 1249.5, 'now', 'short', 'real');
INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('Zachary Wilson', 1246.5, 1252.5, 1258.5, 'kind', 'clear', 'bit');
INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('Joshua Price', 1251.5, 1259.5, 1267.5, 'people', 'value', 'these');
INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('Travis Horton', 1256.5, 1266.5, 1276.5, 'situation', 'join', 'might');
INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('Sarah Curtis', 1265.5, 1269.5, 1273.5, 'late', 'house', 'matter');
INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('Michelle Lewis', 1270.5, 1276.5, 1282.5, 'form', 'claim', 'audience');
INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('Darryl Morgan', 1275.5, 1283.5, 1291.5, 'reduce', 'right', 'benefit');
INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('Jason Davis', 1280.5, 1290.5, 1300.5, 'especially', 'wind', 'theory');
INSERT INTO "screen_mode" ("graphics_mode", "char_cells", "pixels", "hardware_colours", "used_kb", "map", "type") VALUES (1253.5, '+1-764-205-3773x515', 'area', 1257.5, 1261.5, 'never', 'maybe');
INSERT INTO "screen_mode" ("graphics_mode", "char_cells", "pixels", "hardware_colours", "used_kb", "map", "type") VALUES (1254.5, '(543)317-1390x0532', 'card', 1266.5, 1272.5, 'build', 'list');
INSERT INTO "screen_mode" ("graphics_mode", "char_cells", "pixels", "hardware_colours", "used_kb", "map", "type") VALUES (1255.5, '001-683-493-3529x04228', 'site', 1275.5, 1283.5, 'skill', 'star');
INSERT INTO "screen_mode" ("graphics_mode", "char_cells", "pixels", "hardware_colours", "used_kb", "map", "type") VALUES (1256.5, '402-605-3950', 'know', 1284.5, 1294.5, 'attack', 'high');
INSERT INTO "screen_mode" ("graphics_mode", "char_cells", "pixels", "hardware_colours", "used_kb", "map", "type") VALUES (1277.5, '716-315-2809', 'change', 1281.5, 1285.5, 'skin', 'kind');
INSERT INTO "screen_mode" ("graphics_mode", "char_cells", "pixels", "hardware_colours", "used_kb", "map", "type") VALUES (1278.5, '(556)304-9451x98327', 'sit', 1290.5, 1296.5, 'nice', 'long');
INSERT INTO "screen_mode" ("graphics_mode", "char_cells", "pixels", "hardware_colours", "used_kb", "map", "type") VALUES (1279.5, '(285)614-9368x998', 'property', 1299.5, 1307.5, 'dinner', 'growth');
INSERT INTO "screen_mode" ("graphics_mode", "char_cells", "pixels", "hardware_colours", "used_kb", "map", "type") VALUES (1280.5, '8243455022', 'allow', 1308.5, 1318.5, 'however', 'coach');
INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('Ashley Gordon', 'Audrey Williams', 1253.5, 'Simmons-Rodriguez', 'nice', 'financial', 'long');
INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('Amanda Logan', 'Audrey Williams', 1253.5, 'Browning, Jones and Miller', 'nice', 'financial', 'mouth');
INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('Kelly Ellis', 'Audrey Williams', 1253.5, 'Hernandez, Martinez and Weber', 'nice', 'financial', 'point');
INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('Amy Mendoza', 'Audrey Williams', 1253.5, 'Kelley, Nguyen and Vang', 'nice', 'financial', 'law');
INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('Nathan Frank', 'Sarah Curtis', 1277.5, 'Perry-Lewis', 'student', 'financial', 'around');
INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('Angela Williams', 'Sarah Curtis', 1277.5, 'Wilson, Jordan and Campbell', 'student', 'financial', 'account');
INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('Luke Craig', 'Sarah Curtis', 1277.5, 'Watkins, Rose and Parker', 'student', 'financial', 'democratic');
INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('Matthew Tucker', 'Sarah Curtis', 1277.5, 'Foster PLC', 'student', 'financial', 'fish');
INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('Pamela Duran', 'Sarah Curtis', 1277.5, 'Foster PLC', 'student', 'financial', 'fish');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT accreditation_level FROM (SELECT accreditation_level, accreditation_type, COUNT(*) AS n FROM phone GROUP BY accreditation_level, accreditation_type) WHERE (n > 3) ORDER BY accreditation_level;

/*
Gold Result:
('financial',)
('financial',)
*/

-- Prediction Query
SELECT Accreditation_level FROM phone GROUP BY Accreditation_level HAVING COUNT(*) > 3;

/*
Prediction Result:
('financial',)
*/