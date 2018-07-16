/*
 *This C# Program Displays the IP Address of the computer that runs this program.
 *It first obtains the host name of the computer and then all of its IP addresses
 *Also tells you if the IP address is ipv4 or ipv6
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
			 string ipv4_or_ipv6;
			 
			 Console.WriteLine("\nMy computer's name is: " + strHostName);
			 
			 IPAddress[] addr = Dns.GetHostAddresses(strHostName); //Obtains all IP Addresses of the given host.
			 
			 Console.WriteLine("\nThis computer uses the following " + addr.Length + "addresses (IPv4 or IPv6) : \n");
			 
			 for (int i = 0; i < addr.Length; i++)
			 {
				 ipv4_or_ipv6 = addr[i].GetAddressBytes().Length == 4 ? "IPv4" : "IPv6"; 
				 Console.WriteLine("{0}.  ({1}) {2}", i + 1, ipv4_or_ipv6, addr[i]);
			 }
		 }
	 }
 }