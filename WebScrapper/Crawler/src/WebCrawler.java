import java.util.ArrayList;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;


public class WebCrawler {

	
	
	public static void main(String[] args){
		ufcalendar();
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
	
	public static void ufcalendar(){
		WebDriver driver = new FirefoxDriver();
		driver.get("http://calendar.ufl.edu/?view=all&month=09&day=10&year=2015&");
		ArrayList<WebElement> eventdate = (ArrayList<WebElement>)driver.findElements(By.className("eventdate"));
		ArrayList<WebElement> event = (ArrayList<WebElement>)driver.findElements(By.className("event"));
		ArrayList<Event> allEvents = new ArrayList<Event>(); 
		int count = eventdate.size();
		for(int i = 0; i<count; i++){
			Event eve = new Event();
			try{
			eve.setDate(eventdate.get(i).getText());
			//System.out.println(eventdate.get(i).getText());
			
			WebElement eventDetail = event.get(i).findElement(By.className("eventtitle"));
			eve.setTitle(eventDetail.getText());
			eve.setLink(eventDetail.findElement(By.tagName("a")).getAttribute("href"));
			//System.out.println(eventDetail.findElement(By.tagName("a")).getAttribute("href"));
			//System.out.println(eventDetail.getText());
			
			eve.setEventDesc(event.get(i).findElement(By.className("description")).getText());
			//System.out.println(event.get(i).findElement(By.className("description")).getText());
			
			ArrayList<WebElement> info = (ArrayList<WebElement>) event.get(i).findElements(By.tagName("dd"));
			eve.setEventTime(info.get(0).getText());
			//System.out.println(info.get(0).getText());
			
			try{
			eve.setCategory(info.get(1).getText());
			//System.out.println(info.get(1).getText());
			}catch(Exception e){
				eve.setCategory("");
			}
			allEvents.add(eve);
			}catch(Exception e){
				continue;
			}
		}
		
		int totalLink = allEvents.size();
		for(int i = 0; i < totalLink; i++){
			driver.get(allEvents.get(i).getLink());
			WebElement detail = driver.findElement(By.className("clearfix"));
			try{
			ArrayList<WebElement> links = (ArrayList<WebElement>) detail.findElements(By.tagName("a"));
			//System.out.println(links.get(0).getText());
			allEvents.get(i).setContactPerson(links.get(0).getText());
			String[] email = links.get(0).getAttribute("href").split(":");
			//System.out.println(email[1]);
			allEvents.get(i).setEmailId(email[1]);
			allEvents.get(i).setContactPerson(email[0]);
			}catch(Exception e){
				System.out.println("Error 1");
			}
			
			try{
			String fulldetail = detail.getText();
			String[] data = fulldetail.split("Location:");
			String[] loc = data[1].split("Download iCalendar");
			//System.out.println(loc[0]);
			allEvents.get(i).setLocation(loc[0]);
			}catch(Exception e){
				System.out.println("Error 2");
			}
			DAO.AddEvent(allEvents.get(i));
		}
	}
	
}