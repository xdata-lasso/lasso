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
-- DATASET 2
INSERT INTO users (Id, Reputation, CreationDate, DisplayName, LastAccessDate, WebsiteUrl, Location, AboutMe, Views, UpVotes, DownVotes, AccountId, Age, ProfileImageUrl) VALUES (183, 400, '2018-01-01 00:00:00', 'NoPostsUser183', '2020-01-01 00:00:00', 'http://u183.com', 'GhostTown183', 'No posts owned', 40, 10, 2, 1183, 35, 'u183.png');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName, LastAccessDate, WebsiteUrl, Location, AboutMe, Views, UpVotes, DownVotes, AccountId, Age, ProfileImageUrl) VALUES (200, 800, '2018-02-01 00:00:00', 'ActiveUser200', '2020-02-01 00:00:00', 'http://u200.com', 'ActiveCity200', 'Has posts', 80, 20, 1, 1200, 40, 'u200.png');
INSERT INTO posts (Id, PostTypeId, AcceptedAnswerId, CreaionDate, Score, ViewCount, Body, OwnerUserId, LasActivityDate, Title, Tags, AnswerCount, CommentCount, FavoriteCount, LastEditorUserId, LastEditDate, ParentId, OwnerDisplayName, LastEditorDisplayName) VALUES (183, 1, 183, '2019-05-01 00:00:00', 183, 183, 'Owned by 200 but edited by 183', 200, '2020-05-01 00:00:00', 'Post 183', '<test>', 1, 1, 1, 183, '2020-05-01 00:00:00', 183, 'NoPostsUser183', 'NoPostsUser183');
INSERT INTO posts (Id, PostTypeId, AcceptedAnswerId, CreaionDate, Score, ViewCount, Body, OwnerUserId, LasActivityDate, Title, Tags, AnswerCount, CommentCount, FavoriteCount, LastEditorUserId, LastEditDate, ParentId, OwnerDisplayName, LastEditorDisplayName) VALUES (500, 1, NULL, '2019-06-01 00:00:00', 10, 50, 'Orphaned post edited by 183', NULL, '2020-06-01 00:00:00', 'Orphan Post', '<test>', 0, 0, 0, 183, '2020-06-01 00:00:00', NULL, 'NoPostsUser183', 'NoPostsUser183');
INSERT INTO badges (Id, UserId, Name, Date) VALUES (1, 183, 'Student', '2019-07-01 00:00:00');
INSERT INTO comments (Id, PostId, Score, Text, CreationDate, UserId, UserDisplayName) VALUES (1, 183, 5, 'Comment by 183', '2019-07-02 00:00:00', 183, 'NoPostsUser183');
INSERT INTO votes (Id, PostId, VoteTypeId, CreationDate, UserId, BountyAmount) VALUES (1, 183, 2, '2019-07-03', 183, 0);
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, RevisionGUID, CreationDate, UserId, Text, Comment, UserDisplayName) VALUES (1, 2, 183, 'guid-1', '2019-07-04 00:00:00', 183, 'History text', 'Edit by 183', 'NoPostsUser183');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.DisplayName, T2.Location FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE T2.Id = 183 ORDER BY T1.LastEditDate DESC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT T2.DisplayName, T2.Location FROM posts AS T1 LEFT JOIN users AS T2 ON T1.LastEditorUserId = T2.Id WHERE T1.Id = 183 AND NOT T1.LastEditorUserId IS NULL;

/*
Prediction Result:
('NoPostsUser183', 'GhostTown183')
*/