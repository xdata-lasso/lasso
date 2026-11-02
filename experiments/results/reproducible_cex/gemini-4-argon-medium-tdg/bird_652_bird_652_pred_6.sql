-- Schema DDL
CREATE TABLE badges (Id INTEGER NOT NULL PRIMARY KEY, UserId INTEGER NULL, Name TEXT NULL, Date DATETIME NULL, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE comments (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, Score INTEGER NULL, Text TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postHistory (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostHistoryTypeId INTEGER NULL, PostId INTEGER NULL, RevisionGUID TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, Text TEXT NULL, Comment TEXT NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postLinks (Id INTEGER NOT NULL PRIMARY KEY, CreationDate DATETIME NULL, PostId INTEGER NULL, RelatedPostId INTEGER NULL, LinkTypeId INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (RelatedPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE posts (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostTypeId INTEGER NULL, AcceptedAnswerId INTEGER NULL, CreaionDate DATETIME NULL, Score INTEGER NULL, ViewCount INTEGER NULL, Body TEXT NULL, OwnerUserId INTEGER NULL, LasActivityDate DATETIME NULL, Title TEXT NULL, Tags TEXT NULL, AnswerCount INTEGER NULL, CommentCount INTEGER NULL, FavoriteCount INTEGER NULL, LastEditorUserId INTEGER NULL, LastEditDate DATETIME NULL, CommunityOwnedDate DATETIME NULL, ParentId INTEGER NULL, ClosedDate DATETIME NULL, OwnerDisplayName TEXT NULL, LastEditorDisplayName TEXT NULL, FOREIGN KEY (LastEditorUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (OwnerUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE tags (Id INTEGER NOT NULL PRIMARY KEY, TagName TEXT NULL, Count INTEGER NULL, ExcerptPostId INTEGER NULL, WikiPostId INTEGER NULL, FOREIGN KEY (ExcerptPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE users (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, Reputation INTEGER NULL, CreationDate DATETIME NULL, DisplayName TEXT NULL, LastAccessDate DATETIME NULL, WebsiteUrl TEXT NULL, Location TEXT NULL, AboutMe TEXT NULL, Views INTEGER NULL, UpVotes INTEGER NULL, DownVotes INTEGER NULL, AccountId INTEGER NULL, Age INTEGER NULL, ProfileImageUrl TEXT NULL);

CREATE TABLE votes (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, VoteTypeId INTEGER NULL, CreationDate DATE NULL, UserId INTEGER NULL, BountyAmount INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests DISTINCT vs ALL (duplicate output rows), INNER JOIN vs LEFT/RIGHT JOIN, and NULL handling.
INSERT INTO users (Id, DisplayName) VALUES (1, 'User1');
INSERT INTO users (Id, DisplayName) VALUES (2, 'User2');
INSERT INTO users (Id, DisplayName) VALUES (3, 'User3');
INSERT INTO posts (Id, OwnerUserId) VALUES (201, 1);
-- User 1: Two postHistory entries for the same PostId (201) and two badges with the same Name ('Teacher') in 2013.
-- Should produce 2 x 2 = 4 identical rows: (201, 'Teacher'). Kills SELECT DISTINCT mutants.
INSERT INTO postHistory (Id, PostId, UserId, UserDisplayName, CreationDate) VALUES (1, 201, 1, 'Samuel', '2013-02-01 10:00:00');
INSERT INTO postHistory (Id, PostId, UserId, UserDisplayName, CreationDate) VALUES (2, 201, 1, 'Samuel', '2013-03-01 10:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (1, 1, 'Teacher', '2013-04-01 10:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (2, 1, 'Teacher', '2013-05-01 10:00:00');
-- User 2: Valid postHistory, but NO badges. Kills LEFT JOIN mutants where T2.Date filter is in ON clause or missing.
INSERT INTO postHistory (Id, PostId, UserId, UserDisplayName, CreationDate) VALUES (3, 201, 2, 'Samuel', '2013-02-01 10:00:00');
-- User 3: Valid postHistory with NULL PostId, and valid badge with NULL Name. Tests if mutant erroneously filters IS NOT NULL.
INSERT INTO postHistory (Id, PostId, UserId, UserDisplayName, CreationDate) VALUES (4, NULL, 3, 'Samuel', '2013-07-01 10:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (3, 3, NULL, '2013-07-01 10:00:00');
-- NULL UserId rows: Tests that NULL UserIds do not join together.
INSERT INTO postHistory (Id, PostId, UserId, UserDisplayName, CreationDate) VALUES (5, 201, NULL, 'Samuel', '2013-07-01 10:00:00');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (4, NULL, 'NullUserBadge', '2013-07-01 10:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.PostId, T2.Name FROM postHistory AS T1 INNER JOIN badges AS T2 ON T1.UserId = T2.UserId WHERE T1.UserDisplayName = 'Samuel' AND STRFTIME('%Y', T1.CreationDate) = '2013' AND STRFTIME('%Y', T2.Date) = '2013';

/*
Gold Result:
(201, 'Teacher')
(201, 'Teacher')
(201, 'Teacher')
(201, 'Teacher')
(None, None)
*/

-- Prediction Query
SELECT DISTINCT posthistory.postid, badges.name FROM posthistory INNER JOIN users ON posthistory.userid = users.id INNER JOIN badges ON users.id = badges.userid WHERE posthistory.userdisplayname = 'Samuel' AND STRFTIME('%Y', posthistory.creationdate) = '2013' AND STRFTIME('%Y', badges.date) = '2013';

/*
Prediction Result:
(201, 'Teacher')
(None, None)
*/