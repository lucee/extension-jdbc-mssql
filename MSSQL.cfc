component extends="types.Driver" implements="types.IDatasource" {
	this.className="{class-name}";
	this.bundleName="{bundle-name}";
	this.dsn="{connection-string}";
		
	this.type.port=this.TYPE_FREE;
	this.value.host="localhost";
	this.value.port=1433;

	fields=[
		field("Instance Name","instanceName","",false,
			"The database instance name to connect to. When it isn't specified, a connection is made to the default instance. 
			For the case where both the instanceName and port are specified, see the notes for port.
			If you specify a Virtual Network Name in the Server connection property, you can't use the instanceName connection property. 
			For more information about disaster recovery, see https://learn.microsoft.com/en-us/sql/connect/jdbc/jdbc-driver-support-for-high-availability-disaster-recovery?view=sql-server-ver16",
		"text")
		,field("Select Method","SelectMethod","direct,cursor",true,
			"A hint to the driver that determines whether the driver requests a database cursor for Select statements. Performance and behavior of the driver are affected by this property,
			which is defined as a hint because the driver may not always be able to satisfy the requested method.<ul>
			<li>Direct: When the driver uses the Direct method, the database server sends the complete result set in a single response to the driver when responding to a query.
			<li>Cursor: When the driver uses the Cursor method, a server-side cursor is requested. The rows are retrieved from the server in blocks when returning forward-only result sets.</ul>",
		"select")
		,field("Send String Parameters as Unicode","sendStringParametersAsUnicode","true,false",false,
			"Set to ""false"" to specify that prepared parameters for character data are sent as ASCII instead of Unicode. 
			This parameter can improve performance for character data index lookup on non-Unicode, SQL Server 2000, or SQL Server 2005 tables. 
			For example, ASCII row keys can be compared directly without the overhead of conversion from Unicode.",
		"radio")
		,field("Application Intent","applicationIntent","ReadWrite,ReadOnly",false,
			"(Version 6.0+) Declares the application workload type to connect to a server.",
		"radio")
		,field("Authentication","authentication","ActiveDirectoryIntegrated,ActiveDirectoryPassword,ActiveDirectoryMSI,ActiveDirectoryInteractive,ActiveDirectoryServicePrincipal,SqlPassword,NotSpecified",false,
			" This optional property indicates which authentication method to use for connection.
			Possible values are ActiveDirectoryIntegrated, ActiveDirectoryPassword, ActiveDirectoryMSI (version 7.2+), ActiveDirectoryInteractive (version 9.2+), 
			ActiveDirectoryServicePrincipal (version 9.2+), SqlPassword, and the default NotSpecified. Learn more here https://learn.microsoft.com/en-us/sql/connect/jdbc/setting-the-connection-properties?view=sql-server-ver16",
		"radio",7)
		,field("Authentication Scheme","authenticationScheme","NativeAuthentication,JavaKerberos,NTLM",false,
			"Indicates which kind of integrated security you want your application to use. Possible values are JavaKerberos, NTLM (version 7.4+), and the default NativeAuthentication.
			Learn more here https://learn.microsoft.com/en-us/sql/connect/jdbc/setting-the-connection-properties?view=sql-server-ver16",
		"radio",1)
		,field("Client Certificate","clientCertificate","",false,
			"(Version 8.4+) Specifies the location of the certificate to be used for client certificate authentication. The JDBC driver supports PFX, PEM, DER, and CER file extensions.
			Learn more here https://learn.microsoft.com/en-us/sql/connect/jdbc/client-certification-authentication-for-loopback-scenarios?view=sql-server-ver16",
		"text")
		,field("Client Key","clientKey","",false,
			"(Version 8.4+) Specifies the location of the private key for PEM, DER, and CER certificates specified by the clientCertificate attribute.
			Learn more here https://learn.microsoft.com/en-us/sql/connect/jdbc/client-certification-authentication-for-loopback-scenarios?view=sql-server-ver16",
		"text")
		,field("Client Key Password","clientKeyPassword","",false,
			"(Version 8.4+) Specifies the optional password string for accessing the clientKey file's private key.
			Learn more here https://learn.microsoft.com/en-us/sql/connect/jdbc/client-certification-authentication-for-loopback-scenarios?view=sql-server-ver16",
		"text")
		,field("Column Encryption Setting","columnEncryptionSetting","Enabled,Disabled",false,
			"(Version 6.0+) Set to ""Enabled"" to use the Always Encrypted (AE) feature. When AE is enabled, the JDBC driver transparently encrypts and decrypts sensitive data stored in encrypted database columns on the server.
			Note: Always Encrypted is available with SQL Server 2016 or later and Azure SQL Database.
			Learn more here https://learn.microsoft.com/en-us/sql/connect/jdbc/using-always-encrypted-with-the-jdbc-driver?view=sql-server-ver16",
		"radio",2)
		,field("Connect Retry Count","connectRetryCount","",false,
			"(Version 9.4+) The number of reconnection attempts if there's a connection failure, a number between 1 and 255 (default 1).",
		"text")
		,field("Connect Retry Interval","connectRetryInterval","",false,
			"(Version 9.4+) The number of seconds between each connection retry attempt, a number between 1 and 60 (default 10). ",
		"text")
		,field("Domain","domain","",false,
			"(Version 7.4+) The Windows domain to authenticate to when using NTLM authentication.",
		"text")
		,field("Disable Statement Pooling","disableStatementPooling","true,false",false,
			"Flag indicates if statement pooling should be used.",
		"radio",1)
		,field("Failover Partner","domafailoverPartnerin","",false,
			"The name of the failover server used in a database mirroring configuration. This property is used for an initial connection failure to the principal server. 
			After you make the initial connection, this property is ignored. Must be used with the databaseName property.
			Note: The driver doesn't support the server instance port number for the failover partner instance as part of the failoverPartner property in the connection string. 
			However, specifying the serverName, instanceName, and portNumber properties of the principal server instance and failoverPartner property of the failover partner instance in the same connection string is supported.
			If you specify a Virtual Network Name in the Server connection property, you can't use database mirroring.
			For more information about disaster recovery, see https://learn.microsoft.com/en-us/sql/connect/jdbc/jdbc-driver-support-for-high-availability-disaster-recovery?view=sql-server-ver16",
		"text")
		,field("Integrated Security","integratedSecurity","true,false",false,
			"Set to ""true"" to indicate that Windows credentials are used by SQL Server on Windows operating systems. If ""true"", 
			the JDBC driver searches the local computer credential cache for credentials that were provided when a user signed in to the computer or network.
			Set to ""true"" (with authenticationscheme=JavaKerberos), to indicate that Kerberos credentials are used by SQL Server. For more information about Kerberos authentication, 
			see https://learn.microsoft.com/en-us/sql/connect/jdbc/using-kerberos-integrated-authentication-to-connect-to-sql-server?view=sql-server-ver16
			Set to ""true"" (with authenticationscheme=NTLM), to indicate that NTLM credentials are used by SQL Server. If ""false"", the username and password must be supplied.",
		"radio",2)
		,field("Encrypt","encrypt","true,false",false,
			"When true, SQL Server uses SSL encryption for all data sent between the client and server if the server has a certificate installed.",
			"radio",1)
		,field("TrustServerCertificate","trustServerCertificate","true,false",true,
			"When set to true, SSL is used to encrypt the channel when bypassing walking the certificate chain to validate trust. 
			If TrustServerCertificate is set to true and Encrypt is set to false, the channel is not encrypted.",
			"radio",1)
		,field("Key Store Authentication","keyStoreAuthentication","",false,
			"(Version 6.0+) This property identifies which key store to use with Always Encrypted and determines an authentication mechanism used to authenticate to the key store.
			The driver supports setting up of the Java Key Store seamlessly when you set ""keyStoreAuthentication=JavaKeyStorePassword"". 
			To use this property, you also must set the keyStoreLocation and keyStoreSecret properties for the Java Key Store.
			For more information about Always Encrypted, see https://learn.microsoft.com/en-us/sql/connect/jdbc/using-always-encrypted-with-the-jdbc-driver?view=sql-server-ver16 .
			Beginning with Microsoft JDBC Driver 8.4, you can set ""keyStoreAuthentication=KeyVaultManagedIdentity"" or 
			""keyStoreAuthentication=KeyVaultClientSecret"" to authenticate to Azure Key Vault using Managed Identities.
			For more information about Always Encrypted, see https://learn.microsoft.com/en-us/sql/connect/jdbc/using-always-encrypted-with-the-jdbc-driver?view=sql-server-ver16",
		"text")
		,field("Key Store Location","keyStoreLocation","",false,
			"(Version 6.0+) When keyStoreAuthentication=JavaKeyStorePassword, 
			the keyStoreLocation property identifies the path to the Java keystore file that stores the Column Master Key to be used with Always Encrypted data. 
			The path must include the keystore filename.
			For more information about Always Encrypted, see https://learn.microsoft.com/en-us/sql/connect/jdbc/using-always-encrypted-with-the-jdbc-driver?view=sql-server-ver16",
		"text")
		,field("Key Store Principal Id","keyStorePrincipalId","",false,
			"(Version 8.4+) When keyStoreAuthentication=KeyVaultManagedIdentity, the keyStorePrincipalId property specifies a valid Azure Active Directory application client ID.
			For more information about Always Encrypted, see https://learn.microsoft.com/en-us/sql/connect/jdbc/using-always-encrypted-with-the-jdbc-driver?view=sql-server-ver16",
		"text")
		,field("Key Store Secret","keyStoreSecret","",false,
			"(Version 6.0+) When keyStoreAuthentication=JavaKeyStorePassword, the keyStoreSecret property identifies the password to use for the keystore and the key. 
			For using the Java Key Store, the keystore and the key password must be the same.
			For more information about Always Encrypted, see https://learn.microsoft.com/en-us/sql/connect/jdbc/using-always-encrypted-with-the-jdbc-driver?view=sql-server-ver16",
		"text")
		,field("Lock Timeout","lockTimeout","",false, 
			"The number of milliseconds to wait before the database reports a lock time-out. 
			The default behavior is to wait indefinitely. If it's specified, this value is the default for all statements on the connection. 
			The value can be 0, which specifies no wait.",
		"text")
		,field("Login Timeout","loginTimeout","",false,
			"The number of seconds the driver should wait before timing out a failed connection. 
			A zero value indicates that the timeout is the default system timeout, which is specified as 15 seconds by default. 
			A non-zero value is the number of seconds the driver should wait before timing out a failed connection.
			If you specify a Virtual Network Name in the Server connection property, 
			you should specify a timeout value of three minutes or more to allow sufficient time for a failover connection to succeed. 
			For more information about disaster recovery, see https://learn.microsoft.com/en-us/sql/connect/jdbc/jdbc-driver-support-for-high-availability-disaster-recovery?view=sql-server-ver16",
		"text")
		,field("Query Timeout","queryTimeout","",false,
			"The number of seconds to wait before a timeout has occurred on a query. The default value is -1, which means infinite timeout. Set this value to 0 also implies to wait indefinitely.",
		"text")
		,field("Socket Timeout","socketTimeout","",false,
			"The number of milliseconds to wait before a timeout is occurred on a socket read or accept. The default value is 0, which means infinite timeout.",
		"text")
		,field("MSI Client Id","msiClientId","",false, 
			"(Version 7.2+) The Client ID of the Managed Identity (MSI) used to acquire an accessToken to establish a connection with the ActiveDirectoryMSI authentication mode.",
		"text")
		,field("Workstation ID","workstationID","",false,
			"The workstation ID. Used to identify the specific workstation in various profiling and logging tools.
			If none is specified, the <empty string> is used.",
		"text")
		
	];
	data={};
	
	public struct function customParameterSyntax() {
		return {leadingdelimiter:';',delimiter:';',separator:'='};
	}
	
	public void function onBeforeUpdate() {
		var keysToDelete=[];
		
		// get fields
		var fieldsArr=getFields();
		var fields={};
		loop array=fieldsArr item="f" {
			fields[f.getName()]=f.getRequired();
		}
		// get the keys od the empty fields
		loop struct=form index="local.kwp" item="v" {
			if(find("custom_",kwp)==1 && isEmpty(trim(v))) {
				var k= mid(kwp,8);
				if(structKeyExists(fields, k) && !fields[k]){
					arrayAppend(keysToDelete, kwp);
				}
			}
		}
		loop array=keysToDelete item="k" {
			structDelete(form, k);

		}
		form.custom_DatabaseName=form.database;
	}

	/**
	 * returns array of fields
	 */
	public array function getFields() {
		return fields;
	}

	/**
	 * returns display name of the driver
	 */
	public string function getName() {
		return "{label}";
	}

	/**
	 * returns the ID of the driver
	 */
	public string function getId() {
		return "{id}";
	}

	/**
	 * returns description for the driver
	 */
	public string function getDescription() {
		return "{description}";
	}

	/**
	 * return if String class match this
	 */
	public boolean function equals(required className,required dsn) {
		return this.className EQ arguments.className and findNoCase("sqlserver",arguments.dsn);
	}
}