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
INSERT INTO users (Id, Reputation, DisplayName, Views, UpVotes, DownVotes, AccountId, Age) VALUES (1, 10, 'User_Owner', 111, 1, 0, 101, 25);
INSERT INTO users (Id, Reputation, DisplayName, Views, UpVotes, DownVotes, AccountId, Age) VALUES (2, 20, 'User_LastEditor', 222, 2, 0, 102, 30);
INSERT INTO users (Id, Reputation, DisplayName, Views, UpVotes, DownVotes, AccountId, Age) VALUES (3, 30, 'User_HistoryActor', 333, 3, 0, 103, 35);
INSERT INTO users (Id, Reputation, DisplayName, Views, UpVotes, DownVotes, AccountId, Age) VALUES (10, 40, 'User_SameIdAsPost', 444, 4, 0, 104, 40);
INSERT INTO users (Id, Reputation, DisplayName, Views, UpVotes, DownVotes, AccountId, Age) VALUES (100, 50, 'User_SameIdAsHistory', 555, 5, 0, 105, 45);
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, Body, OwnerUserId, Title, Tags, AnswerCount, CommentCount, FavoriteCount, LastEditorUserId, OwnerDisplayName, LastEditorDisplayName) VALUES (10, 1, 50, 999, 'Other Body', 1, 'Other Title', '<other>', 5, 6, 7, 2, 'Wrong_Owner_DN', 'Wrong_Editor_DN');
INSERT INTO posts (Id, PostTypeId, Score, ViewCount, Body, OwnerUserId, Title, Tags, AnswerCount, CommentCount, FavoriteCount, LastEditorUserId, OwnerDisplayName, LastEditorDisplayName) VALUES (100, 1, 60, 888, 'Post 100 Body', 1, 'Post 100 Title', '<post100>', 1, 1, 1, 1, 'Owner_100', 'Editor_100');
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId, Text, Comment, UserDisplayName) VALUES (100, 2, 10, 3, 'Computer Game Datasets', 'Other Comment', 'Wrong_History_DN');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.ViewCount, T3.DisplayName FROM postHistory AS T1 INNER JOIN posts AS T2 ON T1.PostId = T2.Id INNER JOIN users AS T3 ON T2.LastEditorUserId = T3.Id WHERE T1.Text = 'Computer Game Datasets';

/*
Gold Result:
(999, 'User_LastEditor')
*/

-- Prediction Query
SELECT T1.ViewCount, T2.DisplayName FROM posts AS T1 INNER JOIN users AS T2 ON T1.LastEditorUserId = T2.Id WHERE T1.Title = 'Computer Game Datasets';

/*
Prediction Result:
*/