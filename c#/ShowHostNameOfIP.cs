using System;
using System.Net;

//Zachary Goss 
//Calls GetHostEntry method to pull either IP address or DNS Hostname from user input
class showHostNameofIP
{
  public static void Main(string[] myInput)
  {
	 string IP;
     Console.Write("Enter an IP address (e.g., 131.247.2.211): ");
	 IP = Console.ReadLine();
	 
	 IPHostEntry host;
	 host = GetHostEntry(IP);
	 
	 Console.WriteLine("Host name of {0} is: {1}", IP, host.HostName);
	 
    
  }
  
  public static IPHostEntry GetHostEntry(string ip)
{
	IPHostEntry host;
	
	host = Dns.GetHostEntry(ip);
	return host;
}
}