component extends="org.lucee.cfml.test.LuceeTestCase" labels="mssql" {

	// keep in sync with pom.xml
	variables.legacyBundleVersionPrefix = "12.10.2";
	variables.mavenDriverVersionPrefix = "13.4.0";

	function isNotSupported() {
		return isEmpty( server.getDatasource( "mssql" ) );
	}

	private boolean function usesLegacyBundleDriver( required string driverVersion ) {
		// Lucee versions without extension maven: support resolve org.lucee.mssql from bundleVersion
		return find( variables.legacyBundleVersionPrefix, arguments.driverVersion );
	}

	function run( testResults, testBox ) {
		describe( title="MSSQL JDBC extension driver version", body=function() {
			it(
				title="reports the Microsoft JDBC driver version in use",
				skip=isNotSupported(),
				body=function( currentSpec ) {
					var ds = server.getDatasource( "mssql" );
					var driverClass = createObject( "java", "com.microsoft.sqlserver.jdbc.SQLServerDriver" );
					var bundle = bundleInfo( driverClass );

					dbinfo datasource=ds name="local.dbVersion" type="version";

					var info = {
						datasourceClass: ds.class,
						datasourceBundleName: structKeyExists( ds, "bundleName" ) ? ds.bundleName : "",
						datasourceBundleVersion: structKeyExists( ds, "bundleVersion" ) ? ds.bundleVersion : "",
						bundleInfoName: bundle.name,
						bundleInfoVersion: bundle.version,
						driverName: dbVersion.driver_name,
						driverVersion: dbVersion.driver_version,
						databaseProduct: dbVersion.database_productname,
						databaseVersion: dbVersion.database_version,
						jdbcVersion: dbVersion.jdbc_major_version & "." & dbVersion.jdbc_minor_version
					};

					systemOutput( "MSSQL JDBC driver info: " & serializeJSON( info ), true );

					expect( dbVersion.recordCount ).toBe( 1 );
					expect( dbVersion.driver_name ).toInclude( "SQL Server" );

					if ( usesLegacyBundleDriver( dbVersion.driver_version ) ) {
						systemOutput( "MSSQL JDBC driver loaded via legacy OSGi bundle (#variables.legacyBundleVersionPrefix#); version check skipped", true );
					} else {
						expect( dbVersion.driver_version ).toInclude( variables.mavenDriverVersionPrefix );
					}
				}
			);
		} );
	}

}
