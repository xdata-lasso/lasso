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
-- DATASET 1
-- Tests column disambiguation, join key accuracy (LastEditorUserId vs OwnerUserId vs T1.UserId), and duplicate row preservation (SELECT vs SELECT DISTINCT).
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, AccountId, Age, DisplayName) VALUES (1, 100, 10, 5, 1, 1001, 25, 'OwnerUser');
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, AccountId, Age, DisplayName) VALUES (2, 200, 20, 15, 2, 1002, 30, 'LastEditorUser');
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, AccountId, Age, DisplayName) VALUES (3, 300, 30, 25, 3, 1003, 35, 'HistoryUser');
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, AccountId, Age, DisplayName) VALUES (10, 400, 40, 35, 4, 1004, 40, 'UserIdEqualsPostId');
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, AccountId, Age, DisplayName) VALUES (100, 500, 50, 45, 5, 1005, 45, 'UserIdEqualsHistoryId');
INSERT INTO posts (Id, PostTypeId, AcceptedAnswerId, Score, ViewCount, Body, OwnerUserId, Title, Tags, AnswerCount, CommentCount, FavoriteCount, LastEditorUserId, ParentId, OwnerDisplayName, LastEditorDisplayName) VALUES (10, 1, 99, 50, 999, 'PostBody', 1, 'PostTitle', 'PostTags', 5, 6, 7, 2, 88, 'PostOwnerDisplay', 'PostEditorDisplay');
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, OwnerUserId, LastEditorUserId) VALUES (100, 1, 10, 888, 1, 1);
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId, Text, Comment, UserDisplayName) VALUES (100, 2, 10, 3, 'Computer Game Datasets', 'HistoryComment', 'HistoryUserDisplay');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId, Text, Comment, UserDisplayName) VALUES (101, 5, 10, 3, 'Computer Game Datasets', 'SecondDuplicateMatch', 'HistoryUserDisplay2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.ViewCount, T3.DisplayName FROM postHistory AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id INNER JOIN users AS T3 ON T2.LastEditorUserId = T3.Id WHERE T1.Text = 'Computer Game Datasets';

/*
Gold Result:
(999, 'LastEditorUser')
(999, 'LastEditorUser')
*/

-- Prediction Query
SELECT SUM(p.ViewCount) AS TotalViews, u.DisplayName AS LastPostedBy FROM posts AS p INNER JOIN users AS u ON p.OwnerUserId = u.Id WHERE p.Title = 'Computer Game Datasets' ORDER BY p.LasActivityDate DESC, p.id NULLS LAST, u.id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None, None)
*/