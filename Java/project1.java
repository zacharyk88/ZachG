/**
 *
 * @author Zach
 */
import java.util.Scanner;

public class Project1 {
        public static void main(String[] args)
        {
        // declare variables
        int customerID = 0;
        double totalEarnings = 0.0;//ADDED
        double federalTaxWH = 0.0;//ADDED
        double stateTaxWH = 0.0;//ADDED
        double deductions = 0.0;//ADDED
        double taxableIncome = 0.0;
        double federalTax = 0.0;
        double stateRefund = 0.0;
        double stateTax = 0.0;
        double federalRefund = 0.0;
        
        String output = new String();
        output = String.format(
        "Cust.                   Taxable Federal State Federal State Federal State\n" +
        " ID   Income Deductions Income    Tax    Tax    W/H    W/H  Refund  Refund\n" +
        "===== ====== ========== ======= ======= ===== ======= ===== ======= ======\n" + "\n"); 

        // Create a Scanner input object
        Scanner input = new Scanner(System.in);


        // Begin first customer
        // Get first Customer ID
        System.out.print("Enter the first customer ID (-1 to quit) : ");
        customerID = input.nextInt();
        
        while(customerID != -1)
        {
            System.out.println("Thank you, now please enter your total earnings");
            totalEarnings = input.nextDouble();
            
            System.out.println("Thank you! Now please enter your Federally withheld taxes");
            federalTaxWH = input.nextDouble();
            
            System.out.println("Thank you. Please enter your state's withheld taxes");
            stateTaxWH = input.nextDouble();
            
            System.out.println("Lastly, please enter your deductions");
            deductions = input.nextDouble();
            //changed the output message each time to know if/where any bugs arise
            
            
            // Get income and withholding information

            // Calculate taxes due/refunds
            taxableIncome = totalEarnings - deductions;

            //calculate Federal Tax
            if (taxableIncome <= 10000)
            {
                federalTax = 0.0;
            }
            
            if(taxableIncome > 10000 && taxableIncome <= 20000)
            {
                federalTax = (taxableIncome - 10000) * .15;
            }
            
            if(taxableIncome > 20000 && taxableIncome <= 40000)
            {
                federalTax = ((taxableIncome - 20000) * .2) + (10000 * .15);
                //makes sure the full 20000 gets taxed and then the 10000
            }
           
            if(taxableIncome > 40000)
            {
                federalTax = ((taxableIncome - 40000) * .3) + (20000 * .2) + (10000 * .15);
            }
            
            stateTax = federalTax * 0.07;
            federalRefund = federalTaxWH - federalTax;
            stateRefund = stateTaxWH - stateTax;
            
            // Add data to output String
            //*do that thing with output format or printf
            output += String.format("%5d $%5.0f $%9.0f $%6.0f $%6.0f $%4.0f $%6.0f $%4.0f $%6.0f $%5.0f \n", customerID, totalEarnings, deductions, taxableIncome, federalTax, stateTax, federalTaxWH, stateTaxWH, federalRefund, stateRefund);
            

            // Get next Customer ID
            System.out.print("Enter the next customer ID: ");
            customerID = input.nextInt();
        }

        // Print out table of data and end program
        System.out.println(output);

   }
}
