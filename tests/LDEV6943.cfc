component extends="org.lucee.cfml.test.LuceeTestCase" labels="mssql" {

	function run( testResults, testBox ) {
		describe( "LDEV-6943 mssql DSN keeps the database name", function() {

			it( title="pom connstr includes databaseName={database}", body=function() {
				var pom = fileRead( getDirectoryFromPath( getCurrentTemplatePath() ) & "../pom.xml" );
				var match = reMatchNoCase( "<connstr>(.*?)</connstr>", pom );
				expect( arrayLen( match ) ).toBeGT( 0 );
				var connstr = reReplaceNoCase( match[ 1 ], "</?connstr>", "", "all" );
				expect( connstr ).toBe( "jdbc:sqlserver://{host}:{port};databaseName={database}" );
			});

		});
	}

}
