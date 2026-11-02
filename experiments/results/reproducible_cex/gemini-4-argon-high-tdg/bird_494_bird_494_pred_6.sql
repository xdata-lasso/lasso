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
INSERT INTO cards (id, uuid, artist, name, text, hasContentWarning, hasAlternativeDeckLimit, hasFoil, hasNonFoil, isAlternative, isFullArt, isOnlineOnly, isOversized, isPromo, isReprint, isReserved, isStarter, isStorySpotlight, isTextless, isTimeshifted) VALUES (1, 'uuid-jp-1', 'Jim Pavelec', 'Card One', 'Card body text 1', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO cards (id, uuid, artist, name, text, hasContentWarning, hasAlternativeDeckLimit, hasFoil, hasNonFoil, isAlternative, isFullArt, isOnlineOnly, isOversized, isPromo, isReprint, isReserved, isStarter, isStorySpotlight, isTextless, isTimeshifted) VALUES (2, 'uuid-jp-2', 'Jim Pavelec', 'Card Two', 'Card body text 2', 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
INSERT INTO cards (id, uuid, artist, name, text, hasContentWarning) VALUES (3, 'uuid-jp-no-ruling', 'Jim Pavelec', 'Card Three', 'Card body text 3', 1);
INSERT INTO cards (id, uuid, artist, name, text, hasContentWarning) VALUES (10, 'uuid-other-1', 'Rebecca Guay', 'Card Four', 'Card body text 4', 1);
INSERT INTO rulings (id, date, text, uuid) VALUES (10, '2020-01-01', 'Ruling 1A for Jim Pavelec warning card', 'uuid-jp-1');
INSERT INTO rulings (id, date, text, uuid) VALUES (11, '2020-01-02', 'Ruling 1B for Jim Pavelec warning card', 'uuid-jp-1');
INSERT INTO rulings (id, date, text, uuid) VALUES (20, '2020-02-01', 'Ruling 2A for Jim Pavelec normal card', 'uuid-jp-2');
INSERT INTO rulings (id, date, text, uuid) VALUES (1, '2020-03-01', 'Ruling for other artist card', 'uuid-other-1');
INSERT INTO foreign_data (id, language, name, text, uuid) VALUES (1, 'German', 'Karte Eins', 'Foreign text 1', 'uuid-jp-1');
INSERT INTO foreign_data (id, language, name, text, uuid) VALUES (2, 'German', 'Karte Zwei', 'Foreign text 2', 'uuid-jp-2');
INSERT INTO foreign_data (id, language, name, text, uuid) VALUES (3, 'German', 'Karte Drei', 'Foreign text 3', 'uuid-jp-no-ruling');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.text, CASE WHEN T1.hasContentWarning = 1 THEN 'YES' ELSE 'NO' END FROM cards AS T1 INNER JOIN rulings AS T2 ON T2.uuid = T1.uuid WHERE T1.artist = 'Jim Pavelec';

/*
Gold Result:
('Ruling 1A for Jim Pavelec warning card', 'YES')
('Ruling 1B for Jim Pavelec warning card', 'YES')
('Ruling 2A for Jim Pavelec normal card', 'NO')
*/

-- Prediction Query
SELECT rulings.text, cards.hasContentWarning FROM cards INNER JOIN rulings ON cards.uuid = rulings.uuid WHERE cards.artist = 'Jim Pavelec';

/*
Prediction Result:
('Ruling 1A for Jim Pavelec warning card', 1)
('Ruling 1B for Jim Pavelec warning card', 1)
('Ruling 2A for Jim Pavelec normal card', 0)
*/