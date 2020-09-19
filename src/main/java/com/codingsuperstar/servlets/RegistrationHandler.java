package com.codingsuperstar.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegistrationHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String returnString = "<html><body><table>"
				+ "<tr><td>Name:</td><td>" + request.getParameter("textnames") + "</td></tr>"
				+ "<tr><td>Father's Name:</td><td>" + request.getParameter("fathername") + "</td></tr>"
				+ "<tr><td>Postal Address:</td><td>" + request.getParameter("paddress") + "</td></tr>"
				+ "<tr><td>Personal Address:</td><td>" + request.getParameter("personaladdress") + "</td></tr>"
				+ "<tr><td>Sex:</td><td>" + request.getParameter("sex") + "</td></tr>"
				+ "<tr><td>City:</td><td>" + request.getParameter("City") + "</td></tr>"
				+ "<tr><td>Course:</td><td>" + request.getParameter("Course") + "</td></tr>"
				+ "<tr><td>District:</td><td>" + request.getParameter("District") + "</td></tr>"
				+ "<tr><td>State:</td><td>" + request.getParameter("State") + "</td></tr>"
				+ "<tr><td>PINcode:</td><td>" + request.getParameter("pincode") + "</td></tr>"
				+ "<tr><td>Email:</td><td>" + request.getParameter("emailid") + "</td></tr>"
				+ "<tr><td>DOB:</td><td>" + request.getParameter("dob") + "</td></tr>"
				+ "<tr><td>Mobile:</td><td>" + request.getParameter("mobileno") + "</td></tr>"
				+ "</table></body></html>";
		
		response.getWriter().append(returnString);
	}

}
