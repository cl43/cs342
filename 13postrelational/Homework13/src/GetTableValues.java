import oracle.kv.*;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.Map;


/**
 * Created by cl43 on 5/9/2017.
 */
public class GetTableValues {

    public static void main(String[] args) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        LoadDB.load(store);
        output(store);
        store.close();
    }

    public static void output(KVStore store){
        System.out.println("Table: movie\nID: 92616");
        Key majorKeyPathOnly = Key.createKey(Arrays.asList("movie", "92616"));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
        String fieldName = null, fieldYear = null, fieldRank = null;
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            if(field.getKey().getMinorPath().get(0).equals("name")){
                fieldName = new String(field.getValue().getValue().getValue());
            }
            if(field.getKey().getMinorPath().get(0).equals("year")){
                fieldYear = new String(field.getValue().getValue().getValue());
            }
            if(field.getKey().getMinorPath().get(0).equals("rank")){
                fieldRank = new String(field.getValue().getValue().getValue());
            }
        }
        System.out.println("\t" + fieldName + "\t: " + fieldYear + "\t: " + fieldRank);
    }
}