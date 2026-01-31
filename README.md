# Lucee MS-SQL JDBC Extension

[![Java CI](https://github.com/lucee/extension-jdbc-mssql/actions/workflows/blank.yml/badge.svg)](https://github.com/lucee/extension-jdbc-mssql/actions/workflows/blank.yml)

## Modern Mode

The MSSQL JDBC driver has a quirk where certain exceptions (like `RAISERROR`) get queued and only surface when iterating through all result sets. Without proper handling, these errors can be silently swallowed.

Modern Mode ensures Lucee properly surfaces these deferred exceptions. Enable it via:

- **System Property**: `-Dlucee.datasource.mssql.modern=true`
- **Environment Variable**: `LUCEE_DATASOURCE_MSSQL_MODERN=true`

See the [MSSQL Modern Mode documentation](https://docs.lucee.org/recipes/mssql-modern-mode.html) for full details.

## Issues

[MSSQL Issues on Jira](https://luceeserver.atlassian.net/issues/?jql=labels%20%3D%20%22mssql%22)
