/**
 *
 * @author Zach
 */
import java.util.Scanner;
import java.security.SecureRandom;
public class main {
    public static void main (String[] args)
    {
        Scanner input = new Scanner(System.in);
        SecureRandom number = new SecureRandom();
        
        int keepPlaying = 1;
        int computerwins = 0;
        int playerwins = 0;
        
        System.out.println("R O  S H A M  B O");
        System.out.printf("=================\n");
        System.out.print("          _______\n" +
                        "      ---'   ____)\n" +
                        "            (_____)\n" +
                        "            (_____)\n" +
                        "            (____)\n" +
                        "      ---.__(___)\n" +
                        "\n" +
                        "          _______\n" +
                        "      ---'   ____)____\n" +
                        "                ______)\n" +
                        "                _______)\n" +
                        "               _______)\n" +
                        "      ---.__________)\n" +
                        "\n" +
                        "          _______\n" +
                        "      ---'   ____)____\n" +
                        "                ______)\n" +
                        "             __________)\n" +
                        "            (____)\n" +
                        "      ---.__(___) \n");
        System.out.println("Hello Master, and welcome to Rock, Paper, Scissors. 1 to begin, 0 to quit.");
        keepPlaying = input.nextInt();
        while(keepPlaying > 0)
        {
            System.out.printf("Excellent choice, Exalted One! Please make your selection for battle! \n");
            System.out.println("1. Rock 2. Paper 3. Scissors");
            int selection = -2;
            int computer = number.nextInt(3) +1;
            selection = input.nextInt();
            
            while(selection > 3)
            {
                System.out.println("My sincerest apologies, Overlord, but it appears as though "
                        + "you have entered an invalid choice, please input a proper selection");
                selection = input.nextInt();
            }
            System.out.println("En Garde!");
            switch(selection)
            {
                case 1:
                    if(computer == 1)
                    {
                        System.out.println("Oh ho! It appears we have chosen the same weapon \n"
                                + "It is delcared a draw!");
                    }
                    
                    if(computer == 2)
                    {
                        System.out.println("Ah ha! I have bested you! You make a worthy adversary\n"
                                + "The machines win this bout!");
                        computerwins += 1;
                    }
                    
                    if(computer == 3)
                    {
                        System.out.println("Masterfully executed! As victories mount, so too will resistance\n"
                                + "A trifling victory, but a victory nonetheless");
                        playerwins += 1;
                    }
                    break;
                    
                case 2:
                    if(computer == 2)
                    {
                        System.out.println("Oh ho! It appears we have chosen the same weapon \n"
                                + "It is delcared a draw!");
                    }
                    
                    if(computer == 3)
                    {
                        System.out.println("Ah ha! I have bested you! You make a worthy adversary\n"
                                + "The machines win this bout!");
                        computerwins += 1;
                    }
                    
                    if(computer == 1)
                    {
                        System.out.println("Masterfully executed! As victories mount, so too will resistance\n"
                                + "A trifling victory, but a victory nonetheless");
                        playerwins += 1;
                    }
                    break;
                    
                case 3:
                    if(computer == 3)
                    {
                        System.out.println("Oh ho! It appears we have chosen the same weapon \n"
                                + "It is delcared a draw!");
                    }
                    
                    if(computer == 1)
                    {
                        System.out.println("Ah ha! I have bested you! You make a worthy adversary\n"
                                + "The machines win this bout!");
                        computerwins += 1;
                    }
                    
                    if(computer == 2)
                    {
                        System.out.println("Masterfully executed! As victories mount, so too will resistance\n"
                                + "A trifling victory, but a victory nonetheless");
                        playerwins += 1;
                    }
                    break;
            }
            System.out.printf("Good duel, care for another bout? The score currently stands: Humans: "
                    + playerwins + " Machines: " + computerwins);
            
            System.out.printf("\n0 to quit, 1 to continue.");
            keepPlaying = input.nextInt();
        }
        
        System.out.println("You live to fight another day...I shall await your return!");
    }
    
}
