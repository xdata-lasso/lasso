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
INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483648, 't1__449d81', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 182.319045, 'nprmdposii', -1823627488, 327.753528, 'w6kl', 'a9', '00t5c4e', 'cigce376nium', '52zbuo4nrq', 'rofqyp5s5b', 2107872094, 882961052, 743312762, -1822992503, -868774469, -1068298341, -314162272, 2137741668, -525979501, 1898504886, 624571013, 1644911394, -1666765085, 1178636309, -1390245819, 'x14ji7zwau2d', 'yrq13p', 'u78d99r', 'jsl', 'b4yp5qi', 'rkf9vqx5', 'pz0f8jegd', '1vy9uxj4', 'wb', 'v', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 'mfg62', 't1__317d40', '0v', 'q8qdjpe1');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (3, 't1__449d81', 'f', 'foa', 'cd07z2zezjo7', 'wgxd5ysxcm', '0oztd', 'j5', '3lq', '5lnpim5k58qs', 876.038555, '7p2r94gth2m', 418247369, 145.067008, 'a3o', 'v8u', 'tmu2n', '57', 'lfvyz7zzb', '8y', -705922211, 1043710187, 318331233, -233617564, 79330142, 1735561423, 756202403, 782684333, 681598285, 319284352, 1164790775, -200807520, -790819470, -1278087274, -1140595602, 'wzw', 'chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj', '9erhizgk1yoe', 'o6l0hdt', 'fuqyxuzkb', '521gwnlas6e', 'lboeowii1z5', 'xih6', '2q2xlyoto', '9oaawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', '55', '3dohvu0', 'dza35rmki', '18ri', 'hy08ftp6', 'wt', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 'y', 'yd1jmgjach8', 'qta8y3a17v4y', 'A', 'ma', 'q3qdpua');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483646, 'jq1', 'uik1y', 'hb08hlst1pq', 'mizt', 'vb6m4iz78aq', 'lud8f', 'tb8r9114qbre', '6bjeuuwsj8k', 'h85', 358.01048, 'lvrisu', 1228655416, 409.538993, 'q', 'ncgc8', '3b7v8', 'kwdmdbdht', 'j47nxar50', 'sj', -1652411404, -553121210, 1720208360, -1243923337, 1231129324, -1782325492, -544173163, -958321297, 2015039199, -641927001, 558684943, -120625031, 572453185, 1348973408, -911953404, '97', 'aqz2o20pj6d', 'dlysu6iphd', 'u2g', 'r31', 'wq51oa', 'sb3uoi1p', 'avcvwnyqroui', 'lrpou', 't63', 'xyfvmjwpp26', 'b3aj', '0ju0h3r133ir', 'axyyhpl', 'i9esap8p', 'gckqwtsr54', '6qje', 'ktb1d2nzg3rj', 'wns', '47j2ja8dccy3', 'vjwq49yrnx', '6dvdx', 'o', 'v7t3gvpl', '9fj', 'uun7k1', 'z2my1og', 'v1rgeza', 'xc1clupgly', '8oitxeilp', 'e019cy7od0', '3dlhdsvn', 'ed', '9lqv26u3', '1spxpw30', 'g', 'Q', 'kxginl', '6id');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483645, 'zxlu49', 'ubo', '8c', 'e', 'uekhllbw', 'dpu5v0', 'du', 'y9v2z12983', '5xoepacxdb2f', 419.701122, '96xiyet8', 1177967285, 141.586667, 'cf', '6cfperxa', '1sjv8nv3d', 'r', 'kuez', 'ctehia3cmvb', -1077762203, -1798310553, -1174073066, -1853296452, 2056318381, 1749319777, -213453775, -1721445347, -314024594, -786313930, 184502432, 1387373331, 1599677804, 2095228319, 1190577316, 'gm8gxb5qjl', 'awsp4', 'wi3', 'l7', 'j43y795ybv83', 'r3w', 'jn2z19xg', 'jac', 'gmukfb5if4', '80terbf', 'kvee', 'sltut6lu2', 'cel8mhfcim', 'n5enii0fmbgz', 'oqxs27xh', '88y1k253s', '5', 'ls1ehn1md', 'aqqhyyzsnp64', 'mn', 'w4m0', 'rwbjk', 'bph6gdw', '7', 'jjplwtlzh42n', 'j5yrji5', 'qkna', '38gfxswb2d0', 'mxwdb7o', 'p5qo1', '4c6', 'gwnkd4kc3ii', 'axz', '90nhs', '9gob', '6', 'O', 'rn5u', 'phy');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483644, 't1__449d81', 'un66e0', 'mol', '070zi', '0o50q833g', '865zm6dpewew', '092p40u2vi', 'l21xsad6q5z', 'qoa', 588.523703, '023lwh9', -2006209112, 193.215124, 'gr8xjqblo', 'd4sj5i', '9wn', 'd6dvygwakmwg', '73fy3d', 'dip', 1484560348, 373735911, -390424347, 2098431017, 41724575, -45970152, 438276362, -208881437, -1532823638, -755912743, 46301377, 273512703, 262910362, -812845699, -1770192505, 'u5u7709q', '9l', '8qzabi', 'uumwu7', 'l', '0jw', '6hh', 'oe79350f', 'zrv1ll930xvk', 'viql6n0rlp', 'saxeeinmbc', 'v5o', 'sme', 'v3r3u', 'doxa0o', 'l1zmjrssbh', '2404qpp33', '3a1ngqu', '8184d', 'ojdlhl', 'pdyxk0a', 'cql1c8c', 'wvadbp0760', 'gk2hjz', 'pg1lcg', 'a4gkjog8d', 'w16f5tqhjd', 'mabmkr2t', 'dlb6i42', 'tew5c29d', 't1havc', 'c4zpw867', 'fve0jf4i', 't99kvnbh', 'i6tp3t', 'nd', 't2__cf0991', 'w89qy', 'sru4eufio');

-- Inserting into table: foreign_data --
INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483648, 'o22', 'Phyrexian', 2004147439, 'tjpttg', 'bnou5zi36', '4', 't1__317d40');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483647, '96rn', 'Phyrexian', 2013152515, 'q', 'hm5wl', 'c7d', 't1__317d40');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483646, 'n2np490xdms', 'Phyrexian', -1027584872, 'el', 'u', 'qb9i9f2ccu', 't1__317d40');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483645, 'p61l', 'Phyrexian', -177551902, '162', 'cagj', 'ev', 'Q');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483644, 'n', 'Phyrexian', 1487440939, 'y', 'hvyx8s', 'r', 'O');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483643, 'fs3qn0b', 'Phyrexian', -1500616, 'rlxcrwfx', '3rzgz84', 'lqme2wb1b3', 'O');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (2, '8o', 'Phyrexian', 1796323549, 'qgjradfhj', '8zr6k53p8e5o', 'f0y', 't2__cf0991');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (3, '1u', 'Phyrexian', -1457401052, '0g5', '0j597fznqc', 'ex41fa', 't2__cf0991');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483640, 'c1je44', 't2__4d8236', 774567335, 'lvdbp3ce', 'hye3oylciif', 'ly46upl', 't1__317d40');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483639, 'eoh3m3q0pq97', 'Phyrexian', -30073701, '4j5xbk11ys', 'zc7x', 'v4pmp', 't1__317d40');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (4, '5k5swwqcgs', NULL, 247012447, '8c4pgu7vfe', 'hria2ypu', 'hsrwbbp', 't1__317d40');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (5, '5k5swwqcgs', 'Phyrexian', 247012447, '8c4pgu7vfe', 'hria2ypu', 'hsrwbbp', 't1__317d40');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (6, 'luhvdltti', 'Phyrexian', -1364429300, 'nprmdposii', '5u', 'w6kl', 't1__317d40');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (7, 'a9', 'Phyrexian', 1620389964, '00t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', 't1__317d40');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (8, 'qyp5s5bbp0', 'Phyrexian', 743312762, 'eutliqa11r', 'ytoo3o9', 'l7', 't1__317d40');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (9, 'klex14ji', 'Phyrexian', -453362185, 'au2dwyrq13', 'yu78', '9', 't1__317d40');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (10, 'rljsl0b4y', 'Phyrexian', -1116181514, 'i2rkf', 'vqx58pz0f', '8jegd21vy9ux', 't1__317d40');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.artist FROM cards AS T1 INNER JOIN foreign_data AS T2 ON T1.uuid = T2.uuid WHERE T2.language = 'Phyrexian';

/*
Gold Result:
('t1__449d81',)
('t1__449d81',)
('t1__449d81',)
('jq1',)
('zxlu49',)
('zxlu49',)
('t1__449d81',)
('t1__449d81',)
('t1__449d81',)
('t1__449d81',)
('t1__449d81',)
('t1__449d81',)
('t1__449d81',)
('t1__449d81',)
('t1__449d81',)
*/

-- Prediction Query
SELECT DISTINCT cards.artist FROM cards INNER JOIN foreign_data ON cards.uuid = foreign_data.uuid WHERE foreign_data.language = 'Phyrexian';

/*
Prediction Result:
('t1__449d81',)
('jq1',)
('zxlu49',)
*/