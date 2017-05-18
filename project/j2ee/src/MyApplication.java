import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by cl43 on 5/11/2017.
 */
@ApplicationPath("/")
public class MyApplication extends Application{
    @Override
    /*The method returns a non-empty collection with classes, that must be included in the published JAX-RS application*/
    public Set<Class<?>> getClasses() {
        HashSet h = new HashSet<Class<?>>();
        h.add( SHBSResource.class );
        return h;
    }
}
