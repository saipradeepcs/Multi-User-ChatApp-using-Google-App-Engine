package com.myapp;

import java.io.IOException;
import java.util.HashSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.channel.ChannelService;
import com.google.appengine.api.channel.ChannelServiceFactory;
import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

@SuppressWarnings("serial")
public class HomeServlet extends HttpServlet {
	private static HashSet<String> users = new HashSet<String>();
	UserService userService = UserServiceFactory.getUserService();
	String key = "chatHistory";
	String value;
	boolean admin;
	MemcacheService syncCache = MemcacheServiceFactory.getMemcacheService();

	  
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		

		String thisURL = req.getRequestURI();

		resp.setContentType("text/html");
		if (req.getUserPrincipal() != null) {
			req.setAttribute("logininfo", "<p>Hello, " +
					userService.getCurrentUser().getNickname() +
					"!  You can <a href=\"" +
					userService.createLogoutURL(thisURL) +
					"\">sign out</a>.</p>");
			ChannelService channelService = ChannelServiceFactory.getChannelService();
			String clientId =req.getUserPrincipal().getName();
			String token = channelService.createChannel(clientId);
			req.setAttribute("token", token );
		    admin = userService.isUserAdmin();
		    req.setAttribute("isadmin", admin);
		    req.setAttribute("showUpload", !admin);
			if(users.isEmpty()){syncCache.put(key,"\n");}
			req.setAttribute("chatHistory", syncCache.get(key));
			if (!syncCache.contains(key)){
				syncCache.put(key,"\n");
			}
			users.add(clientId);
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/home.jsp");
			dispatcher.forward(req, resp);    
		} else {
			 resp.getWriter().println("<p>Please <a href=\"" +
					userService.createLoginURL(thisURL) +
					"\">sign in</a>.</p>");
			
		}


	}

}
