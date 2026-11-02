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
INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (2, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 787.938887, 'dpos', -1576219117, 75.403642, 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 1898504886, 624571013, 1644911394, -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, -74849714, 105869088, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9', 'rljsl0b4y', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', 't1__f07ac8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 't1__6c9fe4', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 'mfg62', 'A', '0v', 'q8qdjpe1');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (3, 'o22', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', '0', '7z2zezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i', 458.880538, '5lnpi', -1300180872, 167.377262, '8qs27p2r', '4gth2mnaj', 'la3', 'okv8uttmu2', 'e578', 'fvy', -451030047, -2052653308, -489120589, -72442907, -2060082151, -1122409769, 1849819405, -929383517, -2090240067, -699574669, 274891948, 609771851, -1934017803, 1105964624, -663234145, 'h', '9mo7', '5a9n0jx', 'of', 'szdo2z', 'obb0q0k32o', 'w', 'l', '5amsorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 'dt', 'fuqyxuzkb', 't1__f07ac8', '521gwnlas6e', 'lboeowii1z5', 'xih6', '2q2xlyoto', '9oaawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', '55', 't1__b85630', '3dohvu0', 'dza35rmki', '18ri', 'hy08ftp6', 'wt', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'C', 'sh5knzys7', 'y');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (5, 'v1rgeza', 'xc1clupgly', '8oitxeilp', 'e019cy7od0', '3dlhdsvn', 'ed', '9lqv26u3', '1spxpw30', 'g', 358.454959, 'xginlj6idm', 495658460, 186.560838, 'o3ak162o', 'cagjeevxzxlu', '49kuboe8cd', '4u', 'kh', 'llbwvdpu5v0e', -1920675616, -699425950, -432771718, 516500236, 171585273, 1870044139, -1147311649, 1599672055, 745344960, -563021857, -2062902911, -1809620481, -1963064871, 8608094, -1863057592, 'xjhcf46cf', 'perxa61sjv', 'nv3ddroku', 'zc', 'ehia3', 'm', 'vb7vpc0xff', 'or1esk', 'f9q82', 'g01hu', 'j7f', '8kqhiu5gm8', 'xb', 'qjlsawsp', 'kwi3hl7j', '3y795ybv', '3kr3w4jn2', '19xgjja', 'cgmukfb5if4', '80terbf', 'kvee', 'sltut6lu2', 'cel8mhfcim', 'n5enii0fmbgz', 'oqxs27xh', '88y1k253s', '5', 'O', 'ls1ehn1md', 'aqqhyyzsnp64', 'mn', 'w4m0', 'rwbjk', 'bph6gdw', '7', 'jjplwtlzh42n', 'uuid_3', 'j5yrji5', 'qkna');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (7, '38gfxswb2d0', 'mxwdb7o', 'p5qo1', '4c6', 'gwnkd4kc3ii', 'axz', '90nhs', '9gob', '6', 209.060742, 'n5ujp', -1621175100, 17.097147, 'a', 'vhvyx8s', 'r', 'fs3qn0b', 'm2rlxcrw', 'x0', 1950697910, -964661721, 1269188010, 1901522221, -1292966884, 1800088659, -322010175, 1154760301, -367478888, 499998313, 1915216858, 1270732094, 354693690, 399119867, 207340898, '50q8', '3g865zm6', 'p', 'ewew092p40', '2vil21', 'sad6q5', 'iqoauy0', '3lwh994f', 'qc1m9gr8xj', 'qbloxd4sj5il', 'wnd6dvygw', 'akmwgw73fy3d', 'dip', 'txfbl10qx6j', 'd4fc75m4s', 'ajdu26xu', 'j90tefx3u5u', '709qf9lx8', 'qzabivuumwu', 'alj0jwk6h', '2o', '79', '50fzrv1l', '930', 'vkviql', 'n0rlpsaxe', 'in', 'O', 'bciv', 'ojsmeqv3', '3uxdo', 'a0ol1z', 'mjrssbh72404', 'pp330', 'a1ngqut8', '184dwojdlhlz', 'uuid_4', 'dyxk', '0a0cql1c8c');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (4, 'wvadbp0760', 'gk2hjz', 'pg1lcg', 'a4gkjog8d', 'w16f5tqhjd', 'mabmkr2t', 'dlb6i42', 'tew5c29d', 't1havc', 792.049687, '4', -429097391, 355.299179, '72fve0jf4', '5t9', '9kvnbhvi6t', '3tfn', 'dtw89qy6sru4', 'uf', -1588383617, 2062633134, 183049515, 1796323549, -1022360195, -1517836823, -2124619836, -1746125330, 765163181, 24627578, 2033421216, 794301748, 376872332, -23658516, -1799118529, 'f1ur8kz', '0g5', '0j597fznqc', 'ex41fa', 'c1je44', 'u5lvdbp3c', 'hy', '3o', 'lciif0l', '46upleo', 'h3m3q0pq97j', '534j5xbk11y', 'pzc7x', 'v4pmp', 'jve', '2', 'rn6j7', '2vkwegrf6snl', '5jw5pbgw', 'ojnhh6va3tdx', 'hn75b733', '58zb', 'yx', '0twou', '4', 'yi4h5c4f1q', '9w43ial8s8', 't1__a15774', 'sp4j9fod', 't9kcq2iae6', 'j', 'ql1676lk8', 'azkjy', 'fxsove98b8', '0235v8ik', '3qu7', 'uuid_5', 'cxswgr124', 'u6v8hk');

-- Inserting into table: sets --
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, -531932574, 'jmgjach', 'qta8y3a17', 't1__6c9fe4', -735270562, 614314115, 306260487, 1168225104, -499203870, 'qdpuap96', 1291298007, 1982265552, 'dqrhm', 'wlic7dn2', 'p490', 'dmsqtg', '2020-09-18', -1391541536, -1025517017, 'i9f2ccukj');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, 1040753276, 'pqomizt', 'vb6m4iz78aq', 'O', -1043357093, -753065777, 190510318, -835782528, 192271618, '9114qbre6bj', -752650834, 2134937984, '8kj', '85', 'pxlvri', 'surz0kaqtncg', '2020-05-16', 1446366856, 438933248, '88kwdmdbdht6');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, 558684943, 'r5dqtsmg', '7aqz2o20p', 'Q', 6224071, 1928920679, 1216978423, -1087163929, -1944869637, 'u2gir31vwq5', -299585625, -2014514218, 'oi1pav', 'v', 'wnyqrouirlrp', 'ouit63xyfvmj', '2024-01-01', -1094296226, 1913338832, '3');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, -1348351819, 'y93zu8yb4q', 'og5s', 't1__a15774', -1329457837, -1661802882, 581574032, 931265534, 177710966, 'whwhlh5i1', -1931468427, 1718452961, '8ry9', 'hw6', 'v7j', '52k1qzqt', '2025-07-08', -752197316, -120730142, '20gw');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, '1quik', 't1__6c9fe4', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483647, 'yhb08hl', 't1__6c9fe4', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483646, 'j47nxar50h', 'O', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 'sjhanzxdpu', 'O', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, 'mwfw', 'O', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483643, 'qrlawk', 'O', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483642, 'j', 'Q', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483641, '0ju0h3r133ir', 'Q', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483640, 'axyyhpl', 't1__6c9fe4', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483639, 'i9esap8p', 't1__6c9fe4', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483638, 'gckqwtsr54', 't1__6c9fe4', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483637, '6qje', 't1__6c9fe4', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483636, 'ktb1d2nzg3rj', 't1__6c9fe4', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483635, 'wns', 't1__6c9fe4', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483634, '47j2ja8dccy3', 't1__6c9fe4', 't2__2452eb');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483633, 'vjwq49yrnx', 't1__6c9fe4', 't2__23686c');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483632, '6dvdx', 't1__6c9fe4', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483631, 'o', 't1__6c9fe4', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, 'v7t3gvpl', 'O', '9fj');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 'uun7k1', 'O', 'z2my1og');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 'fhk1l', 't1__a15774', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.name FROM cards AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.setCode WHERE T2.translation = 'Hauptset Zehnte Edition';

/*
Gold Result:
('t1__f07ac8',)
('qjlsawsp',)
('txfbl10qx6j',)
*/

-- Prediction Query
SELECT cards.name FROM set_translations INNER JOIN cards ON set_translations.setCode = cards.setCode WHERE set_translations.translation = 'Hauptset Zehnte Edition';

/*
Prediction Result:
('t1__f07ac8',)
('t1__f07ac8',)
('qjlsawsp',)
('txfbl10qx6j',)
('qjlsawsp',)
('txfbl10qx6j',)
('qjlsawsp',)
('txfbl10qx6j',)
('qjlsawsp',)
('txfbl10qx6j',)
('t1__f07ac8',)
('t1__f07ac8',)
('t1__f07ac8',)
('t1__f07ac8',)
('t1__f07ac8',)
('t1__f07ac8',)
('t1__f07ac8',)
('t1__f07ac8',)
*/