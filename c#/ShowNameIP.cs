/*
 *This C# Program Displays the IP Address of the computer that runs this program.
 *It first obtains the host name of hte computer and then all of its IP addresses
 */
 
 using System;
 using System.Net;
 
 namespace CNT4704L
 {
	 class MySocketLab
	 {
		 static void Main()
		 {
			 string strHostname = Dns.GetHostName(); //Gets the host name of the computer running this program.
			 Console.WriteLine("\nThis computer's name is: " + strHostName);
			 
			 IPAddress[] addr = Dns.GetHostAddresses(strHostName); //Obtains all IP Addresses of the given host.
			 
			 Console.WriteLine("\nThis computer uses the following " + addr.Length + "addresses (IPv4 or IPv6) : \n");
			 
			 for (int i = 0; i < addr.Length; i++)
			 {
				 Console.WriteLine("{0}.  {1}", i+1, addr[i]);
			 }
		 }
	 }
 }