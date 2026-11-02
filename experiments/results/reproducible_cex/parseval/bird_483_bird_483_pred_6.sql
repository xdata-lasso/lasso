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
INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 'gu7v', 'e4', 'hria2ypuzhs', 'rwbbp6luhvd', 'tti', 'bnp', 787.938887, 'dpos', -1576219117, 75.403642, 'nw6klf', 'a9000t5c4eci', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', '2eutliqa11r', 2137741668, -525979501, 1898504886, 624571013, 1644911394, -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, -74849714, 105869088, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9', 'rljsl0b4y', 'p5qi2rkf9v', 'x58pz', 'f8jegd2', 'vy9uxj4', 'wb', 'v', 'ph2', 'nd', 'wnqcx', '5hncprjtu0d', '79fjgq8', 'n2f3dqv0gcb9', 'ozk3zbily', 'kn6vc', '6ah', 'f8jswwl', '7xb72', 'xa', '7ryfdrz16n', 'jja', '5dh', 'ogrgjd8y', 't1afgog', 'itsj3', 'y', 't1__c8884f', 'p1q430', 'jh3den8', 'c68x8vacx7', 'f', '5w1of7', 'pzo72ctdc', 'mfg62', '0v', 't2__190313', 'q8qdjpe1', 'o22');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483647, '3', 'okv8uttmu2', 'e578', 'fvy', '7zzbe8y', 'kv42q7', 'x58b4', 'pmaus3auvmkr', 'pdjwzw5chn9', 191.1711, '705a', -1245584612, 903.226183, 'fofwsz', 'o', '2zobb0q0k32o', 'w', 'l', '5amsorlwyngc', -323362455, 453340472, 211603887, -413043724, 761519897, 1504707292, 955267863, -1156828895, 1483450542, 513375398, 718167481, 1428194830, -1614619556, 1435223075, 1617348603, 'yxuzk', '5', '1gwnlas6', 'elboeowii1', '5nxih66', 'q2xlyoto', '9oaawg', '6aqb0tbin', 'z', '9tajz9td', 'n5wcgumbc', '3tdu6bd0w960', 'vzxw1rxe', '9yfk7qk162n', '55', '3dohvu0', 'dza35rmki', '18ri', 'hy08ftp6', 'wt', 'xxnja', 'bymzn2mfx7h3', 'p6sto1cj', 'sh5knzys7', 'y', 'yd1jmgjach8', 'qta8y3a17v4y', 't1__c8884f', 'ma', 'q3qdpua', '96rn', 'dqrhm', 'wlic7dn2', 'p490', 'dmsqtg', 'lc', 't2__659813', 'qb9i9f', 'ccukjq1q');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483646, '0ju0h3r133ir', 'axyyhpl', 'i9esap8p', 'gckqwtsr54', '6qje', 'ktb1d2nzg3rj', 'wns', '47j2ja8dccy3', 'vjwq49yrnx', 294.236852, '6dvdxdo2v7', 1805923837, 337.06993, 'j9f', 'vuu', '7k10', 'z2my1ogyv1r', 'ez', 'x', -316078323, -754769711, 1128553504, 1374917235, -563920971, 1484825817, 1009703228, 1163377746, 227939734, -1164657946, 693108667, -1882121644, 935816178, -1919535047, -690382359, 'ed', '9lqv26u3', '1spxpw30', 'g', 'kxginl', '6id', 'p61l', 'o3ak162o', 'cagjeevxzxlu', '49kuboe8cd', '4u', 'kh', 'llbwvdpu5v0e', 'u', 'y9v2z12983', '5xoepacxdb2f', 'c296xiy', 'et8xjhcf46c', 'pe', 'rxa61sjv8nv', 'ddrokuez', 'ctehia3cmvb', '7vpc0xffwo', '1esks', '9q', '2qg01huij', '7f8kqhiu5g', 't1__c8884f', '8gxb', 'qjlsawsp', 'kwi3hl7j', '3y795ybv', '3kr3w4jn2', '19xgjja', 'cgmukfb5if4', '80terbf', 'A', 'kvee', 'sltut6lu2');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483645, 'cel8mhfcim', 'n5enii0fmbgz', 'oqxs27xh', '88y1k253s', '5', 'ls1ehn1md', 'aqqhyyzsnp64', 'mn', 'w4m0', 273.359912, 'wbjk0bph6gd', -616998913, 524.111747, 'jjplwtlzh42n', 'j5yrji5', 'qkna', '38gfxswb2d0', 'mxwdb7o', 'p5qo1', 749598659, 902707245, -1449454815, 514764200, 1993999044, 825979697, -1565247126, -419727501, -1220824615, -888694642, 1611539964, 700001068, -2045499093, 38014553, 1144243962, '5ujp', 'yb', 'aayv', 'hvyx8scr0fs3', 'qn0b5m2rlxcr', 'fx03rz', 'z8', 'lqme2wb1', '3', 'un66e0', 'mol', '070zi', '0o50q833g', '865zm6dpewew', '092p40u2vi', 'l21xsad6q5z', 'qoa', 'uy023lwh99', 'fqc1m9gr', 'xjqbloxd4', 'j5il9', 'nd6dvy', 'gwakmwgw73f', '3dkdipt', 'fbl10q', '6j6d4f', 'c75m4s2ajdu2', '6xuj90tefx', 'u5u7709q', '9l', '8qzabi', 'uumwu7', 'l', '0jw', '6hh', 'oe79350f', 'O', 'zrv1ll930xvk', 'viql6n0rlp');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483644, '760ugk2', 'jz', 'pg1lcg', 'a4gkjog8d', 'w16f5tqhjd', 'mabmkr2t', 'dlb6i42', 'tew5c29d', 't1havc', 792.049687, '4', -429097391, 355.299179, '72fve0jf4', '5t9', '9kvnbhvi6t', '3tfn', 'dtw89qy6sru4', 'uf', -1588383617, 2062633134, 183049515, 1796323549, -1022360195, -1517836823, -2124619836, -1746125330, 765163181, 24627578, 2033421216, 794301748, 376872332, -23658516, -1799118529, 'f1ur8kz', '0g5', '0j597fznqc', 'ex41fa', 'c1je44', 'u5lvdbp3c', 'hy', '3o', 'lciif0l', '46upleo', 'h3m3q0pq97j', '534j5xbk11y', 'pzc7x', 'v4pmp', 'jve', '2', 'rn6j7', '2vkwegrf6snl', '5jw5pbgw', 'ojnhh6va3tdx', 'hn75b733', '58zb', 'yx', '0twou', '4', 'yi4h5c4f1q', '9w43ial8s8', 'sp4j9fod', 't9kcq2iae6', 'j', 'ql1676lk8', 'azkjy', 'fxsove98b8', '0235v8ik', '3qu7', 'cxswgr124', '_', 'u6v8hk', 'lzy93zu8yb');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (-2147483643, 'hqs4zc19', '282rnfvk', 'mfoqp', 'ucnn53i', '8owqwx0hv', 'v0oh59ivnipn', 'drokt16hq', '9', 'jae9ps4don', 711.431069, '0b', -1090577818, 259.530854, 'uiz', '623', '8npqdbw', 'ew42zl4ptf8u', 'l0lw90t2kl', 'apcw1gn', 2032090551, 49871159, -1903211911, 1565665313, -1945658214, 1535419305, 1856139709, 1854082190, -1673257263, -993831821, 768162102, -582426548, -1919439586, -1269214044, 999444933, '7dq70691', '7', 's1i0k8thqz3', 's94x3', 'yxg3ufg', 'efrzw0qgiqh4', 'o', 'k79v0940', '7swb3349kf', '5l6rnd3rhb', 'nmbp96v512', 'bvxjnuw8', '4jm31nfs4ni', 'om2u85br29', '1kpjnnbss', '75w5nag', 'rj6o317kajtw', 'sqiuj9f94', 'ycwnr8dq', '5gbzjmeuvjv', 'cr9l03f515y', '8am0qjut2f31', '6fr11luvk4', '7wggg', '0zchdq8o', 'xze42', 'wen', 't1__c8884f', '4ilc', 'kspw6gvo', 'c9l5zmrsv64', 'h6b1ugt', 'ygqofzr1q', '7z6ikr', '1whx1dlzbb', '27z', 't3__02e371', 'uuwyewb', 'hg8');

INSERT INTO "cards" ("id", "artist", "asciiname", "availability", "bordercolor", "cardkingdomfoilid", "cardkingdomid", "coloridentity", "colorindicator", "colors", "convertedmanacost", "dueldeck", "edhrecrank", "faceconvertedmanacost", "facename", "flavorname", "flavortext", "frameeffects", "frameversion", "hand", "hasalternativedecklimit", "hascontentwarning", "hasfoil", "hasnonfoil", "isalternative", "isfullart", "isonlineonly", "isoversized", "ispromo", "isreprint", "isreserved", "isstarter", "isstoryspotlight", "istextless", "istimeshifted", "keywords", "layout", "leadershipskills", "life", "loyalty", "manacost", "mcmid", "mcmmetaid", "mtgarenaid", "mtgjsonv4id", "mtgofoilid", "mtgoid", "multiverseid", "name", "number", "originalreleasedate", "originaltext", "originaltype", "otherfaceids", "power", "printings", "promotypes", "purchaseurls", "rarity", "scryfallid", "scryfallillustrationid", "scryfalloracleid", "setcode", "side", "subtypes", "supertypes", "tcgplayerproductid", "text", "toughness", "type", "types", "uuid", "variations", "watermark") VALUES (2, '1ev3gqe', 'nehcnt2v', 'lraxg0gt', 'ot6vp1', 'lrhqsxyube', 'yhmlrnycz8d5', 'kabtcpo', '1ke8euy0kcx', '8e4', 619.599514, 'kfphyyxnm0', -1982471697, 217.186619, 'sy4c1v', '27k', '4uv', 'f5nd', 'i8', '0zqe9rs1z82', -648886997, 611665243, -1201944605, 671921821, -1480774559, -1715369895, -1325539976, 256346440, -1095067251, -568626324, -703010907, -1520839536, 1440780484, -341340731, 1033208903, 'vh4', 'my4gp', '0kr5bk0d0gkg', 'qavutce54k', 'dvf12j4ljl', 'hxdpnhebny', 'a', 'xtpyee2zt2', 'gy7qnk', 'j2dsjla91nq', '7dxug9rta6w', 'n', 'l7a', 'q6gahjc', '84vxo5', 'ddfra', '2n0lwczduqt0', 'ig197gelrrul', 'blhtkb', 'og8ol', '9cnlvwnzp', 'cpw', '0q9z43yul6g', '5jlkkggq', 'kx1wfn', 'o', '1864', 't2__741ae4', '9', '9n', 'w16bb6teck', 'aioh8mpzf5t', 'lsok6v', 'gc', '3b0v293muo', 'o5cwanc56', 'G', 'wf', 'y2vtct');

-- Inserting into table: sets --
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483648, -1950324754, '7z2zezj', '7wgx', 't1__c8884f', -57705450, -915385605, -2005628382, 1721638020, 983324983, 'ztdg', -20116244, -176606723, '5lnpi', '5k58', 'Coldsnap', 's27p2', '2023-01-31', -95808609, -244633520, 'ajjl');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483647, -55270062, 'xlvr', 'sur', 't1__e4e718', -459075802, -1472584267, 1384307628, 1388796595, -881085433, '7', 438933248, 180947503, 'dmdbdh', '6j47n', 'Coldsnap', 'ar50hs', '2021-08-25', -1652411404, -553121210, 'punmwfwxqrl');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, 1928920679, 'ysu', 'iphdku2gi', 'G', 1113005977, -176968915, -717865822, 2061102304, -1204806277, 'sb3uoi1p', -1971610898, 2095277250, 'qrouirl', 'rpouit63xyf', 'Coldsnap', 'mjwpp2', '2025-09-01', 1913338832, -2061050846, 'j');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, 133794777, '404qpp3303a1', 'gqut', 'E', 898805626, -77974859, -619092341, -1908406235, 2142421496, 'zpd', 842122481, 1791555361, '0a0', 'q', 'Coldsnap', '1c8', '2020-06-06', -656017519, -2126129717, 'p');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, -623749300, 'hk', 'l3bjksu', 'O', 1928368836, -1205389382, -1889113209, 822981708, 798014875, 'ufc', -737687664, -1708077219, 'xbu', 'xi', 'Coldsnap', 'lq2is', '2020-08-17', 1754489362, 1344117622, 'u2fkzbwx');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483643, -1736300823, 'fjtvxt41zjf', '1qj3se4dpb4l', 't2__741ae4', 2033372614, 270795691, -264694280, 196492760, -1127007729, '6', 2144707422, -1434769338, 'j4ce2y48', 'ys1gz7p3', 'Coldsnap', 'vg', '2024-09-23', -633154726, -412910283, '2a6d');

-- Inserting into table: foreign_data --
INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483648, '8507cvtjp', 'Italian', 1582582341, 'tg6bnou5zi', 't3__10b8bd', '6c4bfkfo', 't2__190313');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (2, 'ik1yhb', 'Italian', 1862728578, 't1pqomiztvb6', 't3__10b8bd', '4iz7', 't2__190313');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (3, 'aqqlud8ft', 'Italian', 1183069552, '4qbre6b', 't3__10b8bd', 'jeuuwsj8kj', 't2__190313');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483645, 'w', 'Italian', -1439417265, '14r5dqtsmg97', 't3__10b8bd', 'aqz2o20pj6d', 't2__190313');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483644, 'saxeeinmbc', 'Italian', -1598084888, 'ojsmeqv3', 't3__10b8bd', '3uxdo', 'O');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483643, 'a0ol1z', 'Italian', 1006498753, 'rss', 't3__10b8bd', 'h', 't2__190313');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483642, '4qpog5smdhct', 'Italian', 931265534, 'y6whwhlh5', 't3__10b8bd', 'i1dtdjm8ry9l', '_');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483641, 'hw6lv7j452', 'Italian', -1421113645, 'zqt5u', 't3__10b8bd', '42p20g', 't2__190313');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483640, '3q5br37qobv', 'Italian', -2027480225, '26kpxc567p', 't3__10b8bd', 'vp0h2flntlco', 'O');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483639, 'qtl1u', 'Italian', 1573938173, 'vf3ya6l431gf', 't3__10b8bd', 'g6', 'A');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483638, '95snh', 'Italian', -1062024378, '1jc1j3dmll8k', 't3__10b8bd', '6qohr35i', 'A');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483637, 'ptxmlhv1xt', 'Italian', 403228332, '78hfcwwwkmxv', 't3__10b8bd', 'ftaq65', 'A');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483636, 'vero7', 'Italian', 1082855129, '6mok7pt50', 't3__10b8bd', 'bwhbi', 't2__190313');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483635, 'zzg8e', 't3__9d866a', 1366430999, 'd0cunhg', 't3__10b8bd', 'mgvzmqiwb', 't2__190313');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (-2147483634, 'o', 'Italian', 617425821, '5', NULL, 'nxzfoas9ez', 't2__190313');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (4, '5k5swwqcgs', NULL, 247012447, '8c4pgu7vfe', 'hria2ypu', 'hsrwbbp', 't2__659813');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (5, 'luhvdltti', 'Italian', -1364429300, 'nprmdposii', '5u', 'w6kl', 't2__659813');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (6, 'a9', 'Italian', 1620389964, '00t5c4ecigc', 'e376nium52', 'zbuo4nrqrof', 't2__659813');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (7, 'qyp5s5bbp0', 'Italian', 743312762, 'eutliqa11r', 'ytoo3o9', 'l7', 't2__659813');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (8, 'klex14ji', 'Italian', -453362185, 'au2dwyrq13', 'yu78', '9', 't2__659813');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (9, 'rljsl0b4y', 'Italian', -1116181514, 'i2rkf', 'vqx58pz0f', '8jegd21vy9ux', 't2__659813');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (10, 'j4hwbdvlph', 'Italian', -261132974, 'dqwn', 'cx5hn', 'p', 't2__659813');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (11, 'jtu0d', 'Italian', 401805964, 'gq8', 'n2f3dqv0gcb9', 'ozk3zbily', 't2__659813');

INSERT INTO "foreign_data" ("id", "flavortext", "language", "multiverseid", "name", "text", "type", "uuid") VALUES (12, 'kn6vc', 'Italian', 1784916884, 'ah0f8jsww', 'q7x', '7', 't2__659813');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.text FROM foreign_data AS T1 INNER JOIN cards AS T2 ON T2.uuid = T1.uuid INNER JOIN sets AS T3 ON T3.code = T2.setCode WHERE T3.name = 'Coldsnap' AND T1.language = 'Italian';

/*
Gold Result:
('t3__10b8bd',)
(None,)
('5u',)
('e376nium52',)
('ytoo3o9',)
('yu78',)
('vqx58pz0f',)
('cx5hn',)
('n2f3dqv0gcb9',)
('q7x',)
*/

-- Prediction Query
SELECT T3.text FROM sets AS T1 INNER JOIN cards AS T2 ON T1.code = T2.setCode INNER JOIN foreign_data AS T3 ON T2.uuid = T3.uuid WHERE T1.name = 'Coldsnap' AND T3.language = 'Italian';

/*
Prediction Result:
('t3__10b8bd',)
('t3__10b8bd',)
('t3__10b8bd',)
('t3__10b8bd',)
('t3__10b8bd',)
('t3__10b8bd',)
('t3__10b8bd',)
('t3__10b8bd',)
(None,)
('t3__10b8bd',)
('t3__10b8bd',)
('5u',)
('e376nium52',)
('ytoo3o9',)
('yu78',)
('vqx58pz0f',)
('cx5hn',)
('n2f3dqv0gcb9',)
('q7x',)
*/