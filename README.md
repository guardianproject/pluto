## Pluggable Libraries Using Transport Obfuscation (PLUTO) for Android
#### nathan (n8fr) nathan@guardianproject.info

### What is PLUTO?

This repo is for library incarnation of PLUTO, providing a simplified means for developers to include traffic obfuscation capabilities into their applications. It supports the Obfs4 and Meek transports initially, with others to come.

### Design

The approach of this project is to provide a small bit of shim code that any app can include that will provide the ability to discover, install and manage pluggable transports for use with any app. The PTs themselves will be packaged into user-installable Android Application Package (APK) plugins, or bundled directly into an apps themselves.

## Sample

//performs query of local app assets and installed APKs with proper "PLUTO" category tag
List<PluggableTransport> pTrans = PlutoFactory.getAvailableTransports();

PluggableTransport pt = pTrans.get(0);

if (!pt.isInstalled())
{
	pt.requestInstall();
}
else
{
   if (pt.getName().equals("meek"))
   {
	String configString = "url=https://meek-reflect.appspot.com/ front=www.google.com";
	pt.setConfig(configString);
   }

   boolean connected = pt.connect();

   if (connected)
   {
	//PTs generally expose themselve as local SOCKS proxies
	int socksPort = pt.getLocalSocksPort();
	myNetMgr.setProxy(Type.SOCKS,socksPort);
   }
}

