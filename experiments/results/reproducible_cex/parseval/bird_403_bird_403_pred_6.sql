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
INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 787.938887, 'dpos', -1576219117, 75.403642, 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 1898504886, 624571013, 1644911394, -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, -74849714, 105869088, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9', 'rljsl0b4y', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 'mfg62', '0v', 'q8qdjpe1', 'uuid_1', 'o22', '8507cvtjp');

-- Inserting into table: foreign_data --
INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483648, 'ttg6bnou5zi3', 'Spanish', -68044929, 'for_4d8f52', 'kf', 'oacd07z2zez', 'uuid_1');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (2, '7wgx', 'Spanish', -57705450, 'for_4d8f52', 'xcmr0', 'ztdg', 'uuid_1');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (3, '5i3lq5lnpim5', 'Spanish', -1125548818, 'for_4d8f52', '94gth', '2mnajjla3o', 'uuid_1');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483645, '8uttmu', 'for_bdcc94', -229022515, 'for_4d8f52', '57', 'lfvyz7zzb', 'uuid_1');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483644, 'kv42q7', 'Spanish', -2060082151, 'for_4d8f52', 'pmaus3auvmkr', 'pdjwzw5chn9', 'uuid_1');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483643, '05a9n0jxf', 'fwsz', -210159774, NULL, 'obb0q0k32o', 'w', 'uuid_1');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483642, '5am', 'sorlwyngc1', 681061317, NULL, 'iz', 'k1', 'uuid_1');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483641, 'eyo6', 'Spanish', -360096930, NULL, 't', 'fuqyxuzkb', 'uuid_1');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483640, '1gwnlas6', 'elboeowii1', -457369423, NULL, 'xih6', '2q2xlyoto', 'uuid_1');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483639, 'oaawg96aq', '0', -850941333, NULL, 'indz39tajz', 'td8n5wcgu', 'uuid_1');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (4, 'c', NULL, 1295379066, 'd0w9603vzxw1', 'xe9yf', '7qk', 'uuid_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT (SELECT CAST(SUM(CASE WHEN language = 'Spanish' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM foreign_data), name FROM foreign_data WHERE language = 'Spanish';

/*
Gold Result:
(45.45454545454545, 'for_4d8f52')
(45.45454545454545, 'for_4d8f52')
(45.45454545454545, None)
(45.45454545454545, 'for_4d8f52')
(45.45454545454545, 'for_4d8f52')
*/

-- Prediction Query
SELECT (COUNT(CASE WHEN T2.language = 'Spanish' THEN T1.uuid END) * 100.0 / COUNT(T1.uuid)) AS Percentage, T2.name FROM cards AS T1 INNER JOIN foreign_data AS T2 ON T1.uuid = T2.uuid;

/*
Prediction Result:
(45.45454545454545, 'for_4d8f52')
*/