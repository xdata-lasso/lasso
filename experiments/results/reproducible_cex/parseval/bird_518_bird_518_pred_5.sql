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
INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 787.938887, 'dpos', -1576219117, 75.403642, 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 1898504886, 624571013, 1644911394, -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, -74849714, 105869088, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9', 'rljsl0b4y', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', 't1__7981cc', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 'mfg62', '0v', 't1__73113d', 'q8qdjpe1', 'o22');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (2, '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', '0', '7z2zezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i', 'lq5lnpim', 487.138399, '8qs27p2r', -95808609, 306.477948, '2m', 'ajjl', '3', 'okv8uttmu2', 'e578', 'fvy', -451030047, -2052653308, -489120589, -72442907, -2060082151, -1122409769, 1849819405, -929383517, -2090240067, -699574669, 274891948, 609771851, -1934017803, 1105964624, -663234145, 'h', '9mo7', '5a9n0jx', 'of', 'szdo2z', 'obb0q0k32o', 'w', 'l', '5amsorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 'dt', 'fuqyxuzkb', 't1__7981cc', '521gwnlas6e', 'lboeowii1z5', 'xih6', '2q2xlyoto', '9oaawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', '55', '3dohvu0', 'dza35rmki', '18ri', 'hy08ftp6', 'wt', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 'C', 'y', 'yd1jmgjach8');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (3, 'qta8y3a17v4y', 'ma', 'q3qdpua', '96rn', 'dqrhm', 'wlic7dn2', 'p490', 'dmsqtg', 'lc', 321.654734, 'b9i9f', -788896327, 141.072566, '1quik1yhb08h', 'st1', 'qomi', 'tvb6m4i', '78aqqlu', '8', 948460309, 1183069552, -1057355067, -1004098188, 316163741, -752650834, 2134937984, 1379644459, 136003842, -1486030107, 1138926079, -609840352, 486475144, -679850352, 1205111943, '0kaqtnc', 'gc8s3b7v88k', 'dmdbdh', '6j47n', 'ar50hs', 'han', 'xdpunmw', 'wx', 'rlawk', '14r5dqt', 'mg97a', 'z2o20', 'pj6ddlysu6ip', 't1__7981cc', 'dk', 'u2gir31vwq5', 'oa2sb3u', 'i1pa', 'cvwnyq', 'ouirl', 'rpouit63xyf', 'mjwpp2', 'mb3aj0ju0', '3r', '133ir1axyy', 'hpl2i9esap', 'pgckqwtsr', '54o6qjektb1', '2', 'zg3r', 'jkwns47j2j', '8', 'c', 'y', 'vjwq49yr', 'nxs6dvdxdo2v', 't1__f930ce', '7t3gvplj9f', 'vuu');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483645, '7k10', 'z2my1ogyv1r', 'ez', 'x', '1', 'l', 'upgly78oit', 'xeilpe019cy', 'od033dlhd', 283.534179, 'hed2', -1066046077, 726.542267, 'u331spxpw', '0bgwkxgi', 'nlj6idmp61', '2o3', 'k', '62ocagj', 1361395061, 1707457950, -582813835, -572986964, 387548943, -1459357985, -2051917235, 833662145, -1943810603, 1557266002, -775706063, -1417040770, 858308694, 625191846, -2065694089, 'dpu5v0', 'du', 'y9v2z12983', '5xoepacxdb2f', 'c296xiy', 'et8xjhcf46c', 'pe', 'rxa61sjv8nv', 'ddrokuez', 'ctehia3cmvb', '7vpc0xffwo', '1esks', '9q', 't1__7981cc', '2qg01huij', '7f8kqhiu5g', '8gxb', 'qjlsawsp', 'kwi3hl7j', '3y795ybv', '3kr3w4jn2', '19xgjja', 'cgmukfb5if4', '80terbf', 'kvee', 'sltut6lu2', 'cel8mhfcim', 'n5enii0fmbgz', 'oqxs27xh', '88y1k253s', '5', 'ls1ehn1md', 'aqqhyyzsnp64', 'mn', 'w4m0', 'rwbjk', 't2__13bd28', 'bph6gdw', '7');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (5, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 787.938887, 'dpos', -1576219117, 75.403642, 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 1898504886, 624571013, 1644911394, -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, -74849714, 105869088, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9', 'rljsl0b4y', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 'mfg62', '0v', 'q8qdjpe1', 'uuid_5', 'o22', '8507cvtjp');

-- Inserting into table: legalities --
INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483648, 't2__9c207b', 'Banned', 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483647, 't2__9c207b', 'Banned', 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483646, 't2__9c207b', 'Banned', 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (2, 't2__9c207b', 'Banned', 'C');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (3, 't2__9c207b', 'Banned', 'C');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483645, 't2__9c207b', 'Banned', 'C');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483642, 't2__9c207b', 'Banned', 't2__13bd28');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483641, 't2__9c207b', 'Banned', 't2__13bd28');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483640, 't2__9c207b', 'Banned', 't2__13bd28');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483639, 't2__9c207b', 'Banned', 't2__13bd28');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483638, 't2__9c207b', 'Banned', 't2__13bd28');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483637, 't2__9c207b', NULL, 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483636, 't2__9c207b', NULL, 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483635, 't2__9c207b', NULL, 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483634, 't2__9c207b', 'Banned', 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483633, 't2__9c207b', 'Banned', 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483632, 't2__9c207b', 'Banned', 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483631, 't2__9c207b', 'Banned', 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483630, 't2__9c207b', 'Banned', 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483629, 't2__9c207b', 'Banned', 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483628, NULL, 'Banned', 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483627, NULL, 'Banned', 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483626, NULL, 'Banned', 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483625, 't2__9c207b', 'Banned', 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483624, 't2__9c207b', 'Banned', 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483623, 't2__9c207b', 'Banned', 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (5, 't2__b950a3', 'Banned', 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (4, 't2__b950a3', 'Banned', 't1__f930ce');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (6, 'tg6bnou5zi', 't2__67358e', 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (7, '5k5swwqcgs', 'Banned', 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483618, 'leg_cc4c92', '9n8c4pgu7v', 'C');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (8, 'e4', 'Banned', 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483616, 'ia2yp', NULL, 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (9, 'uzhsrwbbp6lu', 'Banned', 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483614, 'dlttil', NULL, 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (10, 'n', 'Banned', 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483612, 'mdpos', NULL, 'C');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (11, 'ie5', 'Banned', 't1__73113d');

INSERT INTO "legalities" ("id", "format", "status", "uuid") VALUES (-2147483610, 'w6kl', NULL, 't1__f930ce');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.format, T1.name FROM cards AS T1 INNER JOIN legalities AS T2 ON T2.uuid = T1.uuid WHERE T2.status = 'Banned' GROUP BY T2.format ORDER BY COUNT(T2.status) DESC, T2.format NULLS LAST, T1.name NULLS LAST LIMIT 1;

/*
Gold Result:
('t2__9c207b', 't1__7981cc')
*/

-- Prediction Query
SELECT T1.format, GROUP_CONCAT(T2.name) FROM legalities AS T1 INNER JOIN cards AS T2 ON T1.uuid = T2.uuid WHERE T1.status = 'Banned' GROUP BY T1.format ORDER BY COUNT(T1.status) DESC, T1.format NULLS LAST, GROUP_CONCAT(T2.name) NULLS LAST LIMIT 1;

/*
Prediction Result:
('t2__9c207b', 't1__7981cc,t1__7981cc,t1__7981cc,t1__7981cc,t1__7981cc,t1__7981cc,t1__7981cc,t1__7981cc,t1__7981cc,t1__7981cc,t1__7981cc,t1__7981cc,t1__7981cc,t1__7981cc,t1__7981cc,t1__7981cc,t1__7981cc,t1__7981cc,t1__7981cc,t1__7981cc')
*/