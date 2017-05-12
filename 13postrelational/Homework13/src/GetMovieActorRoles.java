import oracle.kv.*;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;


/**
 * Created by cl43 on 5/9/2017.
 */
public class GetMovieActorRoles {

    public static void main(String[] args) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        LoadDB.load(store);
        output(store);
        store.close();
    }

    public static void output(KVStore store){
        System.out.println("Movie ID: 92616\nActor ID: 429719");
        Key majorKeyPathOnly = Key.createKey(Arrays.asList("movie", "92616"), Arrays.asList("actor", "429719"));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String role = new String(field.getValue().getValue().getValue());
            String[] roleArray = role.split(": ");
            for(String roles : roleArray){
                System.out.println("\t" + roles);
            }

        }
    }
}
