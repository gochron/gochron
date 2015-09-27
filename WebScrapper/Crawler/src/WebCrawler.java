import java.util.ArrayList;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;


public class WebCrawler {

	
	
	public static void main(String[] args){
		//ufcalendar();
		collegiatelink();
	}
	
	public static void collegiatelink(){
		WebDriver driver = new FirefoxDriver();
		ArrayList<Event> allEvents = new ArrayList<Event>();
		driver.get("https://ufl.collegiatelink.net/events");
		
		for(int j=0;j<20;j++){
		ArrayList<WebElement> event = (ArrayList<WebElement>)driver.findElements(By.className("col-sm-8"));
	    int count = event.size();
	    for(int i=1;i<count-1;i++){
	    	Event eve = new Event();
	    	String title = event.get(i).findElement(By.tagName("h4")).getText();
	    	System.out.println(title);
	    	eve.setTitle(title);
	    	
	    	String link = event.get(i).findElement(By.tagName("a")).getAttribute("href");
	    	eve.setLink(link);
	    	System.out.println(link);
	    	
	    	ArrayList<WebElement> temp = (ArrayList<WebElement>)event.get(i).findElements(By.tagName("p"));
	    	eve.setDate(temp.get(0).getText());
	    	System.out.println(temp.get(0).getText());
	    	
	    	eve.setCategory(temp.get(1).getText());
	    	System.out.println(temp.get(1).getText());
	    	
	    	eve.setEventDesc(temp.get(2).getText());
	    	System.out.println(temp.get(2).getText());
	    	
	    	allEvents.add(eve);
	    	
	    	}
	    try{
	    	WebElement pager = (WebElement)driver.findElement(By.id("pager"));
	    	WebElement button = (WebElement)pager.findElement(By.partialLinkText("Next"));
	    	button.click();
	    	Thread.sleep(5000);
	    }catch(Exception e){
	    	j = 21;
	    }
		}
		System.out.println(allEvents.size());
		
		for(int i=0;i<allEvents.size();i++){
			driver.get(allEvents.get(i).getLink());
			try{
			ArrayList<WebElement> locs = (ArrayList<WebElement>)driver.findElements(By.className("__sectionmargintophalf")); 
			String location = locs.get(1).getText();
			allEvents.get(i).setLocation(location);
			}catch(Exception e){
				allEvents.get(i).setLocation("");
			}
			DAO.AddEvent(allEvents.get(i));
		}
	}
	
	
}