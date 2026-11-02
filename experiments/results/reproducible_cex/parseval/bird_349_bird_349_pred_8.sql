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
INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483648, 't1__119c5b', '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 182.319045, 'nprmdposii', -1823627488, 327.753528, 'w6kl', 'a9', '00t5c4e', 'cigce376nium', '52zbuo4nrq', 'rofqyp5s5b', 2107872094, 882961052, 743312762, -1822992503, -868774469, -1068298341, -314162272, 2137741668, 1, -525979501, 1898504886, 624571013, 1644911394, -1666765085, 1178636309, 'ex1', 'ji7zwau2', 'dwyrq13pyu78', '9', 'rljsl0b4y', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v', 'ph2', 'nd', 't1__b62d2e', 'wnqcx', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 't1__2a6c72', 'pzo72ctdc', 'mfg62');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (3, 't1__119c5b', 'e1io', '278507cv', 'jpttg', 'bnou5zi36', '4', 'f', 'foa', 'cd07z2zezjo7', 570.824589, 'xd', 1999335832, 377.388457, 'cmr0oz', 'dgj5i', 'lq5lnpim', 'k58qs27p', 'r94gth2m', 'ajjl', -2096405521, 1803796945, 872694102, 618058035, 1553368934, -1252009958, 1908593332, 697257217, 1, -451030047, -2052653308, -489120589, -72442907, -2060082151, -1122409769, 'u', '3auvm', 'rpd', 'wzw', 'chn9mo70', 'a9n0jxfo', 'ws', 'do2zobb', 'q0k32od', 'cl5ams', 'orlwyngc1dj', '9erhizgk1yoe', 'o6l0hdt', 't1__b62d2e', 'fuqyxuzkb', '521gwnlas6e', 'lboeowii1z5', 'xih6', '2q2xlyoto', '9oaawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', '55', '3dohvu0', 'dza35rmki', '18ri', 'hy08ftp6', 'wt', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'C', 'sh5knzys7', 'y');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483647, 't1__119c5b', 'yd1jmgjach8', 'qta8y3a17v4y', 'ma', 'q3qdpua', '96rn', 'dqrhm', 'wlic7dn2', 'p490', 362.160981, 'sqtg', -1872934808, 40.211911, 'qb9i9f2ccu', 'jq1', 'uik1y', 'hb08hlst1pq', 'mizt', 'vb6m4iz78aq', -1043357093, -753065777, 190510318, -835782528, 192271618, -312228770, 1618264449, 1639204149, 1, -2063751689, 36589303, -1537647691, 364280973, 1592061050, -1451520332, '85', 'pxlvri', 'surz0kaqtncg', 'c8s3b7v88k', 'dmdbdh', '6j47n', 'ar50hs', 'han', 'xdpunmw', 'wx', 'rlawk', '14r5dqt', 'mg97a', 't1__5c4fc3', 'z2o20', 'pj6ddlysu6ip', 'dk', 'u2gir31vwq5', 'oa2sb3u', 'i1pa', 'cvwnyq', 'ouirl', 'rpouit63xyf', 'mjwpp2', 'mb3aj0ju0', '3r', '133ir1axyy', 'hpl2i9esap', 'pgckqwtsr', '54o6qjektb1', '2', 'zg3r', 'jkwns47j2j', '8', 'c', 'y', 't1__ce941f', 'vjwq49yr', 'nxs6dvdxdo2v');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483645, 't1__119c5b', 'z2my1og', 'v1rgeza', 'xc1clupgly', '8oitxeilp', 'e019cy7od0', '3dlhdsvn', 'ed', '9lqv26u3', 460.638735, 'spxpw30bgwkx', 1693638235, 900.131547, 'nlj6idmp61', '2o3', 'k', '62ocagj', 'ev', 'zxlu49', -1459357985, -2051917235, 833662145, -1943810603, 1557266002, -775706063, -1417040770, 858308694, 1, 625191846, -2065694089, 1868665501, -1896445805, 1104707112, 1551904707, 'eduy9v2', '129835x', 'epac', 'db2f0c', '96xiyet8', 'jhcf46', 'f', 'perxa61sjv', 'nv3ddroku', 'zc', 'ehia3', 'm', 'vb7vpc0xff', 't1__b62d2e', 'or1esk', 'f9q82', 'g01hu', 'j7f', '8kqhiu5gm8', 'xb', 'qjlsawsp', 'kwi3hl7j', '3y795ybv', '3kr3w4jn2', '19xgjja', 'cgmukfb5if4', '80terbf', 'kvee', 'sltut6lu2', 'cel8mhfcim', 'n5enii0fmbgz', 'oqxs27xh', '88y1k253s', '5', 'ls1ehn1md', 'aqqhyyzsnp64', 't2__d95c61', 'mn', 'w4m0');

-- Inserting into table: rulings --
INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483648, '2021-01-19', 'v5q8qdj', 't1__2a6c72');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483647, '2025-12-15', '3gvpl', 't1__2a6c72');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483646, '2021-09-05', 'fjvuun7k1', 't1__2a6c72');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (2, '2023-01-24', 'wbjk0', 't2__d95c61');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (3, '2020-03-08', 'h6gd', 't2__d95c61');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483643, '2023-12-30', '7', 't1__2a6c72');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483642, '2021-09-19', 'plw', 't1__2a6c72');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483641, '2023-06-11', 'lzh42nyj5yrj', 't1__2a6c72');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (-2147483640, '2021-05-29', 'mqkna38g', 't1__2a6c72');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (4, '2025-06-17', '5sw', 't1__2a6c72');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (5, '2024-01-05', 'cgsk9', 't1__2a6c72');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (6, '2022-04-27', '8c4pgu7vfe', 't1__2a6c72');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (7, '2025-06-04', 'hria2ypuzhs', 't1__2a6c72');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (8, '2023-01-03', 'wbbp6luhvdlt', 't1__2a6c72');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (9, '2023-05-30', 'lbn', 't1__2a6c72');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (10, '2022-09-14', 'mdpos', 't1__2a6c72');

INSERT INTO "rulings" ("id", "date", "text", "uuid") VALUES (11, '2021-06-28', 'e5u', 't1__2a6c72');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.name, T1.artist, T1.isPromo FROM cards AS T1 INNER JOIN rulings AS T2 ON T1.uuid = T2.uuid WHERE T1.isPromo = 1 GROUP BY T1.artist ORDER BY COUNT(DISTINCT T1.uuid) DESC, T1.name NULLS LAST, T1.artist NULLS LAST, T1.isPromo NULLS LAST LIMIT 1;

/*
Gold Result:
('t1__b62d2e', 't1__119c5b', 1)
*/

-- Prediction Query
SELECT "cards"."name", "cards"."artist", "cards"."ispromo" FROM "cards" INNER JOIN "rulings" ON "cards"."uuid" = "rulings"."uuid" GROUP BY "cards"."uuid" ORDER BY COUNT("rulings"."uuid") DESC, "cards"."name" NULLS LAST, "cards"."artist" NULLS LAST, "cards"."ispromo" NULLS LAST LIMIT 1;

/*
Prediction Result:
('t1__b62d2e', 't1__119c5b', 1)
*/