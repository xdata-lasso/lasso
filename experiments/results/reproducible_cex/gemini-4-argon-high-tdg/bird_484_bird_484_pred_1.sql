-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO sets (id, code, name, mcmName) VALUES (10, 'CSP', 'Coldsnap', 'Coldsnap MCM');
INSERT INTO sets (id, code, name, mcmName) VALUES (20, 'Coldsnap', 'Ice Age', 'Coldsnap');
INSERT INTO set_translations (id, language, setCode, translation) VALUES (1, 'Italian', 'CSP', 'Ondata Glaciale');
INSERT INTO cards (id, uuid, name, asciiName, faceName, flavorName, setCode, convertedManaCost, faceConvertedManaCost, manaCost, edhrecRank) VALUES (1, 'uuid-low-cmc', 'Card Low CMC', 'Ascii Low', 'Face Low', 'Flavor Low', 'CSP', 2.0, 10.0, '{9}{W}', 100);
INSERT INTO cards (id, uuid, name, asciiName, faceName, flavorName, setCode, convertedManaCost, faceConvertedManaCost, manaCost, edhrecRank) VALUES (2, 'uuid-high-cmc', 'Card High CMC', 'Ascii High', 'Face High', 'Flavor High', 'CSP', 10.0, 1.0, '{1}{U}', 50);
INSERT INTO cards (id, uuid, name, asciiName, faceName, flavorName, setCode, convertedManaCost, faceConvertedManaCost, manaCost, edhrecRank) VALUES (3, 'uuid-wrong-lang', 'Card Wrong Lang', 'Ascii Wrong Lang', 'Face Wrong Lang', 'Flavor Wrong Lang', 'CSP', 15.0, 15.0, '{15}', 10);
INSERT INTO cards (id, uuid, name, asciiName, faceName, flavorName, setCode, convertedManaCost, faceConvertedManaCost, manaCost, edhrecRank) VALUES (4, 'uuid-wrong-set', 'Card Wrong Set', 'Ascii Wrong Set', 'Face Wrong Set', 'Flavor Wrong Set', 'Coldsnap', 20.0, 20.0, '{20}', 5);
INSERT INTO cards (id, uuid, name, asciiName, faceName, flavorName, setCode, convertedManaCost, faceConvertedManaCost, manaCost, edhrecRank) VALUES (10, 'uuid-id-trap', 'Card ID Trap', 'Ascii ID Trap', 'Face ID Trap', 'Flavor ID Trap', 'CSP', 25.0, 25.0, '{25}', 1);
INSERT INTO foreign_data (id, uuid, language, name, text, type) VALUES (10, 'uuid-low-cmc', 'Italian', 'Carta Bassa', 'Testo 1', 'Creatura');
INSERT INTO foreign_data (id, uuid, language, name, text, type) VALUES (20, 'uuid-high-cmc', 'Italian', 'Carta Alta', 'Testo 2', 'Stregoneria');
INSERT INTO foreign_data (id, uuid, language, name, text, type) VALUES (30, 'uuid-wrong-lang', 'French', 'Carte Francaise', 'Texte 3', 'Artefact');
INSERT INTO foreign_data (id, uuid, language, name, text, type) VALUES (40, 'uuid-wrong-set', 'Italian', 'Carta Set Sbagliato', 'Testo 4', 'Incantesimo');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.name FROM foreign_data AS T1 INNER JOIN cards AS T2 ON T2.uuid = T1.uuid INNER JOIN sets AS T3 ON T3.code = T2.setCode WHERE T3.name = 'Coldsnap' AND T1.language = 'Italian' ORDER BY T2.convertedManaCost DESC, T1.id NULLS LAST, T2.id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
('Card High CMC',)
*/

-- Prediction Query
SELECT fd.name AS italian_name FROM cards AS c INNER JOIN foreign_data AS fd ON c.uuid = fd.uuid INNER JOIN sets AS s ON c.setCode = s.code WHERE s.name = 'Coldsnap' AND fd.language = 'Italian' AND c.convertedManaCost = (SELECT MAX(convertedManaCost) FROM cards WHERE setCode = (SELECT code FROM sets WHERE name = 'Coldsnap'));

/*
Prediction Result:
*/