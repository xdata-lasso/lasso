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
INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (2, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 787.938887, 'dpos', -1576219117, 75.403642, 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 1898504886, 624571013, 1644911394, -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, -74849714, 105869088, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9', 'rljsl0b4y', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', 't1__eb5683', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 't1__435d71', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 'mfg62', 'A', '0v', 'q8qdjpe1');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (3, 'o22', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', '0', '7z2zezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i', 458.880538, '5lnpi', -1300180872, 167.377262, '8qs27p2r', '4gth2mnaj', 'la3', 'okv8uttmu2', 'e578', 'fvy', -451030047, -2052653308, -489120589, -72442907, -2060082151, -1122409769, 1849819405, -929383517, -2090240067, -699574669, 274891948, 609771851, -1934017803, 1105964624, -663234145, 'h', '9mo7', '5a9n0jx', 'of', 'szdo2z', 'obb0q0k32o', 'w', 'l', '5amsorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 'dt', 'fuqyxuzkb', 't1__eb5683', '521gwnlas6e', 'lboeowii1z5', 'xih6', '2q2xlyoto', '9oaawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', '55', 't1__67610c', '3dohvu0', 'dza35rmki', '18ri', 'hy08ftp6', 'wt', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'C', 'sh5knzys7', 'y');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (5, 'vnhed', '9lqv26u3', '1spxpw30', 'g', 'kxginl', '6id', 'p61l', 'o3ak162o', 'cagjeevxzxlu', 989.611258, '9kuboe8c', -1943810603, 862.579245, 'ekhllb', 'vdpu5v', 'eduy9v2', '129835x', 'epac', 'db2f0c', -537413388, 2011754567, 1755688363, 1177967285, -2001463367, -2003500453, 1280646590, -568125159, -329270684, -1517724233, -1265768652, 2081562124, -1879135081, -958249959, -1446721688, 'zc', 'ehia3', 'm', 'vb7vpc0xff', 'or1esk', 'f9q82', 'g01hu', 'j7f', '8kqhiu5gm8', 'xb', 'qjlsawsp', 'kwi3hl7j', '3y795ybv', '3kr3w4jn2', '19xgjja', 'cgmukfb5if4', '80terbf', 'kvee', 'sltut6lu2', 'cel8mhfcim', 'n5enii0fmbgz', 'oqxs27xh', '88y1k253s', '5', 'ls1ehn1md', 'aqqhyyzsnp64', 'mn', 'E', 'w4m0', 'rwbjk', 'bph6gdw', '7', 'jjplwtlzh42n', 'j5yrji5', 'qkna', '38gfxswb2d0', 'uuid_3', 'mxwdb7o', 'p5qo1');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (7, '4c6', 'gwnkd4kc3ii', 'axz', '90nhs', '9gob', '6', 'rn5u', 'phy', 'n', 846.321829, 'y', 2017526622, 791.561184, 'yx8scr', 'fs3qn0b', 'm2rlxcrw', 'x0', '3rzgz84lqm', '2w', -2071541072, -179078143, 2066951993, 795347051, 61145737, 1522069539, -1576807806, -862433074, 80244587, -379984089, -22540009, 505356655, 162901577, -159167628, -43429869, '6dpe', 'ew092p', '0u2vil21', 'sad6q5', 'iqoauy0', '3lwh994f', 'qc1m9gr8xj', 'qbloxd4sj5il', 'wnd6dvygw', 'akmwgw73fy3d', 'dip', 'txfbl10qx6j', 'd4fc75m4s', 'ajdu26xu', 'j90tefx3u5u', '709qf9lx8', 'qzabivuumwu', 'alj0jwk6h', '2o', '79', '50fzrv1l', '930', 'vkviql', 'n0rlpsaxe', 'in', 'bciv', 'ojsmeqv3', 'E', '3uxdo', 'a0ol1z', 'mjrssbh72404', 'pp330', 'a1ngqut8', '184dwojdlhlz', 'dyxk', '0a0cql1c8c', 'uuid_4', 'wvadbp0760', 'gk2hjz');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (4, 'dlb6i42', 'tew5c29d', 't1havc', 'c4zpw867', 'fve0jf4i', 't99kvnbh', 'i6tp3t', 'nd', 'w89qy', 507.928493, 'u4euf', -1588383617, 980.244198, '8of6bp9qgjra', 'f', 'j8', 'zr6k53p8e5o', 'f0y', '1u', -1457401052, 903854855, -1701090371, -1531116262, 1617485225, -1232470711, 615649657, -779262852, -592652905, -271011446, -2104463468, -2006745200, -1815891316, -758991421, -1400298523, 'dbp3cehye3', 'ylci', 'if0ly46upl', 'eoh3m3q0pq97', '534', '5xb', '11y', 'pzc7x', 'v4pmp', 'jve', '2', 'rn6j7', '2vkwegrf6snl', '5jw5pbgw', 'ojnhh6va3tdx', 'hn75b733', '58zb', 'yx', '0twou', '4', 'yi4h5c4f1q', '9w43ial8s8', 'sp4j9fod', 't9kcq2iae6', 'j', 'ql1676lk8', 'azkjy', 't1__67eb84', 'fxsove98b8', '0235v8ik', '3qu7', 'cxswgr124', 'u6v8hk', 'lzy93zu8yb', '4qpog5smdhct', 'nj8y6whwhl', 'uuid_5', '5i', 'dtdjm8r');

-- Inserting into table: sets --
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, -531932574, 'jmgjach', 'qta8y3a17', 't1__435d71', -735270562, 614314115, 306260487, 1168225104, -499203870, 'qdpuap96', 1291298007, 1982265552, 'dqrhm', 'wlic7dn2', 'p490', 'dmsqtg', '2020-09-18', -1391541536, -1025517017, 'i9f2ccukj');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, 1040753276, 'pqomizt', 'vb6m4iz78aq', 'E', -1043357093, -753065777, 190510318, -835782528, 192271618, '9114qbre6bj', -752650834, 2134937984, '8kj', '85', 'pxlvri', 'surz0kaqtncg', '2020-05-16', 1446366856, 438933248, '88kwdmdbdht6');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, 2014610660, 'wfwx', 'rlawk', 'I', 558684943, -120625031, 572453185, 1348973408, -911953404, '97', -2098439423, -459764012, '20pj', 'ddlysu6ip', 'dk', 'u2gir31vwq5', '2024-10-28', -1204806277, 1813968674, 'sb3uoi1pavcv');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, -614741184, '26mb', 'aj0ju0h3', 'G', 1089332183, -167036460, -987989989, -2103849024, -485095266, 'hpl2i9esap', -1452518801, -662859586, 'r54o6', 'jektb', '1d2nzg3rjk', 'ns47j2', '2021-08-23', -1881008758, -1955129162, 'vjwq49yr');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, 209226821, 'hw6lv7j452', '1qz', 't1__67eb84', 1308402480, -817991918, -752197316, -120730142, 1580796530, '0gwtfhk1', 1444022422, 1393890798, 'j', 'suy', '6h', 'zboodl', '2024-07-17', 22415446, -1609119007, 'fc2vfg');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, '1quik', 't1__435d71', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483647, 'yhb08hl', 't1__435d71', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483646, 'j47nxar50h', 'E', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 'sjhanzxdpu', 'E', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, 'wnyqrouirlrp', 'I', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483643, 'ouit63xyfvmj', 'I', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483642, 'nxs6dvdxdo2v', 'G', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483641, '7t3gvplj9f', 'G', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483640, 'vuu', 't1__435d71', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483639, '7k10', 't1__435d71', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483638, 'z2my1ogyv1r', 't1__435d71', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483637, 'ez', 't1__435d71', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483636, 'x', 't1__435d71', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483635, '1', 't1__435d71', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483634, 'l', 't1__435d71', 't2__efb6e1');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483633, 'upgly78oit', 't1__435d71', 't2__2f5e17');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483632, 'xeilpe019cy', 't1__435d71', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483631, 'od033dlhd', 't1__435d71', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, 'pg1lcg', 'E', 'a4gkjog8d');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 'w16f5tqhjd', 'E', 'mabmkr2t');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 'ix', 't1__67eb84', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.name FROM cards AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.setCode WHERE T2.translation = 'Hauptset Zehnte Edition';

/*
Gold Result:
('t1__eb5683',)
('3kr3w4jn2',)
('ajdu26xu',)
*/

-- Prediction Query
SELECT cards.name FROM cards INNER JOIN set_translations ON cards.setcode = set_translations.setcode WHERE set_translations.translation = 'Hauptset Zehnte Edition';

/*
Prediction Result:
('t1__eb5683',)
('t1__eb5683',)
('3kr3w4jn2',)
('ajdu26xu',)
('3kr3w4jn2',)
('ajdu26xu',)
('t1__eb5683',)
('t1__eb5683',)
('t1__eb5683',)
('t1__eb5683',)
('t1__eb5683',)
('t1__eb5683',)
('t1__eb5683',)
('t1__eb5683',)
*/