import java.sql.Connection;  
import java.sql.DriverManager;  
import java.sql.PreparedStatement;  
import java.sql.ResultSet;  
import java.sql.SQLException; 

  
public class DAO {  
    public static void AddEvent(Event eve) {  
    	System.out.println("I am in DAO : "+eve.getTitle());
  
        String url = "jdbc:mysql://localhost:3306/";  
        String dbName = "form";  
        String driver = "com.mysql.jdbc.Driver";  
        String userName = "root";  
        String password = "Shaan@123";  
        
        Connection conn = null;  
        PreparedStatement pst = null;  
        ResultSet rs = null;  
        
        try {  
            Class.forName(driver).newInstance();  
            
            conn = DriverManager  
                    .getConnection(url + dbName, userName, password);
            
            String query = "INSERT into sakila.events (date, title, eventDesc, location, eventTime, category, link, contactPerson, emailId) values ('"+eve.getDate()+"','"+eve.getTitle()+"','"+eve.getEventDesc()+"','"+eve.getLocation()+"','"+eve.getEventTime()+"','"+eve.getCategory()+"','"+eve.getLink()+"','"+eve.getContactPerson()+"','"+eve.getEmailId()+"')";
            System.out.println(query);
            
            pst = conn  
                    .prepareStatement(query);
            pst.executeUpdate(); 
  
        } catch (Exception e) {  
            System.out.println(e);  
        } finally {  
            if (conn != null) {  
                try {  
                    conn.close();  
                } catch (SQLException e) {  
                    e.printStackTrace();  
                }  
            }  
            if (pst != null) {  
                try {  
                    pst.close();  
                } catch (SQLException e) {  
                    e.printStackTrace();  
                }  
            }  
            if (rs != null) {  
                try {  
                    rs.close();  
                } catch (SQLException e) {  
                    e.printStackTrace();  
                }  
            }  
        }    
    }
}