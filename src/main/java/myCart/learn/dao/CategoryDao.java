package myCart.learn.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import myCart.user.Entity.Category;

public class CategoryDao {

	private SessionFactory factory;

	public CategoryDao(SessionFactory factory) {
		this.factory = factory;
	}
	
	public int saveCategory(Category category) {
		Session session=this.factory.openSession();
		Transaction tx=session.beginTransaction();
		int categoryId=(int) session.save(category);
		tx.commit();
		session.close();
		return categoryId;
	}
	
	public List<Category> getCategories(){
		Session session=this.factory.openSession();
		Query query=session.createQuery("from Category");
		List<Category> list=query.list();
		return list;
	}
	
	public Category getCategoryById(int cid) {
	    System.out.println("CategoryDao.getCategoryById()");
	    Category cat = null;
	    try (Session session = this.factory.openSession()) {
	        cat = session.get(Category.class, cid);
	    } catch (Exception e) {
	        // Log the exception or handle it appropriately
	        e.printStackTrace();
	    }
	    System.out.println("cat : " + cat);
	    return cat;
	}

}
