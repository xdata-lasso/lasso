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
INSERT INTO users (id, reputation, creationdate, displayname, lastaccessdate, websiteurl, location, aboutme, views, upvotes, downvotes, accountid, age, profileimageurl) VALUES (0, 0, '2023-01-01 01:00:00.000000', 'default2', NULL, 'Supporter', 'Supporter', NULL, 1, 65, NULL, 1, 1, 'default2'), (65, 1, '2023-01-01 01:00:00.000000', 'default1', '2023-01-01 00:00:00.000000', 'default1', NULL, 'default1', 64, 1, 65, 64, 66, 'Supporter'), (64, 0, NULL, 'default1', '2023-01-01 00:00:00.000000', 'default2', NULL, 'Supporter', 66, 64, NULL, 65, 65, NULL), (66, NULL, '2023-01-01 00:00:00.000000', NULL, '2023-01-01 01:00:00.000000', 'Supporter', 'Supporter', 'Supporter', 1, 0, NULL, 64, 66, NULL);
INSERT INTO badges (id, userid, name, date) VALUES (64, 66, 'Supporter', '2023-01-01 00:00:00.000000'), (1, 0, 'default1', '2023-01-01 00:00:00.000000'), (0, 66, 'Supporter', NULL), (65, 64, NULL, '2023-01-01 00:00:00.000000'), (66, 65, NULL, '2023-01-01 00:00:00.000000'), (2, 64, NULL, '2023-01-01 01:00:00.000000'), (3, 0, NULL, '2023-01-01 00:00:00.000000'), (4, 65, 'default1', NULL), (5, 66, 'default1', '2023-01-01 00:00:00.000000'), (6, 0, 'default1', '2023-01-01 00:00:00.000000'), (7, 0, 'default2', '2023-01-01 01:00:00.000000'), (8, NULL, 'default2', NULL), (9, NULL, NULL, '2023-01-01 00:00:00.000000'), (10, 65, NULL, '2023-01-01 01:00:00.000000'), (11, 0, NULL, NULL), (12, 65, NULL, NULL), (13, 66, 'Supporter', '2023-01-01 00:00:00.000000'), (14, 64, NULL, '2023-01-01 00:00:00.000000'), (15, 0, 'Supporter', '2023-01-01 00:00:00.000000'), (16, 66, 'default1', '2023-01-01 01:00:00.000000'), (17, 66, NULL, '2023-01-01 01:00:00.000000');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.Id) FROM users AS T1 INNER JOIN badges AS T2 ON T1.Id = T2.UserId WHERE T1.Age > 65 AND T2.Name = 'Supporter';

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT users.id) FROM users INNER JOIN badges ON users.id = badges.userid WHERE users.age > 65 AND badges.name = 'Supporter';

/*
Prediction Result:
(1,)
*/