using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Net.Sockets;

namespace ClientSocket
{
    class Program
    {
        static void Main(string[] args)
        {
            TcpClient client = new TcpClient("127.0.0.1", 2055);
            try
            {
                Stream s = client.GetStream();
                StreamReader sr = new StreamReader(s);
                StreamWriter sw = new StreamWriter(s);
				StreamReader sr2 = new StreamReader(s);
                StreamWriter sw2 = new StreamWriter(s);
                sw.AutoFlush = true;
				sw2.AutoFlush = true;
                Console.WriteLine(sr.ReadLine());
                while (true)
                {
                    Console.Write("Enter a Student ID: ");
                    string title = Console.ReadLine();
                    sw.WriteLine(title);
                    if (title == "") 
						break;
					string major = sr.ReadLine();
                    Console.WriteLine(major);
					//string major = Console.ReadLine(sr.ReadLine());
					sw2.WriteLine(major);
					//Console.WriteLine(sr2.ReadLine());
					Console.WriteLine(sr.ReadLine());
					

                }
                s.Close();
            }
            finally
            {
                client.Close();
            } 
 
        }
    }
}