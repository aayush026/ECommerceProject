package myCart.learn.dao;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import myCart.user.Entity.User;

public class UserDao {
    private SessionFactory factory;

    public UserDao(SessionFactory factory) {
        this.factory = factory;
    }

    // Get user by email and password
    public User getUserByEmailAndPassword(String email, String password) {
        User user = null;
System.out.println("UserDao.getUserByEmailAndPassword() : email: "+email+" password : "+password);
        try (Session session = this.factory.openSession()) {
            String query = "from User where userEmail =: e and userPassword =: p";
            Query q = session.createQuery(query);
            q.setParameter("e", email);
            q.setParameter("p", password);

            user = (User) q.uniqueResult();
        } catch (HibernateException e) {
            e.printStackTrace();
        }

        return user;
    }
}
