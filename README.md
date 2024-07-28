# 1. 前提条件
[Flyway CLI](https://documentation.red-gate.com/fd/command-line-184127404.html)が使用可能となっていること

# 2. 注意点
2024/07/28現在、Flyway Maven PluginではTOML形式の設定ファイルを読み込むことができないため、必ずFlyway CLIを使用すること。旧来の.propertiesならば使用可能だが、可読性を優先してTOML形式としたいためプラグインは使用しない。

# 3. 使用例
## 3.1. info:適用状況の確認
```ShellSession
$ flyway info -configFiles=./flyway/conf/dev.toml -locations=filesystem:./flyway/sql
Flyway Community Edition 10.16.0 by Redgate

See release notes here: https://rd.gt/416ObMi
Database: jdbc:postgresql://almalinux8:5432/postgres (PostgreSQL 15.6)
Schema history table "public"."flyway_schema_history" does not exist yet

You are not signed in to Flyway, to sign in please run auth
Schema version: << Empty Schema >>

+-----------+---------------+----------------+------+--------------+---------+----------+
| Category  | Version       | Description    | Type | Installed On | State   | Undoable |
+-----------+---------------+----------------+------+--------------+---------+----------+
| Versioned | 1.20240728.01 | create schemas | SQL  |              | Pending | No       |
| Versioned | 1.20240728.02 | create tables  | SQL  |              | Pending | No       |
| Versioned | 1.20240728.03 | initital datas | SQL  |              | Pending | No       |
| Versioned | 2.20240728.01 | alter users    | SQL  |              | Pending | No       |
+-----------+---------------+----------------+------+--------------+---------+----------+
```

## 3.2. migrate -target={version}:特定バージョンを指定してマイグレーション
```ShellSession
$ flyway migrate -target=1.20240728.03 -configFiles=./flyway/conf/dev.toml
Flyway Community Edition 10.16.0 by Redgate

See release notes here: https://rd.gt/416ObMi
Database: jdbc:postgresql://almalinux8:5432/postgres (PostgreSQL 15.6)
Schema history table "public"."flyway_schema_history" does not exist yet
Successfully validated 4 migrations (execution time 00:00.025s)
Creating Schema History table "public"."flyway_schema_history" ...
Current version of schema "public": << Empty Schema >>
Migrating schema "public" to version "1.20240728.01 - create schemas"
Migrating schema "public" to version "1.20240728.02 - create tables"
Migrating schema "public" to version "1.20240728.03 - initital datas"
Successfully applied 3 migrations to schema "public", now at version v1.20240728.03 (execution time 00:00.020s)

You are not signed in to Flyway, to sign in please run auth

$ psql -U postgres -h almalinux8
psql (15.6)
"help"でヘルプを表示します。

postgres=# SELECT * FROM dev.users;
 id | name
----+------
  1 | taro
(1 行)

postgres=# \q
```

## 3.3. migrate -target={version} -configFiles={file_path}:設定ファイルを指定してマイグレーション
```ShellSession
$ flyway migrate -target=1.20240728.03 -configFiles=./flyway/conf/stg.toml
Flyway Community Edition 10.16.0 by Redgate

See release notes here: https://rd.gt/416ObMi
Database: jdbc:postgresql://almalinux8:5432/postgres (PostgreSQL 15.6)
Schema history table "public"."flyway_schema_history" does not exist yet
Successfully validated 4 migrations (execution time 00:00.025s)
Creating Schema History table "public"."flyway_schema_history" ...
Current version of schema "public": << Empty Schema >>
Migrating schema "public" to version "1.20240728.01 - create schemas"
Migrating schema "public" to version "1.20240728.02 - create tables"
Migrating schema "public" to version "1.20240728.03 - initital datas"
Successfully applied 3 migrations to schema "public", now at version v1.20240728.03 (execution time 00:00.020s)

You are not signed in to Flyway, to sign in please run auth

$ psql -U postgres -h almalinux8-2
psql (15.6)
"help"でヘルプを表示します。

postgres=# SELECT * FROM stg.users;
 id | name
----+------
  1 | jiro
  2 | hoge
  3 | fuga
(3 行)

postgres=# \q
```

## 3.4. migrate:最新バージョンへマイグレーション
```ShellSession
$ flyway migrate -configFiles=./flyway/conf/prd.toml
Flyway Community Edition 10.16.0 by Redgate

See release notes here: https://rd.gt/416ObMi
Database: jdbc:postgresql://almalinux8-3:5432/postgres (PostgreSQL 15.6)
Successfully validated 4 migrations (execution time 00:00.056s)
Current version of schema "public": 1.20240728.03
Migrating schema "public" to version "2.20240728.01 - alter users"
Successfully applied 1 migration to schema "public", now at version v2.20240728.01 (execution time 00:00.030s)

You are not signed in to Flyway, to sign in please run auth

$ psql -U postgres -h almalinux8-3
psql (15.6)
"help"でヘルプを表示します。

postgres=# SELECT * FROM prd.users;
 id | full_name | first_name | last_name
----+-----------+------------+-----------
  1 | saburo    |            |
  2 | foo       |            |
  3 | bar       |            |
(3 行)

postgres=# \qs
```
