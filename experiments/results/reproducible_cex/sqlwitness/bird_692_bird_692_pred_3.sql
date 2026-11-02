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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (0, NULL, NULL, 'default2', '2023-01-01 00:00:00.000000', 'default2', 'default2', 'default1', NULL, NULL, 1, NULL, NULL, '%J'), (1, 1, NULL, 'default1', '2023-01-01 01:00:00.000000', '%J', NULL, '%J', 1, 1, 1, NULL, 0, NULL), (2, 0, '2023-01-01 00:00:00.000000', '%J', NULL, 'default1', '%J', 'Zolomon', 1, 1, NULL, 1, 1, 'default1'), (3, NULL, NULL, '%J', NULL, 'default2', 'default2', 'default2', 1, 0, NULL, NULL, NULL, 'default1'), (4, NULL, NULL, '%J', '2023-01-01 01:00:00.000000', 'default2', 'Zolomon', '%J', NULL, 0, 1, NULL, 0, 'Zolomon'), (5, 1, '2023-01-01 01:00:00.000000', 'Zolomon', '2023-01-01 01:00:00.000000', 'default1', 'default1', '%J', NULL, 1, 1, 0, 1, 'default1'), (6, 1, NULL, 'default2', NULL, '%J', NULL, 'Zolomon', NULL, 0, NULL, 0, NULL, NULL);
INSERT INTO badges (id, userid, name, date) VALUES (0, 5, 'default2', '2023-01-01 00:00:00.000000'), (1, 1, NULL, '2023-01-01 01:00:00.000000'), (2, 1, NULL, '2023-01-01 00:00:00.000000'), (3, NULL, '%J', '2023-01-01 00:00:00.000000'), (4, NULL, 'default2', NULL), (5, 0, NULL, '2023-01-01 01:00:00.000000'), (6, 4, 'Zolomon', '2023-01-01 01:00:00.000000'), (7, 0, '%J', '2023-01-01 00:00:00.000000'), (8, 6, NULL, '2023-01-01 01:00:00.000000'), (9, 2, 'default2', NULL), (10, 3, '%J', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.Date - T2.CreationDate FROM badges AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE T2.DisplayName = 'Zolomon';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT STRFTIME('%J', T2.Date) - STRFTIME('%J', T1.CreationDate) AS Days FROM users AS T1 INNER JOIN badges AS T2 ON T1.Id = T2.UserId WHERE T1.DisplayName = 'Zolomon';

/*
Prediction Result:
(-0.041666666977107525,)
*/