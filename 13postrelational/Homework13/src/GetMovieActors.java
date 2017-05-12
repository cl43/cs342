import oracle.kv.*;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;


/**
 * Created by cl43 on 5/9/2017.
 */
public class GetMovieActors {

    public static void main(String[] args) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        LoadDB.load(store);
        output(store);
        store.close();
    }

    public static void output(KVStore store){
        System.out.println("Movie ID: 92616");
        Key majorKeyPathOnly = Key.createKey(Arrays.asList("movie", "92616"), Arrays.asList("actor"));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
        String fieldFName = " ", fieldLName = " ";
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String actorid = field.getKey().getMinorPath().get(1);
            Key actorKey = Key.createKey(Arrays.asList("actor", actorid));
            Map<Key, ValueVersion> actorField = store.multiGet(actorKey, null, null);
            for (Map.Entry<Key, ValueVersion> field2 : actorField.entrySet()) {
                if(field2.getKey().getMinorPath().get(0).equals("firstName")){
                    fieldFName = new String(field2.getValue().getValue().getValue());
                }
                if(field2.getKey().getMinorPath().get(0).equals("lastName")){
                    fieldLName = new String(field2.getValue().getValue().getValue());
                }
            }
            String[] roleArray = new String(field.getValue().getValue().getValue()).split(": ");
            for(String role : roleArray) {
                System.out.println("\t" + actorid + "\t: " + fieldFName + " " + fieldLName + "\t: " + role);
            }
        }
    }
}
