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
INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (2, 'ttg6bnou5zi3', 'for_fd2a80', -68044929, 'A Pedra Fellwar', 'kf', 'oacd07z2zez', 'uuid_1');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (3, '7wgx', 'for_fd2a80', -57705450, 'A Pedra Fellwar', 'xcmr0', 'ztdg', 'uuid_1');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (4, '5lnpi', '5k58', -1125548818, 'for_a68a64', '94gth', '2mnajjla3o', 'uuid_1');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (5, '8uttmu', 'ne578lfv', -526633767, NULL, 'zzbe8yvkv', '42q7sx58b4', 'uuid_1');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (6, 'aus3', NULL, -2090240067, 'A Pedra Fellwar', 'mkrpdj', 'wzw5chn9mo70', 'uuid_1');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483643, 'a9n0jxfofws', 'C', 1719800120, 'o', '2zobb0q0k32o', 'w', 'uuid_1');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483642, '5am', 'A', -1177989415, 'wyn', 'gc1dj9erhi', 'zgk1yoeyo6l0', 'uuid_1');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483641, 't', 'Q', -795975227, 'xuzkb52', 'gwnlas6', 'elboeowii1', 'uuid_1');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483640, 'nxih662q', 'A', 287256667, 'otow9oa', 'awg96aqb0tbi', 'ndz39tajz9', 'uuid_1');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483639, '8', 'O', 748154000, 'cgumbc', '3tdu6bd0w960', 'vzxw1rxe', 'uuid_1');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483638, 'k7', 'A', -1046720861, '162nh55y3d', 'ohvu06dza3', 'rmkio18r', 'uuid_1');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483637, 'hy08ftp6', 'O', -1853955201, 'qxxnj', 'b', 'mzn2mfx', 'uuid_1');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483636, '3p6sto1c', 'A', 170892881, '5k', 'zys7', 'y', 'uuid_1');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483635, '1', 'Q', -1520090613, 'gjach8qta8y', 'a17v4ygm', 'y', 'uuid_1');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483634, 'qdpuap96', 'A', 1291298007, 'tdqr', 'm5', 'wlic7dn2np', 'uuid_1');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483633, '0xdmsqtge', 'Q', -1391541536, 'qb9i9f', 'ccukjq1q', 'ik1yhb', 'uuid_1');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483632, 'hlst1pqom', 'A', 2141720493, 'vb6m4iz78aq', 'lud8f', 'tb8r9114qbre', 'uuid_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT language FROM foreign_data WHERE name = 'A Pedra Fellwar';

/*
Gold Result:
('for_fd2a80',)
(None,)
*/

-- Prediction Query
SELECT T1.language FROM foreign_data AS T1 INNER JOIN cards AS T2 ON T1.multiverseid = T2.multiverseId WHERE T2.name = 'A Pedra Fellwar';

/*
Prediction Result:
*/