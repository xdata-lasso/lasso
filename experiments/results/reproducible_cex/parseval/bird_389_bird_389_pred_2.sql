-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: cards --
INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (1, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 787.938887, 'dpos', -1576219117, 75.403642, 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 1898504886, 624571013, 1644911394, -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, -74849714, 105869088, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9', 'rljsl0b4y', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'Creature - Elf', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 'mfg62', '0v', 't1__a1a686', 'q8qdjpe1', 'o22');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483647, 'ttg6bnou5zi3', 'c4bfkfoac', '0', '7z2zezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i', 'lq5lnpim', 'k58qs27p', 452.630377, '94gth', 333302050, 193.695314, 'ajjl', '3', 'okv8uttmu2', 'e578', 'fvy', '7zzbe8y', -705922211, 1043710187, 318331233, -233617564, 79330142, 1735561423, 756202403, 782684333, 681598285, 319284352, 1164790775, -200807520, -790819470, -1278087274, -1140595602, 'wzw', 'chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj', '9erhizgk1yoe', 'o6l0hdt', 'fuqyxuzkb', '521gwnlas6e', 'lboeowii1z5', 'xih6', '2q2xlyoto', '9oaawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', '55', '3dohvu0', 'dza35rmki', '18ri', 'hy08ftp6', 'wt', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 'y', 'yd1jmgjach8', 'qta8y3a17v4y', 'A', 'ma', 'q3qdpua');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483646, 'dqrhm', 'wlic7dn2', 'p490', 'dmsqtg', 'lc', 'qb9i9f', 'ccukjq1q', 'ik1yhb', '8hlst1p', 597.166359, 'omizt', 1793241362, 17.438617, '4iz7', 'aqqlud8ft', '8', '9114q', 'r', '6b', -1537647691, 364280973, 1592061050, -1451520332, -55270062, -1101814296, 1939337883, -996196097, 986268139, 2042428747, 1228655416, -388527046, -1040951738, -1218774640, 697582781, 'c8s3b7v88k', 'dmdbdh', '6j47n', 'ar50hs', 'han', 'xdpunmw', 'wx', 'rlawk', '14r5dqt', 'mg97a', 'z2o20', 'pj6ddlysu6ip', 'dk', 'u2gir31vwq5', 'oa2sb3u', 'i1pa', 'cvwnyq', 'ouirl', 'rpouit63xyf', 'mjwpp2', 'mb3aj0ju0', '3r', '133ir1axyy', 'hpl2i9esap', 'pgckqwtsr', '54o6qjektb1', '2', 'zg3r', 'jkwns47j2j', '8', 'c', 'y', 'vjwq49yr', 'nxs6dvdxdo2v', '7t3gvplj9f', 'vuu', 'Q', '7k10', 'z2my1ogyv1r');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483645, 'x', '1', 'l', 'upgly78oit', 'xeilpe019cy', 'od033dlhd', 'vnhed', '9lqv26u3', '1spxpw30', 22.436232, 'kxginl', 1595944351, 563.529532, 'dmp', '1l2o3ak16', 'ocagjeev', 'zxlu49', 'ubo', '8c', -1943810603, 1557266002, -775706063, -1417040770, 858308694, 625191846, -2065694089, 1868665501, -1896445805, 1104707112, 1551904707, -400879450, -1920675616, -699425950, -432771718, '29835xoepa', 'cxdb2f0c296x', 'yet', 'xjhcf46cf', 'perxa61sjv', 'nv3ddroku', 'zc', 'ehia3', 'm', 'vb7vpc0xff', 'or1esk', 'f9q82', 'g01hu', 'j7f', '8kqhiu5gm8', 'xb', 'qjlsawsp', 'kwi3hl7j', '3y795ybv', '3kr3w4jn2', '19xgjja', 'cgmukfb5if4', '80terbf', 'kvee', 'sltut6lu2', 'cel8mhfcim', 'n5enii0fmbgz', 'oqxs27xh', '88y1k253s', '5', 'ls1ehn1md', 'aqqhyyzsnp64', 'mn', 'w4m0', 'rwbjk', 'bph6gdw', 'G', '7', 'jjplwtlzh42n');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483644, 'qkna', '38gfxswb2d0', 'mxwdb7o', 'p5qo1', '4c6', 'gwnkd4kc3ii', 'axz', '90nhs', '9gob', 24.973024, 'rn5u', 1774110337, 244.070345, 'bnaayvh', 'vyx8scr0fs3', 'qn0b5m2rlxcr', 'fx03rz', 'z8', 'lqme2wb1', -179078143, 2066951993, 795347051, 61145737, 1522069539, -1576807806, -862433074, 80244587, -379984089, -22540009, 505356655, 162901577, -159167628, -43429869, -1887578409, 'ewew092p40', '2vil21', 'sad6q5', 'iqoauy0', '3lwh994f', 'qc1m9gr8xj', 'qbloxd4sj5il', 'wnd6dvygw', 'akmwgw73fy3d', 'dip', 'txfbl10qx6j', 'd4fc75m4s', 'ajdu26xu', 'j90tefx3u5u', '709qf9lx8', 'qzabivuumwu', 'alj0jwk6h', '2o', '79', '50fzrv1l', '930', 'vkviql', 'n0rlpsaxe', 'in', 'bciv', 'ojsmeqv3', '3uxdo', 'a0ol1z', 'mjrssbh72404', 'pp330', 'a1ngqut8', '184dwojdlhlz', 'dyxk', '0a0cql1c8c', 'wvadbp0760', 'gk2hjz', 't2__666a27', 'pg1lcg', 'a4gkjog8d');

-- Inserting into table: rulings --
INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483648, '2024-06-15', '8507cvtjp', 't1__a1a686');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483647, '2024-06-15', '96rn', 'A');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483646, '2024-06-15', 'ez', 'Q');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483645, '2024-06-15', 'j5yrji5', 'G');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (2, '2024-06-15', 'w16f5tqhjd', 't2__666a27');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (3, '2024-06-15', 'mabmkr2t', 't2__666a27');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483642, '2024-06-15', 'dlb6i42', 't1__a1a686');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483641, NULL, 'tew5c29d', 't1__a1a686');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (4, '2025-06-17', '5sw', 't1__a1a686');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (5, '2024-01-05', 'cgsk9', 't1__a1a686');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (6, '2022-04-27', '8c4pgu7vfe', 't1__a1a686');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (7, '2025-06-04', 'hria2ypuzhs', 't1__a1a686');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (8, '2023-01-03', 'wbbp6luhvdlt', 't1__a1a686');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (9, '2023-05-30', 'lbn', 't1__a1a686');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (10, '2022-09-14', 'mdpos', 't1__a1a686');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (11, '2021-06-28', 'e5u', 't1__a1a686');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (12, '2022-06-13', '6klfa9', 't1__a1a686');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.id, T2.date FROM cards AS T1 INNER JOIN rulings AS T2 ON T1.uuid = T2.uuid WHERE T1.originalType = 'Creature - Elf';

/*
Gold Result:
(1, '2024-06-15')
(1, '2024-06-15')
(1, None)
(1, '2025-06-17')
(1, '2024-01-05')
(1, '2022-04-27')
(1, '2025-06-04')
(1, '2023-01-03')
(1, '2023-05-30')
(1, '2022-09-14')
(1, '2021-06-28')
(1, '2022-06-13')
*/

-- Prediction Query
SELECT cards.name, rulings.date FROM cards INNER JOIN rulings ON cards.uuid = rulings.uuid WHERE cards.originalType = 'Creature - Elf';

/*
Prediction Result:
('n2f3dqv0gcb9', '2024-06-15')
('n2f3dqv0gcb9', '2024-06-15')
('n2f3dqv0gcb9', None)
('n2f3dqv0gcb9', '2025-06-17')
('n2f3dqv0gcb9', '2024-01-05')
('n2f3dqv0gcb9', '2022-04-27')
('n2f3dqv0gcb9', '2025-06-04')
('n2f3dqv0gcb9', '2023-01-03')
('n2f3dqv0gcb9', '2023-05-30')
('n2f3dqv0gcb9', '2022-09-14')
('n2f3dqv0gcb9', '2021-06-28')
('n2f3dqv0gcb9', '2022-06-13')
*/