package myCart.learn.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import myCart.learn.dao.UserDao;
import myCart.learn.helper.FactoryProviderHelper;
import myCart.user.Entity.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			String email = request.getParameter("email");
			String password = request.getParameter("password");

			System.out.println("Email provided by the user: " + email);
			System.out.println("Password provided by the user: " + password);
			// Validate inputs (you might want to add more validation)
			if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
				out.println("Invalid email or password");
				return;
			}

			// Authenticating user
			UserDao userDao = new UserDao(FactoryProviderHelper.getSessionFactory());
			User user = userDao.getUserByEmailAndPassword(email, password);
			System.out.println("User Info Fetched from DB : " + user);
			HttpSession session=request.getSession();
			if (user != null) {
//				System.out.println("LoginServlet.processRequest()");
//				// Authentication successful, set session attributes or redirect
//				request.getSession().setAttribute("user", user);
//				response.sendRedirect("register.jsp"); // replace with your actual redirect page
				out.println("<h1>Welcome "+user.getUserName()+" </h1>");
				
				//login
				session.setAttribute("current_user", user);
				
				//admin user
				if(user.getUserType().equals("admin")) { //admin user key
					response.sendRedirect("admin.jsp");
				} else if(user.getUserType().equals("normal_User")) { //normal user key
					response.sendRedirect("normal.jsp");
				} else {
					out.println("Unable to identify the user!!");
				}
				//normal user
				
			} else {
				// Authentication failed
				out.println("Invalid email or password");
				session.setAttribute("message", "Invalid Details!!!");
				response.sendRedirect("login.jsp");
				return;
			}
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}
}
