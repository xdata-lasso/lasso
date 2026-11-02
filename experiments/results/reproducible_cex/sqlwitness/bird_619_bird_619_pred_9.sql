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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (18, 0, NULL, NULL, '2023-01-01 01:00:00.000000', 'default2', 'default2', 'Supporter', 0, 1, 20, 19, 64, 'default2'), (20, 0, NULL, NULL, NULL, 'Supporter', NULL, 'Supporter', 65, 1, 65, NULL, 65, 'default1'), (1, NULL, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 00:00:00.000000', 'default1', 'Supporter', 'Supporter', 0, 20, NULL, 66, 18, NULL), (65, 1, NULL, 'default2', '2023-01-01 00:00:00.000000', 'Supporter', 'Supporter', 'Supporter', 19, 19, 0, 0, 20, NULL), (64, 66, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', 'default2', 'Supporter', 'default1', 1, 1, 65, 0, 65, 'Supporter'), (0, 65, NULL, 'default2', '2023-01-01 01:00:00.000000', 'default2', 'Supporter', 'default2', 65, 64, 19, 1, 66, 'Supporter'), (19, 20, '2023-01-01 01:00:00.000000', NULL, NULL, 'default1', NULL, NULL, 1, 1, 66, 18, NULL, 'Supporter'), (66, NULL, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', 'Supporter', 'default2', 'default1', 19, 0, 1, 1, 18, 'default1'), (2, 19, '2023-01-01 00:00:00.000000', 'Supporter', NULL, NULL, 'Supporter', 'default1', 65, NULL, NULL, 20, 1, 'default2'), (3, 0, '2023-01-01 01:00:00.000000', NULL, '2023-01-01 00:00:00.000000', 'Supporter', 'default1', NULL, 18, 65, 20, 64, 64, 'Supporter'), (4, 20, '2023-01-01 00:00:00.000000', 'Supporter', NULL, 'default1', NULL, 'default1', 20, 65, 64, 66, 64, 'default2'), (5, 65, NULL, NULL, '2023-01-01 00:00:00.000000', NULL, 'default2', 'Supporter', 18, 66, 0, 19, 65, 'default1'), (6, 1, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default1', 'default2', 'default1', 65, 20, 0, 0, NULL, 'default1'), (7, 65, NULL, 'default1', '2023-01-01 00:00:00.000000', 'Supporter', NULL, 'default1', 20, 18, NULL, 66, 0, 'default2'), (8, 66, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 00:00:00.000000', 'default2', 'default1', 'default1', 66, 20, NULL, NULL, 20, 'default1'), (9, 64, '2023-01-01 01:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', 'default2', NULL, 'Supporter', 19, 0, 1, 18, 1, 'Supporter');
INSERT INTO badges (id, userid, name, date) VALUES (66, 8, NULL, NULL), (1, 2, 'default1', '2023-01-01 00:00:00.000000'), (0, 18, 'default2', '2023-01-01 00:00:00.000000'), (19, 5, NULL, NULL), (20, 18, 'Supporter', NULL), (64, 18, 'default2', '2023-01-01 00:00:00.000000'), (65, 3, 'Supporter', NULL), (18, 8, 'Supporter', NULL), (2, 2, 'Supporter', '2023-01-01 00:00:00.000000'), (3, 3, 'Supporter', NULL), (4, 3, 'default2', NULL), (5, 6, NULL, '2023-01-01 01:00:00.000000'), (6, 6, 'default2', '2023-01-01 00:00:00.000000'), (7, 3, 'default2', '2023-01-01 00:00:00.000000'), (8, 20, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.Id) FROM users AS T1 INNER JOIN badges AS T2 ON T1.Id = T2.UserId WHERE T2.Name = 'Supporter' AND T1.Age BETWEEN 19 AND 65;

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT u.Id) FROM badges AS b JOIN users AS u ON b.UserId = u.Id WHERE b.Name = 'Supporter' AND u.Age BETWEEN 19 AND 65;

/*
Prediction Result:
(3,)
*/