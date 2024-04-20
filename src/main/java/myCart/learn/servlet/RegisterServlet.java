package myCart.learn.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.Transaction;

import myCart.learn.helper.FactoryProviderHelper;
import myCart.user.Entity.User;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			try {
				String userName = request.getParameter("user_name");

				String userEmail = request.getParameter("user_email");

				String userPassword = request.getParameter("user_password");

				String userPhone = request.getParameter("user_phone");

				String userAddress = request.getParameter("user_address");

				// server side validation
				if (userName.isEmpty()) {
					out.println("Name is blank, please provide a name to proceed.....");
					return;
				}

				// Creating user object to create data
				User user = new User(userName, userEmail, userPassword, userPhone, "default.jpg", userAddress,
						"normal_User");

				// Storing data in hibernate
				Session hibernateSession = FactoryProviderHelper.getSessionFactory().openSession();
				Transaction tx = hibernateSession.beginTransaction();

				int userId = (int) hibernateSession.save(user);
				tx.commit();
				hibernateSession.close();

//				out.println("User Info has been successfully saved.....");
//				out.println("<br> User id is : "+userId);

				HttpSession httpSession = request.getSession();
				httpSession.setAttribute("message", "Registration Successful !! " + userId);
				response.sendRedirect("register.jsp");
				return;
			} catch (Exception e) {
				e.printStackTrace();
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
