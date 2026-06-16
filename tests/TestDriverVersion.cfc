component extends="org.lucee.cfml.test.LuceeTestCase" labels="mssql" {

	// keep in sync with pom.xml
	variables.mavenDriverVersionPrefix = "13.4.0";

	function isNotSupported() {
		return isEmpty( server.getDatasource( "mssql" ) );
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
					var resolution = {
						supportsClassDefinition: false,
						supportsIsMaven: false,
						isMaven: false,
						isBundle: false,
						error: ""
					};

					try {
						var pc = getPageContext();
						var cd = pc.getDataSource( "mssql" ).getClassDefinition();
						resolution.supportsClassDefinition = true;
						resolution.isBundle = cd.isBundle();
						try {
							resolution.isMaven = cd.isMaven();
							resolution.supportsIsMaven = true;
						} catch ( any e ) {
							resolution.error = e.message;
						}
					} catch ( any e ) {
						resolution.error = e.message;
					}

					dbinfo datasource=ds name="local.dbVersion" type="version";

					var info = {
						datasourceClass: ds.class,
						datasourceBundleName: structKeyExists( ds, "bundleName" ) ? ds.bundleName : "",
						datasourceBundleVersion: structKeyExists( ds, "bundleVersion" ) ? ds.bundleVersion : "",
						bundleInfoName: bundle.name,
						bundleInfoVersion: bundle.version,
						resolution: resolution,
						driverName: dbVersion.driver_name,
						driverVersion: dbVersion.driver_version,
						databaseProduct: dbVersion.database_productname,
						databaseVersion: dbVersion.database_version,
						jdbcVersion: dbVersion.jdbc_major_version & "." & dbVersion.jdbc_minor_version
					};

					systemOutput( "MSSQL JDBC driver info: " & serializeJSON( info ), true );






					expect( dbVersion.recordCount ).toBe( 1 );
					expect( dbVersion.driver_name ).toInclude( "SQL Server" );

					if ( resolution.supportsIsMaven && resolution.isMaven ) {
						expect( dbVersion.driver_version ).toInclude( variables.mavenDriverVersionPrefix );
					} else if ( resolution.supportsIsMaven && resolution.isBundle ) {
						systemOutput( "MSSQL JDBC driver loaded via OSGi bundle path; Maven version assertion skipped", true );
					} else if ( !resolution.supportsIsMaven ) {
						systemOutput( "isMaven() not available on this Lucee version; Maven/bundle mode assertion skipped", true );
					}
				}
			);
		} );
	}

}
