package myCart.learn.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import myCart.learn.dao.CategoryDao;
import myCart.learn.dao.ProductDao;
import myCart.learn.helper.FactoryProviderHelper;
import myCart.user.Entity.Category;
import myCart.user.Entity.Product;

@WebServlet("/ProductionOperationServlet")
@MultipartConfig
public class ProductionOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ProductionOperationServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// doGet(request, response);
		try (PrintWriter out = response.getWriter()) {
			String op = request.getParameter("operation");
			System.out.println("Parameter from admin page : " + op);
			if (op.trim().equals("addCategory")) {
				// add Category
				String title = request.getParameter("catTitle");
				String description = request.getParameter("catDescription");

				Category category = new Category();
				category.setCategoryTitle(title);
				category.setCategoryDescription(description);

				CategoryDao dao = new CategoryDao(FactoryProviderHelper.getSessionFactory());
				// category to save in DB
				int categoryId = dao.saveCategory(category);
				System.out.println("categoryId : " + categoryId);
				out.println("Category Saved.....");

				HttpSession session = request.getSession();
				session.setAttribute("message", "Category added Successfully : " + categoryId);
				response.sendRedirect("admin.jsp");
				return;
			} else if (op.trim().equals("addproduct")) {
				// add Product
				System.out.println("Adding Product");
				String pName = request.getParameter("productName");
				System.out.println("pName : " + pName);
				String pDesc = request.getParameter("productDescription");
				System.out.println("pDesc : " + pDesc);
				int pPrice = Integer.parseInt(request.getParameter("productPrice"));
				System.out.println("pPrice : " + pPrice);
				int pDiscount = Integer.parseInt(request.getParameter("productDiscount"));
				System.out.println("pDiscount : " + pDiscount);
				int pQuantity = Integer.parseInt(request.getParameter("productQuantity"));
				System.out.println("pQuantity : " + pQuantity);
				int catId = Integer.parseInt(request.getParameter("catId"));
				System.out.println("catId : " + catId);
				Part part = request.getPart("productPhoto");
				System.out.println("part : " + part);
				// storing in DB
				Product p = new Product();
				p.setProductName(pName);
				p.setProductDesc(pDesc);
				p.setProductPrice(pPrice);
				p.setProductDiscount(pDiscount);
				p.setProductQuantity(pQuantity);
				p.setProductPhoto(part.getSubmittedFileName());

				System.out.println("Products......");

				// get category by id
				CategoryDao cdao = new CategoryDao(FactoryProviderHelper.getSessionFactory());
				Category category = cdao.getCategoryById(catId);
				System.out.println("category fetched in product : " + category);

				p.setCategory(category);

				// save product
				ProductDao pdao = new ProductDao(FactoryProviderHelper.getSessionFactory());
				pdao.saveProduct(p);

				// pic upload
				// find out the path to upload photo
				String path = request.getRealPath("image") + File.separator + "products" + File.separator
						+ part.getSubmittedFileName();
				System.out.println("path : " + path);

				// uploading file
				FileOutputStream fos = new FileOutputStream(path);
				InputStream is = part.getInputStream();

				// reading data
				byte[] data = new byte[is.available()];
				is.read(data);

				// Writing the data
				fos.write(data);
				fos.close();

				HttpSession session = request.getSession();
				session.setAttribute("message", "Product added Successfully : ");
				response.sendRedirect("admin.jsp");
			}
		}
	}
}
