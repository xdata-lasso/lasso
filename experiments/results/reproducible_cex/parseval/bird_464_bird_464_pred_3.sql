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
INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (2, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 787.938887, 'dpos', -1576219117, 75.403642, 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 1898504886, 624571013, 1644911394, -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, -74849714, 105869088, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9', 'rljsl0b4y', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', 't1__4fd03f', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 't1__c7a9ec', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 'mfg62', 'A', '0v', 'q8qdjpe1');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (3, 'o22', '8507cvtjp', 'ttg6bnou5zi3', 'c4bfkfoac', '0', '7z2zezjo7wg', 'd5ysxc', 'r0oz', 'dgj5i', 458.880538, '5lnpi', -1300180872, 167.377262, '8qs27p2r', '4gth2mnaj', 'la3', 'okv8uttmu2', 'e578', 'fvy', -451030047, -2052653308, -489120589, -72442907, -2060082151, -1122409769, 1849819405, -929383517, -2090240067, -699574669, 274891948, 609771851, -1934017803, 1105964624, -663234145, 'h', '9mo7', '5a9n0jx', 'of', 'szdo2z', 'obb0q0k32o', 'w', 'l', '5amsorlwyngc', 'dj9erhi', 'zgk1yoeyo6l0', 'dt', 'fuqyxuzkb', 't1__4fd03f', '521gwnlas6e', 'lboeowii1z5', 'xih6', '2q2xlyoto', '9oaawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', '55', 't1__3442fb', '3dohvu0', 'dza35rmki', '18ri', 'hy08ftp6', 'wt', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'C', 'sh5knzys7', 'y');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (5, 'c', '3vjwq49', 'yrnxs6dvdx', 'o', 'v7t3gvpl', '9fj', 'uun7k1', 'z2my1og', 'v1rgeza', 598.494048, '1', -1970162044, 575.65588, 'gly7', '8oitxeilpe0', '19cy7od033d', 'hds', 'nhed29', 'qv2', 1032462616, 980224846, -169055351, -894726713, -1089715864, -165171643, -2051120765, -607931326, 1659285381, 1693638235, 1718551923, 404445908, -1919229426, 495658460, 1530380378, 'o3ak162ocagj', 'ev', 'zxlu49', 'ubo', '8c', 'e', 'uekhllbw', 'dpu5v0', 'du', 'y9v2z12983', '5xoepacxdb2f', 'c296xiy', 'et8xjhcf46c', 'pe', 'rxa61sjv8nv', 'ddrokuez', 'ctehia3cmvb', '7vpc0xffwo', '1esks', '9q', '2qg01huij', '7f8kqhiu5g', '8gxb', 'qjlsawsp', 'kwi3hl7j', '3y795ybv', '3kr3w4jn2', 'E', '19xgjja', 'cgmukfb5if4', '80terbf', 'kvee', 'sltut6lu2', 'cel8mhfcim', 'n5enii0fmbgz', 'oqxs27xh', 'uuid_3', '88y1k253s', '5');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (7, 'ls1ehn1md', 'aqqhyyzsnp64', 'mn', 'w4m0', 'rwbjk', 'bph6gdw', '7', 'jjplwtlzh42n', 'j5yrji5', 974.878268, 'kna38', -1725694639, 701.559148, 'swb2d0', 'mxwdb7o', 'p5qo1', '4c6', 'gwnkd4kc3ii', 'axz', 1008864713, 1709290125, -1660176735, -1205570400, -976193147, -15423424, 1774110337, -1099209475, -478462425, -2125510968, 2017526622, -693920036, 195093192, -1957842577, -366834342, '3qn0b', 'm2rlxcrw', 'x0', '3rzgz84lqm', '2w', 'b1b3vun66e0i', 'olt0', '0zi90o50q', '33g865zm6', 'p', 'ewew092p40', '2vil21', 'sad6q5', 'iqoauy0', '3lwh994f', 'qc1m9gr8xj', 'qbloxd4sj5il', 'wnd6dvygw', 'akmwgw73fy3d', 'dip', 'txfbl10qx6j', 'd4fc75m4s', 'ajdu26xu', 'j90tefx3u5u', '709qf9lx8', 'qzabivuumwu', 'alj0jwk6h', 'E', '2o', '79', '50fzrv1l', '930', 'vkviql', 'n0rlpsaxe', 'in', 'bciv', 'uuid_4', 'ojsmeqv3', '3uxdo');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (4, '184dwojdlhlz', 'dyxk', '0a0cql1c8c', 'wvadbp0760', 'gk2hjz', 'pg1lcg', 'a4gkjog8d', 'w16f5tqhjd', 'mabmkr2t', 400.246693, 'l', -1578115092, 740.511922, '22tew5c29dw', '1havc', 'c4zpw867', 'fve0jf4i', 't99kvnbh', 'i6tp3t', -1767328130, 990436826, 2071439307, 2077933154, 232457376, 782631880, -131110552, -746840413, -1588383617, 2062633134, 183049515, 1796323549, -1022360195, -1517836823, -2124619836, 'fhj8zr6k53', '8e5o', 'f0y', '1u', 'r8kzi0g50j5', '7fznqcuex', '1faxc1je', '48u5lvdb', '3ceh', 'e3oylci', 'if0ly46upl', 'eoh3m3q0pq97', '534', '5xb', '11y', 'pzc7x', 'v4pmp', 'jve', '2', 'rn6j7', '2vkwegrf6snl', '5jw5pbgw', 'ojnhh6va3tdx', 'hn75b733', '58zb', 'yx', '0twou', 't1__ad649e', '4', 'yi4h5c4f1q', '9w43ial8s8', 'sp4j9fod', 't9kcq2iae6', 'j', 'ql1676lk8', 'azkjy', 'uuid_5', 'fxsove98b8', '0235v8ik');

-- Inserting into table: sets --
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, -531932574, 'jmgjach', 'qta8y3a17', 't1__c7a9ec', -735270562, 614314115, 306260487, 1168225104, -499203870, 'qdpuap96', 1291298007, 1982265552, 'dqrhm', 'wlic7dn2', 'p490', 'dmsqtg', '2020-09-18', -1391541536, -1025517017, 'i9f2ccukj');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, 1040753276, 'pqomizt', 'vb6m4iz78aq', 'E', -1043357093, -753065777, 190510318, -835782528, 192271618, '9114qbre6bj', -752650834, 2134937984, '8kj', '85', 'pxlvri', 'surz0kaqtncg', '2020-05-16', 1446366856, 438933248, '88kwdmdbdht6');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, 2014610660, 'wfwx', 'rlawk', 'O', 558684943, -120625031, 572453185, 1348973408, -911953404, '97', -2098439423, -459764012, '20pj', 'ddlysu6ip', 'dk', 'u2gir31vwq5', '2024-10-28', -1204806277, 1813968674, 'sb3uoi1pavcv');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, -192454950, '77cxsw', 'r1', 't1__ad649e', -263728848, 1905992027, 1646694792, 1349767879, 1277665386, 'u8yb4qp', -1154116262, -55064672, 'dhct', 'nj8y6whwhl', '5i', 'dtdjm8r', '2024-03-19', -1633323209, 15319141, 'v7j452k1qz');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, '1quik', 't1__c7a9ec', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483647, 'yhb08hl', 't1__c7a9ec', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483646, 'j47nxar50h', 'E', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 'sjhanzxdpu', 'E', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, 'wnyqrouirlrp', 'O', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483643, 'ouit63xyfvmj', 'O', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483642, 'wpp26mb3aj0j', 'O', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483641, '0h3r13', 'O', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483640, 'ir1axyyh', 't1__c7a9ec', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483639, 'l2i9', 't1__c7a9ec', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483638, 'sa', 't1__c7a9ec', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483637, '8pgc', 't1__c7a9ec', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483636, 'qwt', 't1__c7a9ec', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483635, 'r54o6', 't1__c7a9ec', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483634, 'jektb', 't1__c7a9ec', 't2__ba9f87');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483633, '1d2nzg3rjk', 't1__c7a9ec', 't2__56a4b5');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483632, 'ns47j2', 't1__c7a9ec', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483631, 'a8d', 't1__c7a9ec', 'Hauptset Zehnte Edition');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, 'a0ol1z', 'E', 'mjrssbh72404');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 'pp330', 'E', 'a1ngqut8');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 'qt5uw42p20', 't1__ad649e', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.name FROM cards AS T1 INNER JOIN set_translations AS T2 ON T2.setCode = T1.setCode WHERE T2.translation = 'Hauptset Zehnte Edition';

/*
Gold Result:
('t1__4fd03f',)
('iqoauy0',)
('pe',)
*/

-- Prediction Query
SELECT cards.name FROM set_translations INNER JOIN sets ON set_translations.setCode = sets.code INNER JOIN cards ON sets.code = cards.setCode WHERE set_translations.translation = 'Hauptset Zehnte Edition';

/*
Prediction Result:
('t1__4fd03f',)
('t1__4fd03f',)
('iqoauy0',)
('pe',)
('iqoauy0',)
('pe',)
('t1__4fd03f',)
('t1__4fd03f',)
('t1__4fd03f',)
('t1__4fd03f',)
('t1__4fd03f',)
('t1__4fd03f',)
('t1__4fd03f',)
('t1__4fd03f',)
*/