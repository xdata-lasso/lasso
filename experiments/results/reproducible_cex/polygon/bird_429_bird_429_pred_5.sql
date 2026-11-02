-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (66, '66', '66', '66', '66', '66', '66', '66', '66', '66', 66, '66', 66, 66, '66', '66', '66', '66', '66', '66', 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '66', '35', '66', '66');
INSERT INTO "foreign_data" ("id", "uuid", "flavortext", "language", "multiverseid", "name", "text", "type") VALUES (38, 35, '66', '66', 66, '66', '66', '66');
INSERT INTO "foreign_data" ("id", "uuid", "flavortext", "language", "multiverseid", "name", "text", "type") VALUES (37, 35, '66', '66', 66, '66', '66', '66');
INSERT INTO "legalities" ("id", "uuid", "format", "status") VALUES (66, 35, '66', '66');
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (39, 66, '66', '66', '36', 66, 66, 66, 66, 66, '66', 66, 66, '66', '66', '66', '66', '1000-03-08', 66, 66, '66');
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (206, 48, '49', '50', '66', 51, 52, 53, 54, 55, '56', 57, 58, '59', '60', '61', '62', '1000-03-05', 64, 65, '68');
INSERT INTO "set_translations" ("id", "setcode", "language", "translation") VALUES (46, 66, '69', '47');
INSERT INTO "set_translations" ("id", "setcode", "language", "translation") VALUES (206, 66, '69', '67');
INSERT INTO "rulings" ("id", "uuid", "date", "text") VALUES (41, 35, '1000-03-08', '66');
INSERT INTO "rulings" ("id", "uuid", "date", "text") VALUES (40, 35, '1000-03-08', '66');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.language, T1.type FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T2.id = 206;

/*
Gold Result:
('69', '68')
*/

-- Prediction Query
SELECT set_translations.language, sets.type FROM sets INNER JOIN set_translations ON sets.code = set_translations.setCode WHERE sets.id = 206;

/*
Prediction Result:
('69', '68')
('69', '68')
*/