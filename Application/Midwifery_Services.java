import java.sql.* ;
import java.util.Scanner;
import java.util.HashMap;
import java.util.Random;

public class Midwifery_Services {
	
	static HashMap<String, HashMap<String,String>> appoints;
	static String date = null;
	
	public static void endConnection(Connection con, Statement statement) {
	      try {
			statement.close ( ) ;
		    con.close ( ) ;	
		} catch (SQLException e) {}
	      System.out.println("Thank you for using Midwifery Services");
	      System.exit(0);
	}
	
	public static String appStart(Connection con, Statement statement) {
		while (true) {
			Scanner sc =new Scanner(System.in);  
			System.out.print("Please enter your practitioner id [E] to exit:");
			String str= sc.nextLine(); 
			if (str.equals("E")) {
				endConnection(con,statement);
			}
			else {
				try{
				String query = "SELECT * FROM Midwife WHERE practitionerid = \'"+str+"\'";
				java.sql.ResultSet rs = statement.executeQuery(query);
				// checking if ResultSet is empty 
				if (rs.next() == false) {
					System.out.println("Invalid Practitioner ID. Please Try Again");
					}
				else {
					return str;
				}
				}
				catch (SQLException e){
					System.out.println("Invalid Practitioner ID. Please Try Again");					
				}
				
			}
		}
	}
	
	public static HashMap<String,String> askDate(Connection con, Statement statement, String pracid) {
		while (true) {
		    Scanner sc=new Scanner(System.in);  
			if (date == null) {
		      System.out.print("Please enter the date for appointment list [E] to exit:");
		      date = sc.nextLine();
		      if (date.equals("E")) {
		    	  endConnection(con,statement);
		      }
			}
		    String appointListQuery = "SELECT appointid,time,M.name,M.qchc, P.coupleid,P.pregnancyNo, P.primarymidwife,P.backupmidwife " + 
		      		"FROM mother M INNER JOIN Couple C ON M.qchc = C.qchc " + 
		      		"    INNER JOIN pregnancy P ON C.coupleid = P.coupleid " + 
		      		"    INNER JOIN appointment A ON A.coupleid = P.coupleid AND A.pregnancyNo = P.pregnancyNo " + 
		      		"    INNER JOIN midwife Mi on A.practitionerid = Mi.practitionerid " + 
		      		"WHERE DATE = \'" + date + "\' AND A.practitionerid = \'" + pracid + "\' ORDER BY time";
		      appoints = new HashMap<String, HashMap<String,String>>();
		      try {
			      System.out.println();
			      java.sql.ResultSet rs = statement.executeQuery(appointListQuery);
			      int i = 1;
			      while (rs.next()) {
			    	  HashMap<String,String> ap = new HashMap<String,String>();
			    	  ap.put("appointid",rs.getString("appointid"));
			    	  ap.put("time",rs.getString("time"));
			    	  ap.put("name",rs.getString("name"));
			    	  ap.put("qchc",rs.getString("qchc"));
			    	  ap.put("coupleid",rs.getString("coupleid"));
			    	  ap.put("pregnancyNo",rs.getString("pregnancyNo"));
			    	  ap.put("primarymidwife",rs.getString("primarymidwife"));
			    	  ap.put("backupmidwife",rs.getString("backupmidwife"));
			    	  appoints.put(Integer.toString(i),ap);
			    	  if (ap.get("primarymidwife").equals(pracid)) {
			    		  System.out.println(i + ":\t" + ap.get("time") + "\tP\t"+ ap.get("name") + "\t" + ap.get("qchc"));    		  
			    	  }
			    	  else {
			    		  System.out.println(i + ":\t" + ap.get("time") + "\tB\t"+ ap.get("name") + "\t" + ap.get("qchc"));    		  
			    	  }
			    	  i++;
			      }
			      if (i == 1) { //no result
			    	  date = null;
			    	  System.out.println("No appointments in that given date");
			      }
			      else {
			    	  while (true) {
				    	  System.out.print("Enter the appointment number that you would like to work on.\n" + 
				    	  		"[E] to exit [D] to go back to another date :");
					      String chosenAp= sc.nextLine();
					      if (chosenAp.equals("E")) {
					    	  endConnection(con,statement);
					      }
					      else if (chosenAp.equals("D")) {
					    	  date = null;
					    	  return askDate(con,statement,pracid);
					      }
					      else {
					    	  if (appoints.containsKey(chosenAp)) {
					    		  return appoints.get(chosenAp);
					    	  }
					    	  else {
					    		  System.out.println("Invalid Input. Try again");	
					    	  }
					      }
				      }
			      }
		      }
			catch (SQLException e){
					System.out.println("Invalid Date. Try again");					
				}
		}
		
	}
	
	public static void reviewNotes(Connection con, Statement statement, String pracid, HashMap<String,String> chosen) {
		String query = "SELECT N.date, N.time, SUBSTRING(N.content,1,50) AS content " + 
				"FROM pregnancy P INNER JOIN appointment A ON A.coupleid = P.coupleid AND A.pregnancyNo = P.pregnancyNo " + 
				"INNER JOIN note N ON A.appointid = N.appointID " + 
				"WHERE P.coupleid = '" + chosen.get("coupleid") + "' AND P.pregnancyNo = '" + chosen.get("pregnancyNo") + "' " + 
				"ORDER BY N.date DESC, N.time DESC";
		try {
		    java.sql.ResultSet rs = statement.executeQuery(query);
			int i = 1;
			while(rs.next()) {
				System.out.println(rs.getString("date") + "\t" + rs.getString("time") + "\t" + rs.getString("content"));
				i++;
			}
			if (i == 1) {
				System.out.println("No Notes available");
			}
		}
		catch (SQLException e){
			System.out.println("No Notes available");
		}
	   mainMenu(con,statement,pracid,chosen);		
	}
	public static int genID(Connection con, Statement statement,String Table) {
	      Random rd = new Random(); // creating Random object
	      int gen;
	      while(true) {
		      gen = rd.nextInt(100);
		      String query = "SELECT * FROM " + Table + " WHERE "+ Table + "id = '" + gen + "'";
			  try {
				java.sql.ResultSet rs = statement.executeQuery(query);
				int i = 1;
				while(rs.next()) {
					i++;
				}
				if (i == 1) {
					break;
				}
			} catch (SQLException e) {
				System.out.println("ERROR");
			}  
	      }
	      return gen;
	}
	
	
	public static void addNote(Connection con, Statement statement, String pracid, HashMap<String,String> chosen) {
		Scanner sc=new Scanner(System.in);  
		System.out.print("Type your observation: ");
		String obs= sc.nextLine(); 
        long millis=System.currentTimeMillis();  
        java.sql.Date NoteDate=new java.sql.Date(millis);  
        java.sql.Time NoteTime=new java.sql.Time(millis);  
        String appointid = chosen.get("appointid");
        int noteid = genID(con,statement,"note");
        String insertQ = "INSERT INTO note VALUES ('"+ noteid +"','"+ appointid + "',DATE'"+NoteDate+"',TIME'"+NoteTime+"','"+obs+"')";
        try {
			statement.executeUpdate (insertQ) ;
		} catch (SQLException e) {
			System.out.println("ERROR");
		}
	}
	
	public static void addTest(Connection con, Statement statement, String pracid, HashMap<String,String> chosen) {
		Scanner sc=new Scanner(System.in);  
		System.out.print("Please enter the type of test: ");
		String type= sc.nextLine(); 
        long millis=System.currentTimeMillis();  
        java.sql.Date prescribeDate=new java.sql.Date(millis);  
        String coupleid = chosen.get("coupleid");
        String pregnancyNo = chosen.get("pregnancyNo");
        int testid = genID(con,statement,"test");
        String insertQ = "INSERT INTO test VALUES ('"+ testid +"','"+ coupleid + "','" + pregnancyNo +"','" + pracid +"',NULL,NULL,'"+ type +
        		"',DATE'"+prescribeDate+"',DATE'"+prescribeDate+"',NULL,NULL)";
        try {
			statement.executeUpdate (insertQ) ;
		} catch (SQLException e) {
			System.out.println("ERROR");
		}
	}
	
	public static void reviewTests(Connection con, Statement statement, String pracid, HashMap<String,String> chosen) {
		String query = "SELECT prescribeddate, type, SUBSTRING(result,1,50) AS result " + 
				"FROM test " + 
				"WHERE babyid IS NULL AND coupleid = '" + chosen.get("coupleid") + "' AND pregnancyNo = '" + chosen.get("pregnancyNo") + "'"+
				" ORDER BY prescribeddate DESC";
		try {
		    java.sql.ResultSet rs = statement.executeQuery(query);
			int i = 1;
			while(rs.next()) {
				String res = rs.getString("result");
				if (res == null) {
					res = "PENDING";
				}
				System.out.println(rs.getString("prescribeddate") + "\t[" + rs.getString("type") + "]\t" + res);
				i++;
			}
			if (i == 1) {
				System.out.println("No Tests available");
			}
		}
		catch (SQLException e){
			System.out.println("No Tests available");
		}
	   mainMenu(con,statement,pracid,chosen);		
	}
	
	public static void mainMenu(Connection con, Statement statement, String pracid, HashMap<String,String> chosen) {
	      Scanner sc=new Scanner(System.in);  
	      System.out.println("For "+ chosen.get("name") + " " + chosen.get("qchc") + " :");
	      System.out.println("1. Review notes\n"+"2. Review tests\n"+"3. Add a note\n"+ "4. Prescribe a test\n" + "5. Go back to the appointments");
	      System.out.println("Enter your choice: ");
	      String input = sc.nextLine();
//	      if (input.equals("E")) {
//	    	  endConnection(con,statement);
//	      }
	      if (input.equals("1")) {
	    	  reviewNotes(con,statement,pracid,chosen);
	      }
	      else if (input.equals("2")) {
	    	  reviewTests(con,statement,pracid,chosen);
	      }
	      else if (input.equals("3")) {
	    	  addNote(con,statement,pracid,chosen);
	      }	      
	      else if (input.equals("4")) {
	    	  addTest(con,statement,pracid,chosen);
	      }
	      else if (input.equals("5")) {
	    	  chosen = askDate(con,statement,pracid);
	      }
	      else {
	    	  System.out.println("Invalid Input...Try Again");
	      }
	      mainMenu(con,statement,pracid,chosen);
	}

	public static void main ( String [ ] args ) throws SQLException
    {
      // Unique table names.  Either the user supplies a unique identifier as a command line argument, or the program makes one up.
        String tableName = "";
        int sqlCode=0;      // Variable to hold SQLCODE
        String sqlState="00000";  // Variable to hold SQLSTATE

        if ( args.length > 0 )
            tableName += args [ 0 ] ;
        else
          tableName += "exampletbl";

        // Register the driver.  You must register the driver before you can use it.
        try { DriverManager.registerDriver ( new com.ibm.db2.jcc.DB2Driver() ) ; }
        catch (Exception cnfe){ System.out.println("Class not found"); }

        // This is the url you must use for DB2.
        String url = "";

        //REMEMBER to remove your user id and password before submitting your code!!
        String your_userid = null;
        String your_password = null;
        if(your_userid == null)
        {
          System.err.println("Error!! do not have a password to connect to the database!");
          System.exit(1);
        }
        if(your_password == null)
        {
          System.err.println("Error!! do not have a password to connect to the database!");
          System.exit(1);
        }
        Connection con = DriverManager.getConnection (url,your_userid,your_password) ;
        Statement statement = con.createStatement ( ) ;
      
      String pracid = appStart(con, statement);
      HashMap<String,String> chosen = askDate(con,statement,pracid);
      mainMenu(con,statement,pracid,chosen);
      endConnection(con,statement);
    }	
	
}
