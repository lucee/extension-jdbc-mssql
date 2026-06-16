component extends="org.lucee.cfml.test.LuceeTestCase" labels="mssql" {

	// keep in sync with pom.xml mvnVersion (major.minor.patch prefix)
	variables.mavenDriverVersionPrefix = "13.4.0";

	function isNotSupported() {
		return isEmpty( server.getDatasource( "mssql" ) );
	}

	private boolean function luceeSupportsMavenJdbc() {
		try {
			return server.doesJDBCSupportMaven();
		} catch ( any e ) {
			return false;
		}
	}

	private struct function getRegisteredJdbcDriver() {
		var driver = {
			available: false,
			class: "",
			maven: "",
			bundleName: "",
			bundleVersion: "",
			error: ""
		};

		try {
			var jdbc = server.getMssqlJdbcDriverDefinition();
			driver.available = true;
			driver.class = jdbc.class;
			driver.maven = jdbc.maven ?: "";
			driver.bundleName = jdbc.bundleName ?: "";
			driver.bundleVersion = jdbc.bundleVersion ?: "";
		} catch ( any e ) {
			driver.error = e.message;
		}

		return driver;
	}

	private struct function getDatasourceResolution( required struct ds ) {
		var usesMaven = structKeyExists( arguments.ds, "maven" ) && len( arguments.ds.maven );

		return {
			mode: usesMaven ? "maven" : "bundle",
			maven: usesMaven ? arguments.ds.maven : "",
			bundleName: structKeyExists( arguments.ds, "bundleName" ) ? arguments.ds.bundleName : "",
			bundleVersion: structKeyExists( arguments.ds, "bundleVersion" ) ? arguments.ds.bundleVersion : "",
			luceeSupportsMavenJdbc: luceeSupportsMavenJdbc()
		};
	}

	function run( testResults, testBox ) {
		describe( title="MSSQL JDBC extension driver version", body=function() {
			it(
				title="reports the Microsoft JDBC driver version in use",
				skip=isNotSupported(),
				body=function( currentSpec ) {
					var ds = server.getDatasource( "mssql" );
					var resolution = getDatasourceResolution( ds );
					var registeredDriver = getRegisteredJdbcDriver();
					var bundle = bundleInfo( createObject( "java", ds.class ) );

					dbinfo datasource=ds name="local.dbVersion" type="version";

					var info = {
						luceeVersion: server.lucee.version,
						datasourceClass: ds.class,
						datasourceResolution: resolution,
						registeredJdbcDriver: registeredDriver,
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

					if ( resolution.mode eq "maven" ) {
						expect( dbVersion.driver_version ).toInclude( variables.mavenDriverVersionPrefix );
					} else {
						systemOutput( "MSSQL JDBC driver loaded via OSGi bundle (#resolution.bundleName# #resolution.bundleVersion#); Maven version assertion skipped", true );
					}
				}
			);
		} );
	}

}
