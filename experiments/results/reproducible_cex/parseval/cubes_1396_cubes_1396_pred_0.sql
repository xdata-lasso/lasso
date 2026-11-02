-- Schema DDL
CREATE TABLE "chip_model" ("Model_name" TEXT PRIMARY KEY, "Launch_year" REAL, "RAM_MiB" REAL, "ROM_MiB" REAL, "Slots" TEXT, "WiFi" TEXT, "Bluetooth" TEXT);

CREATE TABLE "screen_mode" ("Graphics_mode" REAL PRIMARY KEY, "Char_cells" TEXT, "Pixels" TEXT, "Hardware_colours" REAL, "used_kb" REAL, "map" TEXT, "Type" TEXT);

CREATE TABLE "phone" ("Hardware_Model_name" TEXT PRIMARY KEY, "chip_model" TEXT, "screen_mode" TEXT, "Company_name" TEXT, "Accreditation_type" TEXT, "Accreditation_level" TEXT, "Date" TEXT, FOREIGN KEY ("chip_model") REFERENCES "chip_model" ("Model_name"), FOREIGN KEY ("screen_mode") REFERENCES "screen_mode" ("Graphics_mode"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: chip_model --
INSERT INTO "chip_model" ("model_name", "launch_year", "ram_mib", "rom_mib", "slots", "wifi", "bluetooth") VALUES ('model_name_1', 582.588439, 680.190136, 487.053947, 'swwqcgsk', '9n8c4pgu7v', 'e4');

-- Inserting into table: screen_mode --
INSERT INTO "screen_mode" ("graphics_mode", "char_cells", "pixels", "hardware_colours", "used_kb", "map", "type") VALUES (779.409124, 'hria2ypuzhs', 'rwbbp6luhvd', 179.378884, 304.02808, 'bnp', 'mdpos');

-- Inserting into table: phone --
INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('hardware_m_1', 'model_name_1', '779.409124', 'ie5', 'nw6klf', 'pho_b7e11b', 'a9000t5c4eci');

INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('hardware_m_2', 'model_name_1', '779.409124', 'e376nium52', 'zbuo4nrqrof', 'pho_b7e11b', 'qyp5s5bbp0');

INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('hardware_m_3', 'model_name_1', '779.409124', 'tliqa1', 'ryytoo3', 'pho_b7e11b', '9hl7');

INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('hardware_m_4', 'model_name_1', '779.409124', 'ex1', 'ji7zwau2', 'pho_b7e11b', 'dwyrq13pyu78');

INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('A', 'model_name_1', '779.409124', 'jsl', 'b4yp5qi', 'pho_b7e11b', 'rkf9vqx5');

INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('C', 'model_name_1', '779.409124', 'f8jegd2', 'vy9uxj4', 'pho_b7e11b', 'wb');

INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('hardware_m_5', 'model_name_1', '779.409124', 'ph2', 'nd', 'pho_b7e11b', 'wnqcx');

INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('hardware_m_8', 'model_name_1', '779.409124', 'cprj', 'u0dz7', 'pho_b7e11b', 'fjgq8n2f3');

INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('hardware_m_9', 'model_name_1', '779.409124', '0gcb98', 'zk3z', 'pho_b7e11b', 'i');

INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('hardware__10', 'model_name_1', '779.409124', 'kn6vc', '6ah', 'pho_b7e11b', 'f8jswwl');

INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('hardware__11', 'model_name_1', '779.409124', '7', '2fxa7ryfdrz', 'pho_b7e11b', '16nijjai5dh');

INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('hardware__12', 'model_name_1', '779.409124', 'rg', 'd8y', NULL, 't1afgog');

INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('hardware__13', 'model_name_1', '779.409124', 'tsj3ayxp1q4', '01jh3den', NULL, 'c68x8vacx');

INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('hardware__14', 'model_name_1', '779.409124', '5w1of7', 'pzo72ctdc', NULL, 'mfg62');

INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('hardware__15', 'model_name_1', '779.409124', '5q8qdj', 'e1io', NULL, '278507cv');

INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('hardware__16', 'model_name_1', '779.409124', 'ttg6', 'n', 'pho_b7e11b', 'u5zi');

INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('hardware__17', 'model_name_1', '779.409124', 'bfkfoacd', '7z2zezj', 'pho_b7e11b', '7wgx');

INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('hardware__18', 'model_name_1', '779.409124', 'sxcmr0o', 'ztdgj5i3lq5l', 'pho_b7e11b', 'pim5');

INSERT INTO "phone" ("hardware_model_name", "chip_model", "screen_mode", "company_name", "accreditation_type", "accreditation_level", "date") VALUES ('hardware__19', 'model_name_1', '779.409124', 'qs27p2r94', 'th', 'pho_b7e11b', '2mnajjla3o');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT accreditation_level FROM (SELECT accreditation_level, accreditation_type, COUNT(*) AS n FROM phone GROUP BY accreditation_level, accreditation_type) WHERE (n > 3) ORDER BY accreditation_level;

/*
Gold Result:
*/

-- Prediction Query
SELECT Accreditation_level FROM phone GROUP BY Accreditation_level HAVING COUNT(*) > 3;

/*
Prediction Result:
(None,)
('pho_b7e11b',)
*/