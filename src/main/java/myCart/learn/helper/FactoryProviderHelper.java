
package myCart.learn.helper;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class FactoryProviderHelper {

    private static SessionFactory factory;

    public static SessionFactory getSessionFactory() {
        try {
            if (factory == null) {
                // Load configuration from hibernate.cfg.xml
                Configuration configuration = new Configuration().configure("hibernate.cfg.xml");

                // Build the SessionFactory
                factory = configuration.buildSessionFactory();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("factory : "+factory);
        return factory;
    }
}
