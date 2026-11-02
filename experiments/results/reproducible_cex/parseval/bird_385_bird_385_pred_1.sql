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
INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 787.938887, 'dpos', -1576219117, 75.403642, 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 1898504886, 624571013, 1644911394, -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, -74849714, 105869088, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9', 'rljsl0b4y', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', 'Beacon of Immortality', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 'mfg62', '0v', 't1__ee58e2', 'q8qdjpe1', 'o22');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483647, '507cvtjpt', 'tg6bnou5zi', '6c4bfkfo', 'c', '0', '7z2zezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i', 458.880538, '5lnpi', -1300180872, 167.377262, '8qs27p2r', '4gth2mnaj', 'la3', 'okv8uttmu2', 'e578', 'fvy', -451030047, -2052653308, -489120589, -72442907, -2060082151, -1122409769, 1849819405, -929383517, -2090240067, -699574669, 274891948, 609771851, -1934017803, 1105964624, -663234145, 'h', '9mo7', '5a9n0jx', 'of', 'szdo2z', 'obb0q0k32o', 'w', 'l', '5amsorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 'dt', 'fuqyxuzkb', 'Beacon of Immortality', '521gwnlas6e', 'lboeowii1z5', 'xih6', '2q2xlyoto', '9oaawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', '55', '3dohvu0', 'dza35rmki', '18ri', 'hy08ftp6', 'wt', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 't1__7dd2f4', 'y', 'yd1jmgjach8');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483646, 'a8y3a17v4yg', 'mayq3qdpua', '96rn', 'dqrhm', 'wlic7dn2', 'p490', 'dmsqtg', 'lc', 'qb9i9f', 446.993541, 'c', 1149620614, 170.693019, '1quik', 'yhb08hl', 't1pqo', 'iztv', '6', '4iz7', 195316816, 1728201214, -1370566258, 948460309, 1183069552, -1057355067, -1004098188, 316163741, -752650834, 2134937984, 1379644459, 136003842, -1486030107, 1138926079, -609840352, 'lvrisu', 'z0kaq', 'ncgc8', '3b7v8', 'kwdmdbdht', 'j47nxar50', 'sj', 'an', 'xdpunmw', 'wx', 'rlawk', '14r5dqt', 'mg97a', 'Beacon of Immortality', 'z2o20', 'pj6ddlysu6ip', 'dk', 'u2gir31vwq5', 'oa2sb3u', 'i1pa', 'cvwnyq', 'ouirl', 'rpouit63xyf', 'mjwpp2', 'mb3aj0ju0', '3r', '133ir1axyy', 'hpl2i9esap', 'pgckqwtsr', '54o6qjektb1', '2', 'zg3r', 'jkwns47j2j', '8', 'c', 'y', 'C', 'vjwq49yr', 'nxs6dvdxdo2v');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483645, '7t3gvplj9f', 'vuu', '7k10', 'z2my1ogyv1r', 'ez', 'x', '1', 'l', 'upgly78oit', 657.064265, 'xeilpe019c', -1164657946, 661.376934, '3dlhdsvn', 'ed', '9lqv26u3', '1spxpw30', 'g', 'kxginl', 1595944351, 1673977398, 1004962990, -1318740197, -306339789, -177551902, 1128058273, 1562909425, 950497469, -1722214030, 1361395061, 1707457950, -582813835, -572986964, 387548943, 'kuboe8cde', 'uekhllbw', 'dpu5v0', 'du', 'y9v2z12983', '5xoepacxdb2f', 'c296xiy', 'et8xjhcf46c', 'pe', 'rxa61sjv8nv', 'ddrokuez', 'ctehia3cmvb', '7vpc0xffwo', '1esks', '9q', '2qg01huij', '7f8kqhiu5g', '8gxb', 'qjlsawsp', 'kwi3hl7j', '3y795ybv', '3kr3w4jn2', '19xgjja', 'cgmukfb5if4', '80terbf', 'kvee', 'sltut6lu2', 'cel8mhfcim', 'n5enii0fmbgz', 'oqxs27xh', '88y1k253s', '5', 'ls1ehn1md', 'aqqhyyzsnp64', 'mn', 'w4m0', 'A', 'rwbjk', 'bph6gdw');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483644, 'jjplwtlzh', '42nyj5yrji5m', 'kna38', 'fx', 'wb2d0', 'mxwdb7o', 'p5qo1', '4c6', 'gwnkd4kc3ii', 163.356861, 'x', 1736390601, 271.658038, '0nhsp9gob', '6', 'rn5u', 'phy', 'n', 'a', -534612951, 754506713, -500097534, -895541641, -972469277, -1763520124, -1023831089, 1287135899, -1334768184, 364506391, -1406926883, 1741116512, -964988623, 1839708185, -563209298, '3rzgz84lqm', '2w', 'b1b3vun66e0i', 'olt0', '0zi90o50q', '33g865zm6', 'p', 'ewew092p40', '2vil21', 'sad6q5', 'iqoauy0', '3lwh994f', 'qc1m9gr8xj', 'Beacon of Immortality', 'qbloxd4sj5il', 'wnd6dvygw', 'akmwgw73fy3d', 'dip', 'txfbl10qx6j', 'd4fc75m4s', 'ajdu26xu', 'j90tefx3u5u', '709qf9lx8', 'qzabivuumwu', 'alj0jwk6h', '2o', '79', '50fzrv1l', '930', 'vkviql', 'n0rlpsaxe', 'in', 'bciv', 'ojsmeqv3', '3uxdo', 'a0ol1z', '_', 'mjrssbh72404', 'pp330');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483643, '1', 'gqut', '184dwojdl', 'lz', 'dyxk', '0a0cql1c8c', 'wvadbp0760', 'gk2hjz', 'pg1lcg', 551.204026, 'gkjog8dw', 1314064183, 312.38077, 'jd', 'mabmkr2t', 'dlb6i42', 'tew5c29d', 't1havc', 'c4zpw867', 1821429906, 1770083132, -390816038, -1748913439, -1608712068, 1336897658, -735384165, 1211169035, -681931530, 13488751, -1082755849, -842223788, -1017434885, 34052637, 2034629747, 'u4eufiof8o', '6b', 'p9qgjradfhj', '8zr6k53p8e5o', 'f0y', '1u', 'r8kzi0g50j5', '7fznqcuex', '1faxc1je', '48u5lvdb', '3ceh', 'e3oylci', 'if0ly46upl', 'Beacon of Immortality', 'eoh3m3q0pq97', '534', '5xb', '11y', 'pzc7x', 'v4pmp', 'jve', '2', 'rn6j7', '2vkwegrf6snl', '5jw5pbgw', 'ojnhh6va3tdx', 'hn75b733', '58zb', 'yx', '0twou', '4', 'yi4h5c4f1q', '9w43ial8s8', 'sp4j9fod', 't9kcq2iae6', 'j', 'O', 'ql1676lk8', 'azkjy');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483642, 'xsove98b85', '0235v8ikp3qu', '77cxswgr12', 'vu6v8hkl', 'y93zu8y', 'b4qpog5smdhc', 'tnj8y6whwhl', '5i', 'dtdjm8r', 702.90865, '9lhw6lv', -1524863063, 635.065694, '52k1qzqt5u', '42p20g', 'tfhk1l', 'bjksuye6', 'hvzboodlz60', 'sijufc2vfgh', 1608670538, 2113178098, -2074048065, -1744541202, -1548627424, -1057155638, -1590734269, -69826970, 663227128, -1775767623, 1809278717, -2015974250, 1422871709, -1023537273, -2051635326, '7qobvbj2', 'kpxc567pv', '0h2f', 'lntlcorqtl1u', 'dbvf', 'ya6l431g', 'feg6q6gifj', 'vxt41', 'jf1qj3s', '4d', 'pb4l6rurl72q', 'ippxb659q', 'tkf5j4ce', 'Beacon of Immortality', 'y485ys1g', '7p3hvg0', 'ytzip2', 'a6d2hqs4zc1', '2282rnfvk', 'mfoqp', 'ucnn53i', '8owqwx0hv', 'v0oh59ivnipn', 'drokt16hq', '9', 'jae9ps4don', 'e0b6piqkuizi', '2308npqdb', 'wew42zl4ptf8', 'l0lw90', '2klya', 'cw1g', 'o6r9', '3', 'dayv5uh', 'rvcc', 't2__0ca44f', 'wraqxeddnko4', 'dq70691b7');

-- Inserting into table: rulings --
INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483648, '2025-10-23', 't2__8ebe17', 't1__ee58e2');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (2, '2022-11-06', 't2__8ebe17', 't1__ee58e2');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (3, '2023-06-07', 't2__8ebe17', 't1__ee58e2');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483645, '2020-05-03', 't2__8ebe17', 'A');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483644, '2025-03-09', 't2__8ebe17', 'A');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483643, '2020-12-11', 't2__8ebe17', 'A');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483642, '2023-04-16', 't2__8ebe17', 't1__ee58e2');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483641, '2024-10-05', NULL, 't1__ee58e2');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (4, '2025-06-17', '5sw', 't1__ee58e2');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (5, '2024-01-05', 'cgsk9', 't1__ee58e2');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (6, '2022-04-27', '8c4pgu7vfe', 't1__ee58e2');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (7, '2025-06-04', 'hria2ypuzhs', 't1__ee58e2');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (8, '2023-01-03', 'wbbp6luhvdlt', 't1__ee58e2');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (9, '2023-05-30', 'lbn', 't1__ee58e2');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (10, '2022-09-14', 'mdpos', 't1__ee58e2');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (11, '2021-06-28', 'e5u', 't1__ee58e2');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (12, '2022-06-13', '6klfa9', 't1__ee58e2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.text FROM cards AS T1 INNER JOIN rulings AS T2 ON T1.uuid = T2.uuid WHERE T1.name = 'Beacon of Immortality';

/*
Gold Result:
('t2__8ebe17',)
('t2__8ebe17',)
(None,)
('t2__8ebe17',)
('t2__8ebe17',)
('5sw',)
('cgsk9',)
('8c4pgu7vfe',)
('hria2ypuzhs',)
('wbbp6luhvdlt',)
('lbn',)
('mdpos',)
('e5u',)
('6klfa9',)
*/

-- Prediction Query
SELECT DISTINCT T2.text FROM cards AS T1 INNER JOIN rulings AS T2 ON T1.uuid = T2.uuid WHERE T1.name = 'Beacon of Immortality';

/*
Prediction Result:
('t2__8ebe17',)
(None,)
('5sw',)
('cgsk9',)
('8c4pgu7vfe',)
('hria2ypuzhs',)
('wbbp6luhvdlt',)
('lbn',)
('mdpos',)
('e5u',)
('6klfa9',)
*/