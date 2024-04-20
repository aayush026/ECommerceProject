package myCart.learn.dao;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import myCart.user.Entity.Product;

public class ProductDao {

	private SessionFactory factory;

	public ProductDao(SessionFactory factory) {
		this.factory = factory;
	}
	
	public boolean saveProduct(Product product) {
		boolean flag=false;
		try {
		Session session=this.factory.openSession();
		Transaction tx=session.beginTransaction();
		 session.save(product);
		tx.commit();
		session.close();
		flag=true;
	
	}catch(Exception e) {
		e.printStackTrace();
		flag=false;
	}
		return flag;
}
	
	//get All products
	public List<Product> getAllProducts(){
		Session session=this.factory.openSession();
	    Query query=session.createQuery("from Product");
	    List<Product> list=query.list();
	    return list;
	}
	
	//get All products by category id
		public List<Product> getAllProductsById(int cid){
			Session session=this.factory.openSession();
		    Query query=session.createQuery("from Product as p where p.category.categoryId= :id");
		    query.setParameter("id", cid);
		    List<Product> list=query.list();
		    return list;
		}
	
}
