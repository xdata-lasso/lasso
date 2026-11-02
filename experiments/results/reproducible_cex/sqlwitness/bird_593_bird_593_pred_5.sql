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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (1, 1, NULL, 'Teacher', '2023-01-01 00:00:00.000000', 'Teacher', 'New York', 'Teacher', 1, NULL, 1, 1, 0, 'Teacher'), (0, 1, '2023-01-01 00:00:00.000000', 'default2', '2023-01-01 01:00:00.000000', 'Teacher', 'default2', NULL, 0, 1, NULL, 1, 1, 'Supporter'), (2, 0, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 01:00:00.000000', 'Supporter', NULL, 'New York', 0, NULL, 0, 0, 1, 'Teacher'), (3, 0, NULL, NULL, '2023-01-01 00:00:00.000000', NULL, 'default2', 'Supporter', 1, 1, 1, 1, 0, 'New York'), (4, 1, '2023-01-01 01:00:00.000000', 'Supporter', '2023-01-01 01:00:00.000000', 'default1', 'default2', NULL, NULL, 0, NULL, 0, 1, NULL), (5, 0, NULL, 'Teacher', '2023-01-01 01:00:00.000000', 'Teacher', 'Supporter', 'New York', 0, NULL, 1, NULL, 0, 'default2'), (6, 0, '2023-01-01 00:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', 'default2', 'Teacher', 'New York', 0, NULL, NULL, 1, 0, 'default1'), (7, 0, '2023-01-01 00:00:00.000000', 'default1', NULL, NULL, 'default2', 'New York', NULL, NULL, 1, NULL, 1, 'default1'), (8, 1, '2023-01-01 01:00:00.000000', 'New York', '2023-01-01 00:00:00.000000', 'New York', 'Supporter', 'New York', NULL, 1, NULL, 1, NULL, 'default2'), (9, NULL, NULL, 'default1', '2023-01-01 01:00:00.000000', 'Supporter', 'Teacher', 'default2', NULL, 0, NULL, 1, 0, 'default1'), (10, NULL, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'default1', 'Teacher', 'Teacher', 0, 1, NULL, 1, NULL, 'default1'), (11, 1, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', 'Teacher', NULL, 'Supporter', 1, NULL, NULL, 0, 0, NULL), (12, 1, NULL, 'default1', '2023-01-01 00:00:00.000000', 'default1', 'default1', 'default1', NULL, NULL, 1, 0, 1, 'default1'), (13, 1, '2023-01-01 01:00:00.000000', 'default2', NULL, 'New York', 'New York', 'New York', NULL, 0, 0, 0, 0, 'New York');
INSERT INTO badges (id, userid, name, date) VALUES (1, 13, 'Supporter', '2023-01-01 01:00:00.000000'), (0, 11, 'default1', '2023-01-01 01:00:00.000000'), (2, 7, 'default2', '2023-01-01 01:00:00.000000'), (3, 6, 'Supporter', '2023-01-01 01:00:00.000000'), (4, 0, 'New York', NULL), (5, 9, 'Teacher', NULL), (6, 11, 'New York', '2023-01-01 00:00:00.000000'), (7, 7, 'default2', NULL), (8, 12, 'Teacher', '2023-01-01 00:00:00.000000'), (9, 8, 'default2', '2023-01-01 01:00:00.000000'), (10, 8, NULL, '2023-01-01 00:00:00.000000'), (11, 13, 'default2', '2023-01-01 00:00:00.000000'), (12, 3, 'Supporter', NULL), (13, 12, 'default2', '2023-01-01 00:00:00.000000'), (14, 12, 'New York', NULL), (15, 0, 'default2', '2023-01-01 01:00:00.000000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.Id) FROM badges AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE T1.Name IN ('Supporter', 'Teacher') AND T2.Location = 'New York';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T1.UserId) FROM badges AS T1 INNER JOIN badges AS T2 ON T1.UserId = T2.UserId INNER JOIN users AS T3 ON T1.UserId = T3.Id WHERE T3.Location = 'New York' AND T1.Name = 'Teacher' AND T2.Name = 'Supporter';

/*
Prediction Result:
(0,)
*/